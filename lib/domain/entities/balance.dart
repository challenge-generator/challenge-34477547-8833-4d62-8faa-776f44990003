import 'package:equatable/equatable.dart';
import 'account.dart';
import 'transaction.dart';

/// Entidad que representa el balance financiero de una cuenta en un momento dado.
/// Es inmutable y utiliza copyWith para crear nuevas instancias con valores modificados.
class Balance extends Equatable {
  final String id;
  final String accountId;
  final double currentBalance;
  final DateTime date;
  final double income;
  final double expenses;
  final Currency currency;

  const Balance({
    required this.id,
    required this.accountId,
    required this.currentBalance,
    required this.date,
    required this.income,
    required this.expenses,
    required this.currency,
  });

  /// Crea una nueva instancia de Balance con los valores modificados.
  Balance copyWith({
    String? id,
    String? accountId,
    double? currentBalance,
    DateTime? date,
    double? income,
    double? expenses,
    Currency? currency,
  }) {
    return Balance(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      currentBalance: currentBalance ?? this.currentBalance,
      date: date ?? this.date,
      income: income ?? this.income,
      expenses: expenses ?? this.expenses,
      currency: currency ?? this.currency,
    );
  }

  @override
  List<Object?> get props => [
        id,
        accountId,
        currentBalance,
        date,
        income,
        expenses,
        currency,
      ];

  /// Calcula el balance proyectado con una nueva transacción.
  Balance applyTransaction(double amount, TransactionType type) {
    final impact = type == TransactionType.income ? amount : -amount;
    final newIncome = type == TransactionType.income ? income + amount : income;
    final newExpenses = type == TransactionType.expense ? expenses + amount : expenses;

    return copyWith(
      currentBalance: currentBalance + impact,
      income: newIncome,
      expenses: newExpenses,
      date: DateTime.now(),
    );
  }

  /// Verifica si el balance actual es suficiente para una transacción de gasto.
  bool canAfford(double amount) {
    return currentBalance >= amount;
  }
}