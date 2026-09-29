import 'package:equatable/equatable.dart';

/// Entidad que representa una cuenta financiera en el dominio.
/// Es inmutable y utiliza copyWith para crear nuevas instancias con valores modificados.
class Account extends Equatable {
  final String id;
  final String name;
  final String userId;
  final double initialBalance;
  final Currency currency;
  final AccountType type;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Account({
    required this.id,
    required this.name,
    required this.userId,
    required this.initialBalance,
    required this.currency,
    required this.type,
    required this.createdAt,
    this.updatedAt,
  });

  /// Crea una nueva instancia de Account con los valores modificados.
  Account copyWith({
    String? id,
    String? name,
    String? userId,
    double? initialBalance,
    Currency? currency,
    AccountType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      userId: userId ?? this.userId,
      initialBalance: initialBalance ?? this.initialBalance,
      currency: currency ?? this.currency,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        userId,
        initialBalance,
        currency,
        type,
        createdAt,
        updatedAt,
      ];

  /// Valida que el saldo inicial sea no negativo.
  bool isValidInitialBalance() {
    return initialBalance >= 0;
  }
}

/// Tipos de moneda soportados.
enum Currency {
  usd,
  eur,
  gbp,
  jpy,
}

/// Tipos de cuenta soportados.
enum AccountType {
  checking,
  savings,
  investment,
  credit,
}