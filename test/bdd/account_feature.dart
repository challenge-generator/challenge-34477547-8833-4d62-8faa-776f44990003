import 'package:flutter_test/flutter_test.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/entities/balance.dart';

void main() {
  group('Feature: Gestión de Cuentas', () {
    late Account account;
    late Balance balance;

    setUp(() {
      account = const Account(
        id: 'acc-001',
        name: 'Cuenta de Ahorros',
        userId: 'user-789',
        initialBalance: 10000.0,
        currency: Currency.usd,
        type: AccountType.savings,
        createdAt: DateTime(2024, 1, 1),
        updatedAt: null,
      );

      balance = const Balance(
        id: 'bal-001',
        accountId: 'acc-001',
        currentBalance: 10000.0,
        date: DateTime(2024, 1, 1),
        income: 0.0,
        expenses: 0.0,
        currency: Currency.usd,
      );
    });

    scenario('Crear cuenta con balance inicial válido', () {
      given('datos de nueva cuenta', () {
        expect(account.name, equals('Cuenta de Ahorros'));
        expect(account.initialBalance, equals(10000.0));
      });

      when('el sistema valida la cuenta', () {
        final isValid = account.isValidInitialBalance();
      });

      then('la cuenta es creada exitosamente', () {
        expect(account.isValidInitialBalance(), isTrue);
      });
    });

    scenario('Crear cuenta con balance inicial negativo es rechazado', () {
      given('datos de cuenta con balance negativo', () {
        account = const Account(
          id: 'acc-invalid',
          name: 'Cuenta Inválida',
          userId: 'user-001',
          initialBalance: -500.0,
          currency: Currency.usd,
          type: AccountType.checking,
          createdAt: DateTime.now(),
        );
      });

      when('se valida el balance inicial', () {
        final isValid = account.isValidInitialBalance();
      });

      then('la validación falla', () {
        expect(account.isValidInitialBalance(), isFalse);
      });
    });

    scenario('Actualizar información de cuenta', () {
      given('una cuenta existente', () {
        expect(account.name, equals('Cuenta de Ahorros'));
      });

      when('el usuario actualiza el nombre', () {
        account = account.copyWith(
          name: 'Cuenta de Ahorros Actualizada',
          updatedAt: DateTime.now(),
        );
      });

      then('el nombre se actualiza correctamente', () {
        expect(account.name, equals('Cuenta de Ahorros Actualizada'));
      });

      and('la fecha de actualización se registra', () {
        expect(account.updatedAt, isNotNull);
      });
    });

    scenario('Cambiar tipo de cuenta', () {
      given('una cuenta de tipo savings', () {
        expect(account.type, equals(AccountType.savings));
      });

      when('se cambia a tipo checking', () {
        account = account.copyWith(
          type: AccountType.checking,
          updatedAt: DateTime.now(),
        );
      });

      then('el tipo se actualiza', () {
        expect(account.type, equals(AccountType.checking));
      });
    });

    scenario('Verificar balance disponible para transacción', () {
      given('una cuenta con balance de $10000', () {
        expect(balance.currentBalance, equals(10000.0));
      });

      when('se consulta si puede afford $5000', () {
        final canAfford = balance.canAfford(5000.0);
      });

      then('retorna verdadero', () {
        expect(balance.canAfford(5000.0), isTrue);
      });
    });

    scenario('Verificar fondos insuficientes', () {
      given('una cuenta con balance de $10000', () {
        expect(balance.currentBalance, equals(10000.0));
      });

      when('se consulta si puede afford $15000', () {
        final canAfford = balance.canAfford(15000.0);
      });

      then('retorna falso', () {
        expect(balance.canAfford(15000.0), isFalse);
      });
    });
  });

  group('Cuentas con múltiples monedas', () {
    scenario('Cuenta en dólares tiene moneda correcta', () {
      given('una cuenta en USD', () {
        account = const Account(
          id: 'acc-usd',
          name: 'Cuenta USD',
          userId: 'user-001',
          initialBalance: 1000.0,
          currency: Currency.usd,
          type: AccountType.checking,
          createdAt: DateTime.now(),
        );
      });

      when('se verifica la moneda', () {
        final currency = account.currency;
      });

      then('la moneda es USD', () {
        expect(account.currency, equals(Currency.usd));
      });
    });

    scenario('Cuenta en euros tiene moneda correcta', () {
      given('una cuenta en EUR', () {
        account = const Account(
          id: 'acc-eur',
          name: 'Cuenta EUR',
          userId: 'user-002',
          initialBalance: 2000.0,
          currency: Currency.eur,
          type: AccountType.savings,
          createdAt: DateTime.now(),
        );
      });

      when('se verifica la moneda', () {
        final currency = account.currency;
      });

      then('la moneda es EUR', () {
        expect(account.currency, equals(Currency.eur));
      });
    });

    scenario('Balance refleja la moneda de la cuenta', () {
      given('una cuenta con moneda específica', () {
        balance = const Balance(
          id: 'bal-eur',
          accountId: 'acc-eur',
          currentBalance: 5000.0,
          date: DateTime.now(),
          income: 1000.0,
          expenses: 500.0,
          currency: Currency.eur,
        );
      });

      when('se consulta el balance', () {
        final curr = balance.currency;
      });

      then('la moneda es EUR', () {
        expect(balance.currency, equals(Currency.eur));
      });
    });
  });

  group('Copia inmutable de cuentas', () {
    scenario('copyWith preserva valores no modificados', () {
      given('una cuenta existente', () {
        expect(account.id, equals('acc-001'));
        expect(account.userId, equals('user-789'));
        expect(account.initialBalance, equals(10000.0));
      });

      when('se usa copyWith solo para nombre', () {
        final updated = account.copyWith(name: 'Nuevo Nombre');
      });

      then('otros valores permanecen iguales', () {
        final updated = account.copyWith(name: 'Nuevo Nombre');
        expect(updated.id, equals('acc-001'));
        expect(updated.userId, equals('user-789'));
        expect(updated.initialBalance, equals(10000.0));
      });
    });
  });
}