import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path_helper;
import 'package:finance_app/data/models/transaction_model.dart';

abstract class LocalTransactionDataSource {
  Future<void> initialize();
  Future<List<TransactionModel>> getTransactions();
  Future<TransactionModel?> getTransactionById(String id);
  Future<List<TransactionModel>> getTransactionsByAccountId(String accountId);
  Future<TransactionModel> insertTransaction(TransactionModel transaction);
  Future<TransactionModel> updateTransaction(TransactionModel transaction);
  Future<void> deleteTransaction(String id);
  Future<void> deleteTransactionsByAccountId(String accountId);
  Future<List<TransactionModel>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  );
  Future<List<TransactionModel>> getTransactionsByCategory(String category);
  Future<void> clearAllTransactions();
  Future<void> close();
}

class LocalTransactionDataSourceImpl implements LocalTransactionDataSource {
  Database? _database;
  static const String _databaseName = 'finance_app.db';
  static const int _databaseVersion = 1;
  static const String _tableTransactions = 'transactions';

  LocalTransactionDataSourceImpl();

  Future<Database> get database async {
    if (_database != null) return _database!;
    await initialize();
    return _database!;
  }

  @override
  Future<void> initialize() async {
    if (_database != null && _database!.isOpen) return;

    final databasesPath = await getDatabasesPath();
    final dbPath = path_helper.join(databasesPath, _databaseName);

    _database = await openDatabase(
      dbPath,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableTransactions (
        id TEXT PRIMARY KEY,
        account_id TEXT NOT NULL,
        amount REAL NOT NULL,
        description TEXT,
        date INTEGER NOT NULL,
        category TEXT NOT NULL,
        type TEXT NOT NULL,
        status TEXT NOT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_account_id ON $_tableTransactions (account_id)
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_date ON $_tableTransactions (date)
    ''');

    await db.execute('''
      CREATE INDEX idx_transactions_category ON $_tableTransactions (category)
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Migraciones futuras aquí
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final db = await database;
    final maps = await db.query(
      _tableTransactions,
      orderBy: 'date DESC',
    );
    return maps.map((map) => _mapToTransactionModel(map)).toList();
  }

  @override
  Future<TransactionModel?> getTransactionById(String id) async {
    final db = await database;
    final maps = await db.query(
      _tableTransactions,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return _mapToTransactionModel(maps.first);
  }

  @override
  Future<List<TransactionModel>> getTransactionsByAccountId(
    String accountId,
  ) async {
    final db = await database;
    final maps = await db.query(
      _tableTransactions,
      where: 'account_id = ?',
      whereArgs: [accountId],
      orderBy: 'date DESC',
    );
    return maps.map((map) => _mapToTransactionModel(map)).toList();
  }

  @override
  Future<TransactionModel> insertTransaction(
    TransactionModel transaction,
  ) async {
    final db = await database;
    final map = _transactionModelToMap(transaction);
    await db.insert(
      _tableTransactions,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return transaction;
  }

  @override
  Future<TransactionModel> updateTransaction(
    TransactionModel transaction,
  ) async {
    final db = await database;
    final map = _transactionModelToMap(transaction);
    map['updated_at'] = DateTime.now().millisecondsSinceEpoch;

    final rowsAffected = await db.update(
      _tableTransactions,
      map,
      where: 'id = ?',
      whereArgs: [transaction.id],
    );

    if (rowsAffected == 0) {
      throw LocalDataSourceException(
        message: 'No se encontró la transacción para actualizar: ${transaction.id}',
      );
    }

    return transaction;
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await database;
    await db.delete(
      _tableTransactions,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteTransactionsByAccountId(String accountId) async {
    final db = await database;
    await db.delete(
      _tableTransactions,
      where: 'account_id = ?',
      whereArgs: [accountId],
    );
  }

  @override
  Future<List<TransactionModel>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final db = await database;
    final startMs = start.millisecondsSinceEpoch;
    final endMs = end.millisecondsSinceEpoch;

    final maps = await db.query(
      _tableTransactions,
      where: 'date >= ? AND date <= ?',
      whereArgs: [startMs, endMs],
      orderBy: 'date DESC',
    );
    return maps.map((map) => _mapToTransactionModel(map)).toList();
  }

  @override
  Future<List<TransactionModel>> getTransactionsByCategory(
    String category,
  ) async {
    final db = await database;
    final maps = await db.query(
      _tableTransactions,
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'date DESC',
    );
    return maps.map((map) => _mapToTransactionModel(map)).toList();
  }

  @override
  Future<void> clearAllTransactions() async {
    final db = await database;
    await db.delete(_tableTransactions);
  }

  @override
  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }

  TransactionModel _mapToTransactionModel(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      accountId: map['account_id'] as String,
      amount: (map['amount'] as num).toDouble(),
      description: (map['description'] as String?) ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      category: map['category'] as String,
      type: map['type'] as String,
      status: map['status'] as String,
    );
  }

  Map<String, dynamic> _transactionModelToMap(TransactionModel model) {
    return {
      'id': model.id,
      'account_id': model.accountId,
      'amount': model.amount,
      'description': model.description,
      'date': model.date.millisecondsSinceEpoch,
      'category': model.category,
      'type': model.type,
      'status': model.status,
      'created_at': DateTime.now().millisecondsSinceEpoch,
    };
  }
}

class LocalDataSourceException implements Exception {
  final String message;

  const LocalDataSourceException({required this.message});

  @override
  String toString() => 'LocalDataSourceException: $message';
}