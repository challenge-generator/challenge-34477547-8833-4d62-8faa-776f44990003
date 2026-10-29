import 'package:equatable/equatable.dart';
import 'package:finance_app/domain/entities/transaction.dart';

class TransactionModel extends Equatable {
  final String id;
  final String accountId;
  final double amount;
  final String description;
  final DateTime date;
  final String category;
  final String type;
  final String status;

  const TransactionModel({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.description,
    required this.date,
    required this.category,
    required this.type,
    required this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      accountId: json['account_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      category: json['category'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_id': accountId,
      'amount': amount,
      'description': description,
      'date': date.toIso8601String(),
      'category': category,
      'type': type,
      'status': status,
    };
  }

  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'account_id': accountId,
      'amount': amount,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'category': category,
      'type': type,
      'status': status,
    };
  }

  factory TransactionModel.fromDbMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      accountId: map['account_id'] as String,
      amount: (map['amount'] as num).toDouble(),
      description: map['description'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      category: map['category'] as String,
      type: map['type'] as String,
      status: map['status'] as String,
    );
  }

  factory TransactionModel.fromEntity(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      accountId: transaction.accountId,
      amount: transaction.amount,
      description: transaction.description,
      date: transaction.date,
      category: transaction.category,
      type: transaction.type.name,
      status: transaction.status.name,
    );
  }

  Transaction toEntity() {
    return Transaction(
      id: id,
      accountId: accountId,
      amount: amount,
      description: description,
      date: date,
      category: category,
      type: TransactionType.values.firstWhere(
        (t) => t.name == type,
        orElse: () => TransactionType.expense,
      ),
      status: TransactionStatus.values.firstWhere(
        (s) => s.name == status,
        orElse: () => TransactionStatus.pending,
      ),
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

  TransactionModel copyWith({
    String? id,
    String? accountId,
    double? amount,
    String? description,
    DateTime? date,
    String? category,
    String? type,
    String? status,
  }) {
    return TransactionModel(
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

  bool get isIncome => type == 'income' || type == 'credit';
  bool get isExpense => type == 'expense' || type == 'debit';
  bool get isCompleted => status == 'completed';
  bool get isPending => status == 'pending';
  bool get isCancelled => status == 'cancelled';

  double get balanceImpact => isIncome ? amount : (isExpense ? -amount : 0);

  String get typeDisplayName {
    switch (type) {
      case 'income':
        return 'Ingreso';
      case 'expense':
        return 'Gasto';
      case 'credit':
        return 'Crédito';
      case 'debit':
        return 'Débito';
      case 'transfer':
        return 'Transferencia';
      default:
        return 'Desconocido';
    }
  }

  String get statusDisplayName {
    switch (status) {
      case 'completed':
        return 'Completada';
      case 'pending':
        return 'Pendiente';
      case 'cancelled':
        return 'Cancelada';
      case 'failed':
        return 'Fallida';
      default:
        return 'Desconocido';
    }
  }

  @override
  String toString() {
    return 'TransactionModel(id: $id, accountId: $accountId, amount: $amount, '
        'description: $description, date: $date, category: $category, '
        'type: $type, status: $status)';
  }
}