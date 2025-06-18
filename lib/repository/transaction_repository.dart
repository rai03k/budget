import 'package:budget/data/local/app_database.dart';
import 'package:budget/data/local/tables/transaction_table.dart';
import 'package:drift/drift.dart';

class TransactionRepository {
  final AppDatabase _database;
  
  TransactionRepository(this._database);

  Future<List<Transaction>> getAllTransactions() async {
    return await _database.transactionDao.getAllTransactions();
  }

  Future<List<TransactionWithCategory>> getAllTransactionsWithCategory() async {
    return await _database.transactionDao.getAllTransactionsWithCategory();
  }

  Stream<List<TransactionWithCategory>> watchAllTransactionsWithCategory() {
    return _database.transactionDao.watchAllTransactionsWithCategory();
  }

  Future<Transaction?> getTransactionById(int id) async {
    return await _database.transactionDao.getTransactionById(id);
  }

  Future<int> saveTransaction({
    int? id,
    required int amount,
    required String itemName,
    required DateTime date,
    required int categoryId,
  }) async {
    final companion = TransactionTableCompanion(
      id: id != null ? Value(id) : const Value.absent(),
      amount: Value(amount),
      itemName: Value(itemName),
      date: Value(date),
      categoryId: Value(categoryId),
    );
    
    return await _database.transactionDao.saveTransaction(companion);
  }

  Future<void> saveAllTransactions(List<Map<String, dynamic>> transactions) async {
    final companions = transactions.map((t) => TransactionTableCompanion(
      id: t['id'] != null ? Value(t['id']) : const Value.absent(),
      amount: Value(t['amount']),
      itemName: Value(t['itemName']),
      date: Value(t['date']),
      categoryId: Value(t['categoryId']),
    )).toList();
    
    await _database.transactionDao.saveAllTransactions(companions);
  }

  Future<int> deleteTransaction(int id) async {
    return await _database.transactionDao.deleteTransaction(id);
  }

  Future<List<Transaction>> getTransactionsByDateRange(DateTime start, DateTime end) async {
    return await _database.transactionDao.getTransactionsByDateRange(start, end);
  }
}