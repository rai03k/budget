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
    int? budgetAmount,
    int? spentAmount,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final companion = BudgetTableCompanion(
      id: id != null ? Value(id) : const Value.absent(),
      budgetAmount: budgetAmount != null ? Value(budgetAmount) : const Value.absent(),
      spentAmount: spentAmount != null ? Value(spentAmount) : const Value.absent(),
      startDate: startDate != null ? Value(startDate) : const Value.absent(),
      endDate: endDate != null ? Value(endDate) : const Value.absent(),
    );
    
    return await _database.budgetDao.saveBudget(companion);
  }

  Future<int> deleteBudget(int id) async {
    return await _database.budgetDao.deleteBudget(id);
  }
}