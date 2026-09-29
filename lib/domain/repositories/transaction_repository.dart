import 'package:equatable/equatable.dart';
import '../entities/transaction.dart';

abstract class TransactionRepository extends Equatable {
  const TransactionRepository();

  Future<List<Transaction>> getTransactionsByAccount(String accountId);

  Future<Transaction?> getTransactionById(String id);

  Future<Transaction> createTransaction(Transaction transaction);

  Future<Transaction> updateTransaction(Transaction transaction);

  Future<void> deleteTransaction(String id);

  Future<List<Transaction>> getTransactionsByDateRange(
    String accountId,
    DateTime startDate,
    DateTime endDate,
  );

  Future<List<Transaction>> getTransactionsByCategory(
    String accountId,
    String category,
  );

  Future<double> getTotalAmountByType(
    String accountId,
    TransactionType type,
  );

  Future<List<Transaction>> getPendingTransactions(String accountId);

  Future<void> processTransactionBatch(List<Transaction> transactions);

  Stream<Transaction> watchTransactions(String accountId);
}