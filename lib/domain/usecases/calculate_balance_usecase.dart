import 'package:equatable/equatable.dart';
import '../entities/balance.dart';
import '../entities/transaction.dart';
import '../repositories/account_repository.dart';
import '../repositories/transaction_repository.dart';

class CalculateBalanceUseCase extends Equatable {
  final AccountRepository accountRepository;
  final TransactionRepository transactionRepository;

  const CalculateBalanceUseCase({
    required this.accountRepository,
    required this.transactionRepository,
  });

  @override
  List<Object?> get props => [accountRepository, transactionRepository];

  Future<Balance> execute(String accountId) async {
    final account = await accountRepository.getAccountById(accountId);
    if (account == null) {
      throw AccountNotFoundException('Account with id $accountId not found');
    }

    final transactions = await transactionRepository.getTransactionsByAccount(accountId);

    double totalIncome = 0.0;
    double totalExpenses = 0.0;

    for (final transaction in transactions) {
      if (transaction.status == TransactionStatus.completed) {
        final impact = transaction.calculateBalanceImpact();
        if (impact > 0) {
          totalIncome += impact;
        } else {
          totalExpenses += impact.abs();
        }
      }
    }

    final currentBalance = account.initialBalance + totalIncome - totalExpenses;

    final balance = Balance(
      id: 'balance_$accountId',
      accountId: accountId,
      currentBalance: currentBalance,
      date: DateTime.now(),
      income: totalIncome,
      expenses: totalExpenses,
      currency: account.currency,
    );

    return balance;
  }

  Future<Balance> executeWithProjection(
    String accountId,
    DateTime projectionDate,
  ) async {
    final baseBalance = await execute(accountId);

    final futureTransactions = await transactionRepository.getTransactionsByDateRange(
      accountId,
      DateTime.now(),
      projectionDate,
    );

    double projectedIncome = 0.0;
    double projectedExpenses = 0.0;

    for (final transaction in futureTransactions) {
      final impact = transaction.calculateBalanceImpact();
      if (transaction.type == TransactionType.income) {
        projectedIncome += impact;
      } else {
        projectedExpenses += impact.abs();
      }
    }

    return Balance(
      id: 'balance_projected_$accountId',
      accountId: accountId,
      currentBalance: baseBalance.currentBalance + projectedIncome - projectedExpenses,
      date: projectionDate,
      income: baseBalance.income + projectedIncome,
      expenses: baseBalance.expenses + projectedExpenses,
      currency: baseBalance.currency,
    );
  }

  Future<bool> canWithdraw(String accountId, double amount) async {
    final balance = await execute(accountId);
    return balance.canAfford(amount);
  }

  Future<Map<String, double>> calculateCategoryBreakdown(String accountId) async {
    final transactions = await transactionRepository.getTransactionsByAccount(accountId);
    final Map<String, double> breakdown = {};

    for (final transaction in transactions) {
      if (transaction.status == TransactionStatus.completed &&
          transaction.type == TransactionType.expense) {
        breakdown[transaction.category] =
            (breakdown[transaction.category] ?? 0.0) + transaction.amount;
      }
    }

    return breakdown;
  }

  Future<BalanceSummary> calculateSummary(String userId) async {
    final accounts = await accountRepository.getAccountsByUser(userId);
    
    double totalIncome = 0.0;
    double totalExpenses = 0.0;
    double totalBalance = 0.0;

    for (final account in accounts) {
      final balance = await execute(account.id);
      totalIncome += balance.income;
      totalExpenses += balance.expenses;
      totalBalance += balance.currentBalance;
    }

    return BalanceSummary(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      totalBalance: totalBalance,
      accountCount: accounts.length,
    );
  }
}

class AccountNotFoundException implements Exception {
  final String message;
  const AccountNotFoundException(this.message);

  @override
  String toString() => 'AccountNotFoundException: $message';
}

class BalanceSummary extends Equatable {
  final double totalIncome;
  final double totalExpenses;
  final double totalBalance;
  final int accountCount;

  const BalanceSummary({
    required this.totalIncome,
    required this.totalExpenses,
    required this.totalBalance,
    required this.accountCount,
  });

  double get netSavings => totalIncome - totalExpenses;

  double get savingsRate => totalIncome > 0 ? (netSavings / totalIncome) * 100 : 0;

  @override
  List<Object?> get props => [totalIncome, totalExpenses, totalBalance, accountCount];
}