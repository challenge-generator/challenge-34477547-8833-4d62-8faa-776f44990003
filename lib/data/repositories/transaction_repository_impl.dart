import 'dart:async';

import 'package:finance_app/data/datasources/local_transaction_datasource.dart';
import 'package:finance_app/data/models/transaction_model.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl extends TransactionRepository {
  final LocalTransactionDataSource _localDataSource;
  final StreamController<Transaction> _changes =
      StreamController<Transaction>.broadcast();

  TransactionRepositoryImpl(this._localDataSource);

  @override
  List<Object?> get props => [_localDataSource];

  @override
  Future<List<Transaction>> getTransactionsByAccount(String accountId) async {
    final models = await _localDataSource.getTransactionsByAccountId(accountId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<Transaction?> getTransactionById(String id) async {
    final model = await _localDataSource.getTransactionById(id);
    return model?.toEntity();
  }

  @override
  Future<Transaction> createTransaction(Transaction transaction) async {
    final saved = await _localDataSource.insertTransaction(
      TransactionModel.fromEntity(transaction),
    );
    final entity = saved.toEntity();
    _changes.add(entity);
    return entity;
  }

  @override
  Future<Transaction> updateTransaction(Transaction transaction) async {
    final saved = await _localDataSource.updateTransaction(
      TransactionModel.fromEntity(transaction),
    );
    final entity = saved.toEntity();
    _changes.add(entity);
    return entity;
  }

  @override
  Future<void> deleteTransaction(String id) {
    return _localDataSource.deleteTransaction(id);
  }

  @override
  Future<List<Transaction>> getTransactionsByDateRange(
    String accountId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final models = await _localDataSource.getTransactionsByDateRange(
      startDate,
      endDate,
    );
    return models
        .where((m) => m.accountId == accountId)
        .map((m) => m.toEntity())
        .toList();
  }

  @override
  Future<List<Transaction>> getTransactionsByCategory(
    String accountId,
    String category,
  ) async {
    final models = await _localDataSource.getTransactionsByCategory(category);
    return models
        .where((m) => m.accountId == accountId)
        .map((m) => m.toEntity())
        .toList();
  }

  @override
  Future<double> getTotalAmountByType(
    String accountId,
    TransactionType type,
  ) async {
    final transactions = await getTransactionsByAccount(accountId);
    return transactions
        .where((t) =>
            t.type == type && t.status == TransactionStatus.completed)
        .fold<double>(0.0, (sum, t) => sum + t.amount);
  }

  @override
  Future<List<Transaction>> getPendingTransactions(String accountId) async {
    final transactions = await getTransactionsByAccount(accountId);
    return transactions
        .where((t) => t.status == TransactionStatus.pending)
        .toList();
  }

  @override
  Future<void> processTransactionBatch(List<Transaction> transactions) async {
    for (final transaction in transactions) {
      await createTransaction(transaction);
    }
  }

  @override
  Stream<Transaction> watchTransactions(String accountId) {
    return _changes.stream.where((t) => t.accountId == accountId);
  }
}
