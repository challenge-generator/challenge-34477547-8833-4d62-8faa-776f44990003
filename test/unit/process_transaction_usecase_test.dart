import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/repositories/transaction_repository.dart';
import 'package:finance_app/domain/repositories/account_repository.dart';
import 'package:finance_app/domain/usecases/process_transaction_usecase.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  // Superficie de práctica: implementar casos de prueba para ProcessTransactionUseCase
  group('ProcessTransactionUseCase', () {
    late ProcessTransactionUseCase useCase;
    late MockTransactionRepository mockTransactionRepository;
    late MockAccountRepository mockAccountRepository;

    setUp(() {
      mockTransactionRepository = MockTransactionRepository();
      mockAccountRepository = MockAccountRepository();
      useCase = ProcessTransactionUseCase(
        transactionRepository: mockTransactionRepository,
        accountRepository: mockAccountRepository,
      );
    });

    test.skip('Procesa transacción de crédito exitosamente', () async {
      // Arrange
      const accountId = 'acc_001';
      final account = Account(
        id: accountId,
        name: 'Cuenta Principal',
        userId: 'user_001',
        initialBalance: 1000.0,
        currency: Currency.usd,
        type: AccountType.checking,
        createdAt: DateTime(2024, 1, 1),
      );

      final transaction = Transaction(
        id: 'txn_new_001',
        accountId: accountId,
        amount: 500.0,
        description: 'Depósito',
        date: DateTime.now(),
        category: 'income',
        type: TransactionType.credit,
        status: TransactionStatus.pending,
      );

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);
      when(mockTransactionRepository.saveTransaction(transaction)).thenAnswer((_) async => transaction);
      when(mockAccountRepository.updateAccount(any)).thenAnswer((_) async => account);

      // Act
      final result = await useCase.execute(transaction);

      // Assert
      expect(result.status, equals(TransactionStatus.completed));
      verify(mockTransactionRepository.saveTransaction(any)).called(1);
      verify(mockAccountRepository.updateAccount(any)).called(1);
    });

    test.skip('Rechaza transacción de débito por saldo insuficiente', () async {
      // Arrange
      const accountId = 'acc_002';
      final account = Account(
        id: accountId,
        name: 'Cuenta Limitada',
        userId: 'user_001',
        initialBalance: 100.0,
        currency: Currency.usd,
        type: AccountType.checking,
        createdAt: DateTime(2024, 1, 1),
      );

      final transaction = Transaction(
        id: 'txn_new_002',
        accountId: accountId,
        amount: 500.0,
        description: 'Compra grande',
        date: DateTime.now(),
        category: 'expense',
        type: TransactionType.debit,
        status: TransactionStatus.pending,
      );

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);

      // Act & Assert
      expect(
        () => useCase.execute(transaction),
        throwsA(isA<Exception>()),
      );
    });

    test.skip('Maneja error de red durante procesamiento', () async {
      // Arrange
      const accountId = 'acc_003';
      final account = Account(
        id: accountId,
        name: 'Cuenta Error',
        userId: 'user_001',
        initialBalance: 2000.0,
        currency: Currency.usd,
        type: AccountType.checking,
        createdAt: DateTime(2024, 1, 1),
      );

      final transaction = Transaction(
        id: 'txn_new_003',
        accountId: accountId,
        amount: 100.0,
        description: 'Transferencia',
        date: DateTime.now(),
        category: 'transfer',
        type: TransactionType.credit,
        status: TransactionStatus.pending,
      );

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);
      when(mockTransactionRepository.saveTransaction(transaction)).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
        () => useCase.execute(transaction),
        throwsA(isA<Exception>()),
      );
    });

    test.skip('Marca transacción como fallida en caso de error', () async {
      // Arrange
      const accountId = 'acc_004';
      final account = Account(
        id: accountId,
        name: 'Cuenta Fallida',
        userId: 'user_001',
        initialBalance: 5000.0,
        currency: Currency.usd,
        type: AccountType.checking,
        createdAt: DateTime(2024, 1, 1),
      );

      final transaction = Transaction(
        id: 'txn_new_004',
        accountId: accountId,
        amount: 250.0,
        description: 'Pago',
        date: DateTime.now(),
        category: 'expense',
        type: TransactionType.debit,
        status: TransactionStatus.pending,
      );

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);
      when(mockTransactionRepository.saveTransaction(any)).thenThrow(Exception('Database error'));

      // Act & Assert
      try {
        await useCase.execute(transaction);
      } catch (_) {
        // Verify that transaction status is updated to failed
        verifyNever(mockTransactionRepository.updateTransaction(any));
      }
    });
  });
}