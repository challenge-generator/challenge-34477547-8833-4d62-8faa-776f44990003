import 'package:flutter_test/flutter_test.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/entities/balance.dart';

void main() {
  group('Feature: Gestión de Transacciones', () {
    late Transaction transaction;
    late Account account;
    late Balance balance;

    setUp(() {
      account = const Account(
        id: 'account-123',
        name: 'Cuenta Principal',
        userId: 'user-456',
        initialBalance: 5000.0,
        currency: Currency.usd,
        type: AccountType.checking,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: null,
      );

      balance = const Balance(
        id: 'balance-1',
        accountId: 'account-123',
        currentBalance: 5000.0,
        date: DateTime(2024, 1, 1),
        income: 0.0,
        expenses: 0.0,
        currency: Currency.usd,
      );
    });

    scenario('Crear transacción de ingreso exitosa', () {
      given('un usuario con cuenta activa', () {
        expect(account, isNotNull);
        expect(account.initialBalance, equals(5000.0));
      });

      when('el usuario registra un ingreso de $1500', () {
        transaction = Transaction(
          id: 'tx-001',
          accountId: account.id,
          amount: 1500.0,
          description: 'Pago de freelance',
          date: DateTime.now(),
          category: 'income',
          type: TransactionType.credit,
          status: TransactionStatus.pending,
        );
      });

      then('la transacción se crea con estado pendiente', () {
        expect(transaction.type, equals(TransactionType.credit));
        expect(transaction.status, equals(TransactionStatus.pending));
      });

      and('el monto es válido para procesamiento', () {
        expect(transaction.isValidAmount(), isTrue);
      });
    });

    scenario('Procesar transacción de débito', () {
      given('una cuenta con balance suficiente', () {
        expect(balance.canAfford(1000.0), isTrue);
      });

      when('el usuario realiza un gasto de $800', () {
        transaction = Transaction(
          id: 'tx-002',
          accountId: account.id,
          amount: 800.0,
          description: 'Compra en tienda',
          date: DateTime.now(),
          category: 'shopping',
          type: TransactionType.debit,
          status: TransactionStatus.completed,
        );
      });

      then('el impacto en balance es negativo', () {
        expect(transaction.calculateBalanceImpact(), equals(-800.0));
      });
    });

    scenario('Rechazar transacción por fondos insuficientes', () {
      given('una cuenta con balance de $5000', () {
        expect(balance.currentBalance, equals(5000.0));
      });

      when('el usuario intenta gastar $6000', () {
        final canAfford = balance.canAfford(6000.0);
      });

      then('la operación es rechazada', () {
        expect(balance.canAfford(6000.0), isFalse);
      });
    });

    scenario('Actualizar estado de transacción', () {
      given('una transacción en estado pendiente', () {
        transaction = Transaction(
          id: 'tx-003',
          accountId: account.id,
          amount: 300.0,
          description: 'Servicio pendiente',
          date: DateTime.now(),
          category: 'services',
          type: TransactionType.credit,
          status: TransactionStatus.pending,
        );
        expect(transaction.status, equals(TransactionStatus.pending));
      });

      when('el sistema procesa la transacción', () {
        transaction = transaction.copyWith(
          status: TransactionStatus.completed,
        );
      });

      then('el estado cambia a completado', () {
        expect(transaction.status, equals(TransactionStatus.completed));
      });
    });

    scenario('Cancelar transacción', () {
      given('una transacción completada', () {
        transaction = Transaction(
          id: 'tx-004',
          accountId: account.id,
          amount: 250.0,
          description: 'Compra cancelable',
          date: DateTime.now(),
          category: 'shopping',
          type: TransactionType.debit,
          status: TransactionStatus.completed,
        );
      });

      when('el usuario cancela la transacción', () {
        transaction = transaction.copyWith(
          status: TransactionStatus.cancelled,
        );
      });

      then('el estado cambia a cancelado', () {
        expect(transaction.status, equals(TransactionStatus.cancelled));
      });
    });
  });

  group('Transacciones con comportamiento específico', () {
    scenario('Transacción de crédito aumenta income del balance', () {
      given('balance con income acumulado', () {
        balance = const Balance(
          id: 'b1',
          accountId: 'a1',
          currentBalance: 1000.0,
          date: DateTime.now(),
          income: 500.0,
          expenses: 200.0,
          currency: Currency.usd,
        );
      });

      when('se aplica transacción de crédito por $300', () {
        final newBalance = balance.applyTransaction(300.0, TransactionType.credit);
      });

      then('income se incrementa', () {
        final result = balance.applyTransaction(300.0, TransactionType.credit);
        expect(result.income, equals(800.0));
      });
    });

    scenario('Transacción de débito aumenta expenses del balance', () {
      given('balance con expenses acumulado', () {
        balance = const Balance(
          id: 'b2',
          accountId: 'a2',
          currentBalance: 1000.0,
          date: DateTime.now(),
          income: 500.0,
          expenses: 200.0,
          currency: Currency.usd,
        );
      });

      when('se aplica transacción de débito por $150', () {
        final newBalance = balance.applyTransaction(150.0, TransactionType.debit);
      });

      then('expenses se incrementa', () {
        final result = balance.applyTransaction(150.0, TransactionType.debit);
        expect(result.expenses, equals(350.0));
      });
    });
  });
}