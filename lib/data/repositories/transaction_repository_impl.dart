package finance_app.data.repositories;

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaction_model.dart';
import '../../domain/repositories/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  static const String _tableName = 'transactions';
  static const String _dbName = 'finance_app.db';
  static const int _dbVersion = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id TEXT PRIMARY KEY,
        account_id TEXT NOT NULL,
        amount REAL NOT NULL,
        description TEXT NOT NULL,
        date INTEGER NOT NULL,
        category TEXT NOT NULL,
        type TEXT NOT NULL,
        status TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_account_id ON $_tableName (account_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_date ON $_tableName (date DESC)
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_status ON $_tableName (status)
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE $_tableName ADD COLUMN tags TEXT
      ''');
    }
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      orderBy: 'date DESC',
    );
    return maps.map((map) => TransactionModel.fromDbMap(map)).toList();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByAccount(
      String accountId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'account_id = ?',
      whereArgs: [accountId],
      orderBy: 'date DESC',
    );
    return maps.map((map) => TransactionModel.fromDbMap(map)).toList();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'date >= ? AND date <= ?',
      whereArgs: [
        startDate.millisecondsSinceEpoch,
        endDate.millisecondsSinceEpoch,
      ],
      orderBy: 'date DESC',
    );
    return maps.map((map) => TransactionModel.fromDbMap(map)).toList();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByStatus(String status) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'status = ?',
      whereArgs: [status],
      orderBy: 'date DESC',
    );
    return maps.map((map) => TransactionModel.fromDbMap(map)).toList();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByCategory(
      String category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'date DESC',
    );
    return maps.map((map) => TransactionModel.fromDbMap(map)).toList();
  }

  @override
  Future<TransactionModel?> getTransactionById(String id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return TransactionModel.fromDbMap(maps.first);
  }

  @override
  Future<void> insertTransaction(TransactionModel transaction) async {
    final db = await database;
    final mapWithTimestamps = transaction.toDbMap();
    mapWithTimestamps['created_at'] =
        DateTime.now().millisecondsSinceEpoch;
    await db.insert(
      _tableName,
      mapWithTimestamps,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> updateTransaction(TransactionModel transaction) async {
    final db = await database;
    final mapWithTimestamps = transaction.toDbMap();
    mapWithTimestamps['updated_at'] =
        DateTime.now().millisecondsSinceEpoch;
    await db.update(
      _tableName,
      mapWithTimestamps,
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteAllTransactions() async {
    final db = await database;
    await db.delete(_tableName);
  }

  @override
  Future<double> calculateTotalByType(String accountId, String type) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM $_tableName '
      'WHERE account_id = ? AND type = ? AND status = ?',
      [accountId, type, 'completed'],
    );
    final total = result.first['total'];
    return total != null ? (total as num).toDouble() : 0.0;
  }

  @override
  Future<double> calculateBalance(String accountId) async {
    final db = await database;
    final incomeResult = await db.rawQuery(
      'SELECT SUM(amount) as total FROM $_tableName '
      'WHERE account_id = ? AND (type = ? OR type = ?) AND status = ?',
      [accountId, 'income', 'credit', 'completed'],
    );
    final expenseResult = await db.rawQuery(
      'SELECT SUM(amount) as total FROM $_tableName '
      'WHERE account_id = ? AND (type = ? OR type = ?) AND status = ?',
      [accountId, 'expense', 'debit', 'completed'],
    );

    final income = incomeResult.first['total'];
    final expense = expenseResult.first['total'];

    final totalIncome = income != null ? (income as num).toDouble() : 0.0;
    final totalExpense = expense != null ? (expense as num).toDouble() : 0.0;

    return totalIncome - totalExpense;
  }

  @override
  Future<int> countTransactionsByAccount(String accountId) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $_tableName WHERE account_id = ?',
      [accountId],
    );
    return (result.first['count'] as int?) ?? 0;
  }

  @override
  Future<List<TransactionModel>> searchTransactions(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: 'description LIKE ? OR category LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'date DESC',
    );
    return maps.map((map) => TransactionModel.fromDbMap(map)).toList();
  }

  @override
  Future<void> batchInsertTransactions(
      List<TransactionModel> transactions) async {
    final db = await database;
    final batch = db.batch();
    final now = DateTime.now().millisecondsSinceEpoch;

    for (final transaction in transactions) {
      final mapWithTimestamps = transaction.toDbMap();
      mapWithTimestamps['created_at'] = now;
      batch.insert(
        _tableName,
        mapWithTimestamps,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete(_tableName);
  }
}