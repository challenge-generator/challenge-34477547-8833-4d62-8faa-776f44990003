import 'dart:async';

import 'package:finance_app/data/datasources/remote_account_datasource.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/entities/balance.dart';
import 'package:finance_app/domain/repositories/account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  final RemoteAccountDataSource _remoteDataSource;
  final Map<String, Balance> _balances = {};
  final StreamController<Account> _changes =
      StreamController<Account>.broadcast();

  AccountRepositoryImpl({
    required RemoteAccountDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  List<Object?> get props => [_remoteDataSource];

  Future<T> _guard<T>(String action, Future<T> Function() body) async {
    try {
      return await body();
    } on DataSourceException catch (e) {
      throw RepositoryException(
        message: 'Error al $action: ${e.message}',
        originalError: e,
      );
    } on NetworkException catch (e) {
      throw RepositoryException(
        message: 'Error de red al $action: ${e.message}',
        originalError: e,
      );
    } on ValidationException catch (e) {
      throw RepositoryException(
        message: 'Validación fallida al $action: ${e.message}',
        originalError: e,
      );
    } on NotFoundException catch (e) {
      throw RepositoryException(
        message: 'Recurso no encontrado al $action: ${e.message}',
        originalError: e,
      );
    }
  }

  @override
  Future<List<Account>> getAccountsByUser(String userId) {
    return _guard('obtener cuentas del usuario', () async {
      final models = await _remoteDataSource.fetchAccountsByUserId(userId);
      return models.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Account?> getAccountById(String id) {
    return _guard('obtener la cuenta', () async {
      final model = await _remoteDataSource.fetchAccountById(id);
      return model?.toEntity();
    });
  }

  @override
  Future<Account> createAccount(Account account) {
    return _guard('crear la cuenta', () async {
      final model = await _remoteDataSource.createAccount(account);
      final created = model.toEntity();
      _changes.add(created);
      return created;
    });
  }

  @override
  Future<Account> updateAccount(Account account) {
    return _guard('actualizar la cuenta', () async {
      final model = await _remoteDataSource.updateAccount(account);
      final updated = model.toEntity();
      _changes.add(updated);
      return updated;
    });
  }

  @override
  Future<void> deleteAccount(String id) {
    return _guard('eliminar la cuenta', () async {
      await _remoteDataSource.deleteAccount(id);
      _balances.remove(id);
    });
  }

  @override
  Future<Balance?> getAccountBalance(String accountId) async {
    return _balances[accountId];
  }

  @override
  Future<Balance> updateAccountBalance(String accountId, Balance balance) async {
    _balances[accountId] = balance;
    return balance;
  }

  @override
  Future<List<Account>> getAccountsByType(String userId, AccountType type) async {
    final accounts = await getAccountsByUser(userId);
    return accounts.where((a) => a.type == type).toList();
  }

  @override
  Future<bool> accountExists(String accountId) async {
    return (await getAccountById(accountId)) != null;
  }

  @override
  Future<double> getTotalBalanceByUser(String userId) async {
    final accounts = await getAccountsByUser(userId);
    return accounts.fold<double>(
      0.0,
      (sum, a) => sum + (_balances[a.id]?.currentBalance ?? a.initialBalance),
    );
  }

  @override
  Future<void> transferBetweenAccounts(
    String fromAccountId,
    String toAccountId,
    double amount,
  ) async {
    final from = await getAccountById(fromAccountId);
    final to = await getAccountById(toAccountId);
    if (from == null || to == null) {
      throw RepositoryException(message: 'Cuenta de origen o destino no encontrada');
    }

    final fromBalance = _balances[from.id] ?? _initialBalanceFor(from);
    if (!fromBalance.canAfford(amount)) {
      throw RepositoryException(message: 'Saldo insuficiente para la transferencia');
    }
    final toBalance = _balances[to.id] ?? _initialBalanceFor(to);

    _balances[from.id] = fromBalance.copyWith(
      currentBalance: fromBalance.currentBalance - amount,
      expenses: fromBalance.expenses + amount,
      date: DateTime.now(),
    );
    _balances[to.id] = toBalance.copyWith(
      currentBalance: toBalance.currentBalance + amount,
      income: toBalance.income + amount,
      date: DateTime.now(),
    );
  }

  @override
  Future<List<Account>> searchAccounts(String userId, String query) async {
    final accounts = await getAccountsByUser(userId);
    final lowered = query.toLowerCase();
    return accounts.where((a) => a.name.toLowerCase().contains(lowered)).toList();
  }

  @override
  Stream<Account> watchAccount(String accountId) {
    return _changes.stream.where((a) => a.id == accountId);
  }

  @override
  Stream<List<Account>> watchAccountsByUser(String userId) {
    return _changes.stream
        .where((a) => a.userId == userId)
        .asyncMap((_) => getAccountsByUser(userId));
  }

  Balance _initialBalanceFor(Account account) {
    return Balance(
      id: 'initial_${account.id}',
      accountId: account.id,
      currentBalance: account.initialBalance,
      date: DateTime.now(),
      income: 0,
      expenses: 0,
      currency: account.currency,
    );
  }
}

class RepositoryException implements Exception {
  final String message;
  final Object? originalError;

  const RepositoryException({
    required this.message,
    this.originalError,
  });

  @override
  String toString() => 'RepositoryException: $message';
}
