import 'package:budget/data/local/app_database.dart';
import 'package:budget/data/local/tables/budget_table.dart';
import 'package:budget/data/local/tables/category_table.dart';
import 'package:budget/data/local/tables/transaction_table.dart';
import 'package:budget/common/enum/category_icons.dart';
import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/repository/category_repository.dart';
import 'package:budget/repository/transaction_repository.dart';
import 'package:budget/repository/budget_repository.dart';
import 'package:drift/drift.dart';

/// Driftデータベースを使用するサービスクラス
/// IsarServiceを置き換える
class DatabaseService {
  static DatabaseService? _instance;
  late AppDatabase _database;
  late CategoryRepository _categoryRepository;
  late TransactionRepository _transactionRepository;
  late BudgetRepository _budgetRepository;

  DatabaseService._() {
    _database = AppDatabase.instance;
    _categoryRepository = CategoryRepository(_database);
    _transactionRepository = TransactionRepository(_database);
    _budgetRepository = BudgetRepository(_database);
  }

  static DatabaseService get instance {
    _instance ??= DatabaseService._();
    return _instance!;
  }

  AppDatabase get database => _database;
  CategoryRepository get categoryRepository => _categoryRepository;
  TransactionRepository get transactionRepository => _transactionRepository;
  BudgetRepository get budgetRepository => _budgetRepository;

  // --- Category 関連のメソッド ---

  /// 全カテゴリを取得（ソート順）
  Future<List<Category>> getAllCategories() async {
    return await _categoryRepository.getAllCategories();
  }

  /// カテゴリを監視
  Stream<List<Category>> watchAllCategories() {
    return _categoryRepository.watchAllCategories();
  }

  /// IDでカテゴリを取得
  Future<Category?> getCategoryById(int id) async {
    return await _categoryRepository.getCategoryById(id);
  }

  /// カテゴリを保存・更新
  Future<int> saveCategory({
    int? id,
    required String categoryName,
    required CategoryIcons icon,
    required AppColors iconColor,
    int? sortOrder,
  }) async {
    // sortOrderが指定されていない場合、最大値+1を設定
    int finalSortOrder = sortOrder ?? 0;
    if (sortOrder == null) {
      final allCategories = await getAllCategories();
      if (allCategories.isNotEmpty) {
        final maxSortOrder = allCategories
            .map((c) => c.sortOrder ?? 0)
            .reduce((a, b) => a > b ? a : b);
        finalSortOrder = maxSortOrder + 1;
      }
    }

    return await _categoryRepository.saveCategory(
      id: id,
      categoryName: categoryName,
      icon: icon,
      iconColor: iconColor,
      sortOrder: finalSortOrder,
    );
  }

  /// カテゴリを削除
  Future<int> deleteCategory(int id) async {
    return await _categoryRepository.deleteCategory(id);
  }

  // --- Transaction 関連のメソッド ---

  /// 全取引を取得
  Future<List<Transaction>> getAllTransactions() async {
    return await _transactionRepository.getAllTransactions();
  }

  /// 取引をカテゴリ情報と一緒に取得
  Future<List<TransactionWithCategory>> getAllTransactionsWithCategory() async {
    return await _transactionRepository.getAllTransactionsWithCategory();
  }

  /// 取引をカテゴリ情報と一緒に監視
  Stream<List<TransactionWithCategory>> watchAllTransactionsWithCategory() {
    return _transactionRepository.watchAllTransactionsWithCategory();
  }

  /// IDで取引を取得
  Future<Transaction?> getTransactionById(int id) async {
    return await _transactionRepository.getTransactionById(id);
  }

  /// 取引を保存・更新
  Future<int> saveTransaction({
    int? id,
    required int amount,
    required String itemName,
    required DateTime date,
    required int categoryId,
  }) async {
    return await _transactionRepository.saveTransaction(
      id: id,
      amount: amount,
      itemName: itemName,
      date: date,
      categoryId: categoryId,
    );
  }

  /// 複数の取引を一括保存
  Future<void> saveAllTransactions(List<Map<String, dynamic>> transactions) async {
    await _transactionRepository.saveAllTransactions(transactions);
  }

  /// 取引を削除
  Future<int> deleteTransaction(int id) async {
    return await _transactionRepository.deleteTransaction(id);
  }

  // --- Budget 関連のメソッド ---

  /// 全予算を取得
  Future<List<Budget>> getAllBudgets() async {
    return await _budgetRepository.getAllBudgets();
  }

  /// 予算を監視
  Stream<List<Budget>> watchAllBudgets() {
    return _budgetRepository.watchAllBudgets();
  }

  /// IDで予算を取得
  Future<Budget?> getBudgetById(int id) async {
    return await _budgetRepository.getBudgetById(id);
  }

  /// 予算を保存・更新
  Future<int> saveBudget({
    int? id,
    int? budgetAmount,
    int? spentAmount,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await _budgetRepository.saveBudget(
      id: id,
      budgetAmount: budgetAmount,
      spentAmount: spentAmount,
      startDate: startDate,
      endDate: endDate,
    );
  }

  /// 予算を削除
  Future<int> deleteBudget(int id) async {
    return await _budgetRepository.deleteBudget(id);
  }

  /// データベースを閉じる
  Future<void> closeDatabase() async {
    await _database.close();
  }
}