package finance_app.data.repositories;

import 'package:finance_app/data/datasources/remote_account_datasource.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/repositories/account_repository.dart';
import 'package:equatable/equatable.dart';

class AccountRepositoryImpl implements AccountRepository {
  final RemoteAccountDataSource _remoteDataSource;
  final List<Account> _cache = [];
  bool _isCacheValid = false;

  AccountRepositoryImpl({
    required RemoteAccountDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<List<Account>> getAccounts() async {
    if (_isCacheValid && _cache.isNotEmpty) {
      return List.unmodifiable(_cache);
    }

    try {
      final accountModels = await _remoteDataSource.fetchAccounts();
      _cache.clear();
      _cache.addAll(accountModels);
      _isCacheValid = true;
      return List.unmodifiable(_cache);
    } on DataSourceException catch (e) {
      throw RepositoryException(
        message: 'Error al obtener cuentas: ${e.message}',
        originalError: e,
      );
    } on NetworkException catch (e) {
      throw RepositoryException(
        message: 'Error de red al obtener cuentas: ${e.message}',
        originalError: e,
      );
    }
  }

  @override
  Future<Account?> getAccountById(String id) async {
    final cached = _cache.where((a) => a.id == id).firstOrNull;
    if (cached != null && _isCacheValid) {
      return cached;
    }

    try {
      final accountModel = await _remoteDataSource.fetchAccountById(id);
      if (accountModel != null) {
        final existingIndex = _cache.indexWhere((a) => a.id == id);
        if (existingIndex >= 0) {
          _cache[existingIndex] = accountModel;
        } else {
          _cache.add(accountModel);
        }
      }
      return accountModel;
    } on DataSourceException catch (e) {
      throw RepositoryException(
        message: 'Error al obtener cuenta por ID: ${e.message}',
        originalError: e,
      );
    }
  }

  @override
  Future<Account> createAccount(Account account) async {
    try {
      final createdAccount = await _remoteDataSource.createAccount(account);
      _cache.add(createdAccount);
      _invalidateCache();
      return createdAccount;
    } on DataSourceException catch (e) {
      throw RepositoryException(
        message: 'Error al crear cuenta: ${e.message}',
        originalError: e,
      );
    } on ValidationException catch (e) {
      throw RepositoryException(
        message: 'Validación fallida al crear cuenta: ${e.message}',
        originalError: e,
      );
    }
  }

  @override
  Future<Account> updateAccount(Account account) async {
    try {
      final updatedAccount = await _remoteDataSource.updateAccount(account);
      final index = _cache.indexWhere((a) => a.id == account.id);
      if (index >= 0) {
        _cache[index] = updatedAccount;
      }
      _invalidateCache();
      return updatedAccount;
    } on DataSourceException catch (e) {
      throw RepositoryException(
        message: 'Error al actualizar cuenta: ${e.message}',
        originalError: e,
      );
    } on NotFoundException catch (e) {
      throw RepositoryException(
        message: 'Cuenta no encontrada para actualizar: ${e.message}',
        originalError: e,
      );
    }
  }

  @override
  Future<void> deleteAccount(String id) async {
    try {
      await _remoteDataSource.deleteAccount(id);
      _cache.removeWhere((a) => a.id == id);
      _invalidateCache();
    } on DataSourceException catch (e) {
      throw RepositoryException(
        message: 'Error al eliminar cuenta: ${e.message}',
        originalError: e,
      );
    } on NotFoundException catch (e) {
      throw RepositoryException(
        message: 'Cuenta no encontrada para eliminar: ${e.message}',
        originalError: e,
      );
    }
  }

  @override
  Future<List<Account>> getAccountsByUserId(String userId) async {
    try {
      final allAccounts = await getAccounts();
      return allAccounts.where((a) => a.userId == userId).toList();
    } catch (e) {
      if (e is RepositoryException) rethrow;
      throw RepositoryException(message: 'Error al filtrar cuentas por usuario');
    }
  }

  @override
  Future<void> invalidateCache() async {
    _invalidateCache();
  }

  void _invalidateCache() {
    _isCacheValid = false;
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

class DataSourceException implements Exception {
  final String message;
  final int? statusCode;

  const DataSourceException({required this.message, this.statusCode});

  @override
  String toString() => 'DataSourceException: $message (status: $statusCode)';
}

class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  const NetworkException({required this.message, this.statusCode});

  @override
  String toString() => 'NetworkException: $message';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String>? fieldErrors;

  const ValidationException({required this.message, this.fieldErrors});

  @override
  String toString() => 'ValidationException: $message';
}

class NotFoundException implements Exception {
  final String message;
  final String? resourceId;

  const NotFoundException({required this.message, this.resourceId});

  @override
  String toString() => 'NotFoundException: $message';
}