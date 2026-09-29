import 'package:equatable/equatable.dart';

/// Entidad que representa una transacción financiera en el dominio.
/// Es inmutable y utiliza copyWith para crear nuevas instancias con valores modificados.
class Transaction extends Equatable {
  final String id;
  final String accountId;
  final double amount;
  final String description;
  final DateTime date;
  final String category;
  final TransactionType type;
  final TransactionStatus status;

  const Transaction({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
    required this.type,
    this.status = TransactionStatus.pending,
  });

  /// Crea una nueva instancia de Transaction con los valores modificados.
  Transaction copyWith({
    String? id,
    String? accountId,
    double? amount,
    String? description,
    DateTime? date,
    String? category,
    TransactionType? type,
    TransactionStatus? status,
  }) {
    return Transaction(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      date: date ?? this.date,
      category: category ?? this.category,
      type: type ?? this.type,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        accountId,
        amount,
        description,
        date,
        category,
        type,
        status,
      ];

  /// Valida que el monto de la transacción sea positivo.
  bool isValidAmount() {
    return amount > 0;
  }

  /// Calcula el impacto en el saldo según el tipo de transacción.
  double calculateBalanceImpact() {
    return type == TransactionType.income ? amount : -amount;
  }
}

/// Tipos de transacción soportados.
enum TransactionType {
  income,
  expense,
}

/// Estados posibles de una transacción.
enum TransactionStatus {
  pending,
  completed,
  failed,
  reversed,
}