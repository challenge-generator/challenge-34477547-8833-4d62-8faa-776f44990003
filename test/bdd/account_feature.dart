import 'package:flutter_test/flutter_test.dart';

void main() {
  // Superficie de práctica (Fase 2): implementar las pruebas de cuentas (BDD).
  // Cada caso está marcado como skip hasta que lo resuelvas.
  group('Feature: Gestión de Cuentas', () {
    test(
      'Scenario: Crear cuenta con balance inicial válido',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
    test(
      'Scenario: Crear cuenta con balance inicial negativo es rechazado',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
    test(
      'Scenario: Actualizar información de cuenta',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
    test(
      'Scenario: Cambiar tipo de cuenta',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
    test(
      'Scenario: Verificar balance disponible para transacción',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
    test(
      'Scenario: Verificar fondos insuficientes',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
  });
  group('Cuentas con múltiples monedas', () {
    test(
      'Scenario: Cuenta en dólares tiene moneda correcta',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
    test(
      'Scenario: Cuenta en euros tiene moneda correcta',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
    test(
      'Scenario: Balance refleja la moneda de la cuenta',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
  });
  group('Copia inmutable de cuentas', () {
    test(
      'Scenario: copyWith preserva valores no modificados',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
  });
}
