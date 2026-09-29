import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/domain/entities/balance.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/repositories/transaction_repository.dart';
import 'package:finance_app/domain/repositories/account_repository.dart';
import 'package:finance_app/domain/usecases/calculate_balance_usecase.dart';

class MockTransactionRepository extends Mock implements TransactionRepository {}

class MockAccountRepository extends Mock implements AccountRepository {}

void main() {
  // Superficie de práctica: implementar casos de prueba para CalculateBalanceUseCase
  group('CalculateBalanceUseCase', () {
    late CalculateBalanceUseCase useCase;
    late MockTransactionRepository mockTransactionRepository;
    late MockAccountRepository mockAccountRepository;

    setUp(() {
      mockTransactionRepository = MockTransactionRepository();
      mockAccountRepository = MockAccountRepository();
      useCase = CalculateBalanceUseCase(
        transactionRepository: mockTransactionRepository,
        accountRepository: mockAccountRepository,
      );
    });

    test.skip('Calcula saldo correctamente para cuenta con transacciones positivas', () async {
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

      final transactions = [
        Transaction(
          id: 'txn_001',
          accountId: accountId,
          amount: 500.0,
          description: 'Depósito',
          date: DateTime(2024, 1, 15),
          category: 'income',
          type: TransactionType.credit,
          status: TransactionStatus.completed,
        ),
        Transaction(
          id: 'txn_002',
          accountId: accountId,
          amount: 200.0,
          description: 'Compra',
          date: DateTime(2024, 1, 16),
          category: 'expense',
          type: TransactionType.debit,
          status: TransactionStatus.completed,
        ),
      ];

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);
      when(mockTransactionRepository.getTransactionsByAccount(accountId)).thenAnswer((_) async => transactions);

      // Act
      final result = await useCase.execute(accountId);

      // Assert
      expect(result.currentBalance, equals(1300.0));
      expect(result.income, equals(500.0));
      expect(result.expenses, equals(200.0));
    });

    test.skip('Maneja cuenta sin transacciones correctamente', () async {
      // Arrange
      const accountId = 'acc_002';
      final account = Account(
        id: accountId,
        name: 'Cuenta Vacía',
        userId: 'user_001',
        initialBalance: 500.0,
        currency: Currency.usd,
        type: AccountType.savings,
        createdAt: DateTime(2024, 1, 1),
      );

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);
      when(mockTransactionRepository.getTransactionsByAccount(accountId)).thenAnswer((_) async => []);

      // Act
      final result = await useCase.execute(accountId);

      // Assert
      expect(result.currentBalance, equals(500.0));
      expect(result.income, equals(0.0));
      expect(result.expenses, equals(0.0));
    });

    test.skip('Calcula saldo con transacciones de ambos tipos', () async {
      // Arrange
      const accountId = 'acc_003';
      final account = Account(
        id: accountId,
        name: 'Cuenta Mixta',
        userId: 'user_001',
        initialBalance: 2000.0,
        currency: Currency.eur,
        type: AccountType.checking,
        createdAt: DateTime(2024, 1, 1),
      );

      final transactions = [
        Transaction(
          id: 'txn_003',
          accountId: accountId,
          amount: 1000.0,
          description: 'Salario',
          date: DateTime(2024, 1, 1),
          category: 'income',
          type: TransactionType.credit,
          status: TransactionStatus.completed,
        ),
        Transaction(
          id: 'txn_004',
          accountId: accountId,
          amount: 150.0,
          description: 'Servicios',
          date: DateTime(2024, 1, 5),
          category: 'expense',
          type: TransactionType.debit,
          status: TransactionStatus.completed,
        ),
        Transaction(
          id: 'txn_005',
          accountId: accountId,
          amount: 300.0,
          description: 'Alquiler',
          date: DateTime(2024, 1, 10),
          category: 'expense',
          type: TransactionType.debit,
          status: TransactionStatus.completed,
        ),
        Transaction(
          id: 'txn_006',
          accountId: accountId,
          amount: 50.0,
          description: 'Transferencia',
          date: DateTime(2024, 1, 12),
          category: 'transfer',
          type: TransactionType.credit,
          status: TransactionStatus.completed,
        ),
      ];

      when(mockAccountRepository.getAccount(accountId)).thenAnswer((_) async => account);
      when(mockTransactionRepository.getTransactionsByAccount(accountId)).thenAnswer((_) async => transactions);

      // Act
      final result = await useCase.execute(accountId);

      // Assert
      expect(result.currentBalance, equals(2600.0));
      expect(result.income, equals(1050.0));
      expect(result.expenses, equals(450.0));
    });
  });
}