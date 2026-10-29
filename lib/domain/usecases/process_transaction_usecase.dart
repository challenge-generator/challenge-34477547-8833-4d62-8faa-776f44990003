import 'package:equatable/equatable.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/entities/balance.dart';
import 'package:finance_app/domain/repositories/transaction_repository.dart';
import 'package:finance_app/domain/repositories/account_repository.dart';

class ProcessTransactionParams extends Equatable {
  final String accountId;
  final double amount;
  final String description;
  final String category;
  final TransactionType type;
  final DateTime? date;

  const ProcessTransactionParams({
    required this.accountId,
    required this.amount,
    required this.description,
    required this.category,
    required this.type,
    this.date,
  });

  @override
  List<Object?> get props => [accountId, amount, description, category, type, date];
}

class ProcessTransactionResult extends Equatable {
  final Transaction transaction;
  final Balance updatedBalance;
  final bool success;
  final String? errorMessage;

  const ProcessTransactionResult({
    required this.transaction,
    required this.updatedBalance,
    required this.success,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [transaction, updatedBalance, success, errorMessage];
}

class ProcessTransactionUseCase {
  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;

  ProcessTransactionUseCase({
    required TransactionRepository transactionRepository,
    required AccountRepository accountRepository,
  })  : _transactionRepository = transactionRepository,
        _accountRepository = accountRepository;

  Future<ProcessTransactionResult> execute(ProcessTransactionParams params) async {
    if (params.amount <= 0) {
      return ProcessTransactionResult(
        transaction: _createFailedTransaction(params),
        updatedBalance: _emptyBalance(),
        success: false,
        errorMessage: 'El monto debe ser mayor a cero',
      );
    }

    final account = await _accountRepository.getAccountById(params.accountId);
    if (account == null) {
      return ProcessTransactionResult(
        transaction: _createFailedTransaction(params),
        updatedBalance: _emptyBalance(),
        success: false,
        errorMessage: 'Cuenta no encontrada',
      );
    }

    final currentBalance = await _accountRepository.getAccountBalance(params.accountId);
    final balanceToCheck = currentBalance ?? Balance(
      id: 'initial_${params.accountId}',
      accountId: params.accountId,
      currentBalance: account.initialBalance,
      date: DateTime.now(),
      income: 0,
      expenses: 0,
      currency: account.currency,
    );

    if (params.type == TransactionType.expense && !balanceToCheck.canAfford(params.amount)) {
      return ProcessTransactionResult(
        transaction: _createFailedTransaction(params),
        updatedBalance: balanceToCheck,
        success: false,
        errorMessage: 'Saldo insuficiente para realizar esta transacción',
      );
    }

    final transactionId = _generateTransactionId();
    final now = params.date ?? DateTime.now();
    final newBalance = balanceToCheck.applyTransaction(params.amount, params.type);

    final transaction = Transaction(
      id: transactionId,
      accountId: params.accountId,
      amount: params.amount,
      description: params.description,
      date: now,
      category: params.category,
      type: params.type,
      status: TransactionStatus.completed,
    );

    try {
      await _transactionRepository.createTransaction(transaction);
      await _accountRepository.updateAccountBalance(params.accountId, newBalance);

      return ProcessTransactionResult(
        transaction: transaction,
        updatedBalance: newBalance,
        success: true,
      );
    } catch (e) {
      return ProcessTransactionResult(
        transaction: transaction.copyWith(status: TransactionStatus.failed),
        updatedBalance: balanceToCheck,
        success: false,
        errorMessage: 'Error al procesar la transacción: ${e.toString()}',
      );
    }
  }

  Balance _emptyBalance() {
    return Balance(
      id: '',
      accountId: '',
      currentBalance: 0,
      date: DateTime.now(),
      income: 0,
      expenses: 0,
      currency: Currency.usd,
    );
  }

  Transaction _createFailedTransaction(ProcessTransactionParams params) {
    return Transaction(
      id: _generateTransactionId(),
      accountId: params.accountId,
      amount: params.amount,
      description: params.description,
      date: params.date ?? DateTime.now(),
      category: params.category,
      type: params.type,
      status: TransactionStatus.failed,
    );
  }

  String _generateTransactionId() {
    return 'TXN_${DateTime.now().millisecondsSinceEpoch}_${DateTime.now().microsecond}';
  }
}