import 'package:equatable/equatable.dart';
import 'package:finance_app/domain/entities/transaction.dart';

enum NotificationPriority { low, normal, high, urgent }

class NotificationPayload extends Equatable {
  final String transactionId;
  final String title;
  final String body;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  const NotificationPayload({
    required this.transactionId,
    required this.title,
    required this.body,
    required this.timestamp,
    this.metadata,
  });

  @override
  List<Object?> get props => [transactionId, title, body, timestamp, metadata];
}

class NotifyTransactionParams extends Equatable {
  final Transaction transaction;
  final NotificationPriority priority;
  final bool includeBalance;
  final double? currentBalance;

  const NotifyTransactionParams({
    required this.transaction,
    this.priority = NotificationPriority.normal,
    this.includeBalance = false,
    this.currentBalance,
  });

  @override
  List<Object?> get props => [transaction, priority, includeBalance, currentBalance];
}

class NotifyTransactionResult extends Equatable {
  final bool success;
  final String? notificationId;
  final String? errorMessage;
  final NotificationPayload? payload;

  const NotifyTransactionResult({
    required this.success,
    this.notificationId,
    this.errorMessage,
    this.payload,
  });

  @override
  List<Object?> get props => [success, notificationId, errorMessage, payload];
}

abstract class PushNotificationService {
  Future<NotifyTransactionResult> sendNotification(NotificationPayload payload, NotificationPriority priority);
  Future<bool> isServiceAvailable();
  Future<String?> getDeviceToken();
}

class NotifyTransactionUseCase {
  final PushNotificationService _notificationService;

  NotifyTransactionUseCase({
    required PushNotificationService notificationService,
  }) : _notificationService = notificationService;

  Future<NotifyTransactionResult> execute(NotifyTransactionParams params) async {
    final isAvailable = await _notificationService.isServiceAvailable();
    if (!isAvailable) {
      return const NotifyTransactionResult(
        success: false,
        errorMessage: 'Servicio de notificaciones no disponible',
      );
    }

    final payload = _buildNotificationPayload(params);
    final result = await _notificationService.sendNotification(payload, params.priority);
    
    return NotifyTransactionResult(
      success: result.success,
      notificationId: result.notificationId,
      errorMessage: result.errorMessage,
      payload: payload,
    );
  }

  NotificationPayload _buildNotificationPayload(NotifyTransactionParams params) {
    final transaction = params.transaction;
    final typeLabel = transaction.type == TransactionType.income ? 'Ingreso' : 'Gasto';
    final statusEmoji = transaction.status == TransactionStatus.completed ? '✅' : '❌';
    
    String body = '$statusEmoji $typeLabel de \$${transaction.amount.toStringAsFixed(2)}';
    
    if (params.includeBalance && params.currentBalance != null) {
      body += '\nSaldo actual: \$${params.currentBalance!.toStringAsFixed(2)}';
    }
    
    if (transaction.description.isNotEmpty) {
      body += '\n${transaction.description}';
    }

    return NotificationPayload(
      transactionId: transaction.id,
      title: 'Transacción ${transaction.type == TransactionType.income ? 'recibida' : 'procesada'}',
      body: body,
      timestamp: transaction.date,
      metadata: {
        'accountId': transaction.accountId,
        'category': transaction.category,
        'status': transaction.status.name,
        'type': transaction.type.name,
      },
    );
  }

  Future<NotifyTransactionResult> notifyLargeTransaction(Transaction transaction, double currentBalance) async {
    final params = NotifyTransactionParams(
      transaction: transaction,
      priority: NotificationPriority.high,
      includeBalance: true,
      currentBalance: currentBalance,
    );
    return execute(params);
  }

  Future<NotifyTransactionResult> notifyLowBalance(Transaction transaction, double threshold) async {
    final params = NotifyTransactionParams(
      transaction: transaction,
      priority: NotificationPriority.urgent,
      includeBalance: true,
      currentBalance: threshold,
    );
    return execute(params);
  }

  Future<NotifyTransactionResult> notifyFailedTransaction(Transaction transaction, String reason) async {
    final payload = NotificationPayload(
      transactionId: transaction.id,
      title: 'Transacción fallida',
      body: 'La transacción de \$${transaction.amount.toStringAsFixed(2)} no pudo ser procesada. Razón: $reason',
      timestamp: DateTime.now(),
      metadata: {
        'accountId': transaction.accountId,
        'failureReason': reason,
        'status': 'failed',
      },
    );
    
    return _notificationService.sendNotification(payload, NotificationPriority.urgent);
  }
}