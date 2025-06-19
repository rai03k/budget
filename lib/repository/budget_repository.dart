import 'package:budget/data/local/app_database.dart';
import 'package:budget/data/local/tables/budget_table.dart';
import 'package:drift/drift.dart';

class BudgetRepository {
  final AppDatabase _database;
  
  BudgetRepository(this._database);

  Future<List<Budget>> getAllBudgets() async {
    return await _database.budgetDao.getAllBudgets();
  }

  Stream<List<Budget>> watchAllBudgets() {
    return _database.budgetDao.watchAllBudgets();
  }

  Future<Budget?> getBudgetById(int id) async {
    return await _database.budgetDao.getBudgetById(id);
  }

  Future<int> saveBudget({
    int? id,
    required int categoryId,
    required int year,
    required int month,
    required int budgetAmount,
  }) async {
    final companion = BudgetTableCompanion(
      id: id != null ? Value(id) : const Value.absent(),
      categoryId: Value(categoryId),
      year: Value(year),
      month: Value(month),
      budgetAmount: Value(budgetAmount),
      updatedAt: Value(DateTime.now()), // 更新日時を現在時刻に設定
    );
    
    return await _database.budgetDao.saveBudget(companion);
  }

  /// 特定のカテゴリと年月の予算を取得
  Future<Budget?> getBudgetByCategoryAndMonth(int categoryId, int year, int month) async {
    return await _database.budgetDao.getBudgetByCategoryAndMonth(categoryId, year, month);
  }

  Future<int> deleteBudget(int id) async {
    return await _database.budgetDao.deleteBudget(id);
  }
}