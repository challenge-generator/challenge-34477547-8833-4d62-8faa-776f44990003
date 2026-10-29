import 'package:flutter_test/flutter_test.dart';

void main() {
  // Superficie de práctica (Fase 2): implementar las pruebas de transacciones (BDD).
  // Cada caso está marcado como skip hasta que lo resuelvas.
  group('Feature: Gestión de Transacciones', () {
    test(
      'Scenario: Crear transacción de ingreso exitosa',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
    test(
      'Scenario: Procesar transacción de gasto',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
    test(
      'Scenario: Rechazar transacción por fondos insuficientes',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
    test(
      'Scenario: Actualizar estado de transacción',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
    test(
      'Scenario: Revertir transacción',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
  });
  group('Transacciones con comportamiento específico', () {
    test(
      'Scenario: Transacción de ingreso aumenta income del balance',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
    test(
      'Scenario: Transacción de gasto aumenta expenses del balance',
      () {},
      skip: 'Pendiente de implementar (Fase 2)',
    );
  });
}
