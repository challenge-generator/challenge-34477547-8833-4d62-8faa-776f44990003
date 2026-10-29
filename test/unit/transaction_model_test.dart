import 'package:flutter_test/flutter_test.dart';

void main() {
  // Superficie de práctica (Fase 1): implementar las pruebas de Transaction.
  // Cada caso está marcado como skip hasta que lo resuelvas.
  group('Transaction', () {
    test(
      'Crea transacción válida con todos los campos',
      () {},
      skip: 'Pendiente de implementar (Fase 1)',
    );
    test(
      'copyWith crea copia con campos modificados',
      () {},
      skip: 'Pendiente de implementar (Fase 1)',
    );
    test(
      'isValidAmount retorna true para monto positivo',
      () {},
      skip: 'Pendiente de implementar (Fase 1)',
    );
    test(
      'isValidAmount retorna false para monto cero',
      () {},
      skip: 'Pendiente de implementar (Fase 1)',
    );
    test(
      'isValidAmount retorna false para monto negativo',
      () {},
      skip: 'Pendiente de implementar (Fase 1)',
    );
    test(
      'calculateBalanceImpact retorna monto positivo para ingreso',
      () {},
      skip: 'Pendiente de implementar (Fase 1)',
    );
    test(
      'calculateBalanceImpact retorna monto negativo para gasto',
      () {},
      skip: 'Pendiente de implementar (Fase 1)',
    );
    test(
      'Dos transacciones con mismo contenido son iguales',
      () {},
      skip: 'Pendiente de implementar (Fase 1)',
    );
  });
  group('TransactionType', () {
    test(
      'TransactionType tiene valores correctos',
      () {},
      skip: 'Pendiente de implementar (Fase 1)',
    );
  });
  group('TransactionStatus', () {
    test(
      'TransactionStatus tiene valores correctos',
      () {},
      skip: 'Pendiente de implementar (Fase 1)',
    );
  });
}
