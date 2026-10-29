import 'package:flutter/foundation.dart';
import 'package:finance_app/domain/entities/transaction.dart';
import 'package:finance_app/domain/entities/account.dart';
import 'package:finance_app/domain/entities/balance.dart';
import 'package:finance_app/domain/repositories/transaction_repository.dart';
import 'package:finance_app/domain/repositories/account_repository.dart';
import 'package:finance_app/domain/usecases/calculate_balance_usecase.dart';
import 'package:finance_app/domain/usecases/process_transaction_usecase.dart';

class FinanceViewModel extends ChangeNotifier {
  final TransactionRepository _transactionRepository;
  final AccountRepository _accountRepository;
  final CalculateBalanceUseCase _calculateBalanceUseCase;
  final ProcessTransactionUseCase _processTransactionUseCase;

  static const String _defaultUserId = 'default_user';

  List<Transaction> _transactions = [];
  Account? _currentAccount;
  Balance? _currentBalance;
  bool _isLoading = false;
  String? _error;

  FinanceViewModel({
    required TransactionRepository transactionRepository,
    required AccountRepository accountRepository,
    required CalculateBalanceUseCase calculateBalanceUseCase,
    required ProcessTransactionUseCase processTransactionUseCase,
  })  : _transactionRepository = transactionRepository,
        _accountRepository = accountRepository,
        _calculateBalanceUseCase = calculateBalanceUseCase,
        _processTransactionUseCase = processTransactionUseCase;

  List<Transaction> get transactions => List.unmodifiable(_transactions);
  Account? get currentAccount => _currentAccount;
  Balance? get currentBalance => _currentBalance;
  bool get isLoading => _isLoading;
  String? get error => _error;

  double get totalIncome => _transactions
      .where((t) => t.type == TransactionType.income && t.status == TransactionStatus.completed)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get totalExpenses => _transactions
      .where((t) => t.type == TransactionType.expense && t.status == TransactionStatus.completed)
      .fold(0.0, (sum, t) => sum + t.amount);

  double get netBalance => totalIncome - totalExpenses;

  Future<void> loadInitialData() async {
    _setLoading(true);
    _clearError();

    try {
      final accounts = await _accountRepository.getAccountsByUser(_defaultUserId);
      if (accounts.isNotEmpty) {
        _currentAccount = accounts.first;
        await _loadTransactions();
        await _calculateBalance();
      } else {
        await _createDefaultAccount();
      }
    } catch (e) {
      _setError('Error al cargar datos iniciales: ${e.toString()}');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loadTransactions() async {
    if (_currentAccount == null) return;

    try {
      final result = await _transactionRepository.getTransactionsByAccount(_currentAccount!.id);
      _transactions = result
        ..sort((a, b) => b.date.compareTo(a.date));
      notifyListeners();
    } catch (e) {
      _setError('Error al cargar transacciones: ${e.toString()}');
    }
  }

  Future<void> _calculateBalance() async {
    if (_currentAccount == null) return;

    try {
      _currentBalance = await _calculateBalanceUseCase.execute(_currentAccount!.id);
      notifyListeners();
    } catch (e) {
      _setError('Error al calcular balance: ${e.toString()}');
    }
  }

  Future<void> _createDefaultAccount() async {
    final defaultAccount = Account(
      id: 'default_account_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Cuenta Principal',
      userId: _defaultUserId,
      initialBalance: 0.0,
      currency: Currency.usd,
      type: AccountType.checking,
      createdAt: DateTime.now(),
    );

    await _accountRepository.createAccount(defaultAccount);
    _currentAccount = defaultAccount;
    _currentBalance = Balance(
      id: 'balance_${DateTime.now().millisecondsSinceEpoch}',
      accountId: defaultAccount.id,
      currentBalance: 0.0,
      date: DateTime.now(),
      income: 0.0,
      expenses: 0.0,
      currency: Currency.usd,
    );
    notifyListeners();
  }

  Future<bool> addTransaction({
    required double amount,
    required String description,
    required String category,
    required bool isIncome,
  }) async {
    if (_currentAccount == null) {
      _setError('No hay cuenta activa');
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      final result = await _processTransactionUseCase.execute(
        ProcessTransactionParams(
          accountId: _currentAccount!.id,
          amount: amount,
          description: description,
          category: category,
          type: isIncome ? TransactionType.income : TransactionType.expense,
        ),
      );
      if (!result.success) {
        _setError(result.errorMessage ?? 'No se pudo procesar la transacción');
        return false;
      }

      await _loadTransactions();
      await _calculateBalance();
      return true;
    } catch (e) {
      _setError('Error al agregar transacción: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateTransaction(Transaction transaction) async {
    _setLoading(true);
    _clearError();

    try {
      await _transactionRepository.updateTransaction(transaction);
      await _loadTransactions();
      await _calculateBalance();
      return true;
    } catch (e) {
      _setError('Error al actualizar transacción: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteTransaction(String transactionId) async {
    _setLoading(true);
    _clearError();

    try {
      await _transactionRepository.deleteTransaction(transactionId);
      await _loadTransactions();
      await _calculateBalance();
      return true;
    } catch (e) {
      _setError('Error al eliminar transacción: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refreshData() async {
    await loadInitialData();
  }

  List<Transaction> getTransactionsByCategory(String category) {
    return _transactions.where((t) => t.category == category).toList();
  }

  List<Transaction> getTransactionsByDateRange(DateTime start, DateTime end) {
    return _transactions.where((t) => t.date.isAfter(start) && t.date.isBefore(end)).toList();
  }

  Map<String, double> getExpensesByCategory() {
    final Map<String, double> expenses = {};
    for (final transaction in _transactions) {
      if (transaction.type == TransactionType.expense) {
        expenses[transaction.category] = (expenses[transaction.category] ?? 0) + transaction.amount;
      }
    }
    return expenses;
  }

  Map<String, double> getIncomeByCategory() {
    final Map<String, double> income = {};
    for (final transaction in _transactions) {
      if (transaction.type == TransactionType.income) {
        income[transaction.category] = (income[transaction.category] ?? 0) + transaction.amount;
      }
    }
    return income;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }
}