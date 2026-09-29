package finance_app.data.models;

import 'package:equatable/equatable.dart';

class AccountModel extends Equatable {
  final String id;
  final String name;
  final String userId;
  final double initialBalance;
  final String currency;
  final String type;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const AccountModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.initialBalance,
    required this.currency,
    required this.type,
    required this.createdAt,
    this.updatedAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] as String,
      name: json['name'] as String,
      userId: json['user_id'] as String,
      initialBalance: (json['initial_balance'] as num).toDouble(),
      currency: json['currency'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user_id': userId,
      'initial_balance': initialBalance,
      'currency': currency,
      'type': type,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  Map<String, dynamic> toDbMap() {
    return {
      'id': id,
      'name': name,
      'user_id': userId,
      'initial_balance': initialBalance,
      'currency': currency,
      'type': type,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory AccountModel.fromDbMap(Map<String, dynamic> map) {
    return AccountModel(
      id: map['id'] as String,
      name: map['name'] as String,
      userId: map['user_id'] as String,
      initialBalance: (map['initial_balance'] as num).toDouble(),
      currency: map['currency'] as String,
      type: map['type'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: map['updated_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int)
          : null,
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

  AccountModel copyWith({
    String? id,
    String? name,
    String? userId,
    double? initialBalance,
    String? currency,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AccountModel(
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

  bool get isBankAccount => type == 'bank' || type == 'checking';
  bool get isCash => type == 'cash';
  bool get isCreditCard => type == 'credit_card';
  bool get isSavings => type == 'savings';
  bool get isInvestment => type == 'investment';

  String get typeDisplayName {
    switch (type) {
      case 'bank':
        return 'Cuenta Bancaria';
      case 'checking':
        return 'Cuenta Corriente';
      case 'savings':
        return 'Cuenta de Ahorros';
      case 'cash':
        return 'Efectivo';
      case 'credit_card':
        return 'Tarjeta de Crédito';
      case 'investment':
        return 'Inversión';
      default:
        return 'Desconocido';
    }
  }

  String get currencySymbol {
    switch (currency) {
      case 'USD':
        return '\$';
      case 'EUR':
        return '€';
      case 'GBP':
        return '£';
      case 'JPY':
        return '¥';
      case 'COP':
        return '\$';
      case 'MXN':
        return '\$';
      default:
        return currency;
    }
  }

  String formatBalance() {
    return '$currencySymbol${initialBalance.toStringAsFixed(2)}';
  }

  @override
  String toString() {
    return 'AccountModel(id: $id, name: $name, userId: $userId, '
        'initialBalance: $initialBalance, currency: $currency, '
        'type: $type, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}