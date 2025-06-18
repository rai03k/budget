import 'dart:io';

import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/common/enum/category_icons.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/category_table.dart';
import 'tables/transaction_table.dart';
import 'tables/budget_table.dart';

part 'app_database.g.dart';

// 以下は前回と同様の内容...
// (Enumの型コンバータ、JOIN用クラス、データベース本体、DAO定義)

// --- Enumとデータベース格納形式(String)の型コンバータ ---
class CategoryIconsConverter extends TypeConverter<CategoryIcons, String> {
  const CategoryIconsConverter();
  @override
  CategoryIcons fromSql(String fromDb) => CategoryIcons.values.byName(fromDb);
  @override
  String toSql(CategoryIcons value) => value.name;
}

class AppColorsConverter extends TypeConverter<AppColors, String> {
  const AppColorsConverter();
  @override
  AppColors fromSql(String fromDb) => AppColors.values.byName(fromDb);
  @override
  String toSql(AppColors value) => value.name;
}

// --- JOINの結果を格納するためのデータクラス ---
class TransactionWithCategory {
  final Transaction transaction;
  final Category category;
  TransactionWithCategory({required this.transaction, required this.category});
}

// --- データベース本体の定義 ---
@DriftDatabase(
  tables: [CategoryTable, TransactionTable, BudgetTable],
  daos: [CategoryDao, TransactionDao, BudgetDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  
  @override
  int get schemaVersion => 1;
  
  // シングルトンパターンを実装
  static AppDatabase? _instance;
  
  static AppDatabase get instance {
    _instance ??= AppDatabase();
    return _instance!;
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

// --- DAO (Data Access Object) の定義 ---
@DriftAccessor(tables: [CategoryTable])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(AppDatabase db) : super(db);
  
  // カテゴリを全て取得（ソート順でソート）
  Stream<List<Category>> watchAllCategories() =>
      (select(categoryTable)..orderBy([(c) => OrderingTerm(expression: c.sortOrder, mode: OrderingMode.asc)])).watch();
  
  Future<List<Category>> getAllCategories() =>
      (select(categoryTable)..orderBy([(c) => OrderingTerm(expression: c.sortOrder, mode: OrderingMode.asc)])).get();
  
  // IDで取得
  Future<Category?> getCategoryById(int id) =>
      (select(categoryTable)..where((c) => c.id.equals(id))).getSingleOrNull();
  
  // カテゴリを保存・更新
  Future<int> saveCategory(CategoryTableCompanion entry) =>
      into(categoryTable).insertOnConflictUpdate(entry);
  
  // カテゴリを削除
  Future<int> deleteCategory(int id) =>
      (delete(categoryTable)..where((c) => c.id.equals(id))).go();
}

@DriftAccessor(tables: [TransactionTable, CategoryTable])
class TransactionDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionDaoMixin {
  TransactionDao(AppDatabase db) : super(db);
  
  // 全取引をカテゴリ情報と一緒に取得
  Stream<List<TransactionWithCategory>> watchAllTransactionsWithCategory() {
    final query = select(transactionTable).join([
      innerJoin(categoryTable,
          categoryTable.id.equalsExp(transactionTable.categoryId))
    ]);
    return query.watch().map((rows) => rows
        .map((row) => TransactionWithCategory(
              transaction: row.readTable(transactionTable),
              category: row.readTable(categoryTable),
            ))
        .toList());
  }

  Future<List<TransactionWithCategory>> getAllTransactionsWithCategory() {
    final query = select(transactionTable).join([
      innerJoin(categoryTable,
          categoryTable.id.equalsExp(transactionTable.categoryId))
    ]);
    return query.get().then((rows) => rows
        .map((row) => TransactionWithCategory(
              transaction: row.readTable(transactionTable),
              category: row.readTable(categoryTable),
            ))
        .toList());
  }

  // 全取引を取得
  Future<List<Transaction>> getAllTransactions() =>
      select(transactionTable).get();

  // IDで取引を取得
  Future<Transaction?> getTransactionById(int id) =>
      (select(transactionTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  // 取引を保存・更新
  Future<int> saveTransaction(TransactionTableCompanion entry) =>
      into(transactionTable).insertOnConflictUpdate(entry);

  // 複数の取引を一括保存
  Future<void> saveAllTransactions(List<TransactionTableCompanion> entries) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(transactionTable, entries);
    });
  }

  // 取引を削除
  Future<int> deleteTransaction(int id) =>
      (delete(transactionTable)..where((t) => t.id.equals(id))).go();
}

@DriftAccessor(tables: [BudgetTable])
class BudgetDao extends DatabaseAccessor<AppDatabase> with _$BudgetDaoMixin {
  BudgetDao(AppDatabase db) : super(db);
  
  // 全予算を監視
  Stream<List<Budget>> watchAllBudgets() => select(budgetTable).watch();
  
  // 全予算を取得
  Future<List<Budget>> getAllBudgets() => select(budgetTable).get();
  
  // IDで予算を取得
  Future<Budget?> getBudgetById(int id) =>
      (select(budgetTable)..where((b) => b.id.equals(id))).getSingleOrNull();
  
  // 予算を保存・更新
  Future<int> saveBudget(BudgetTableCompanion entry) =>
      into(budgetTable).insertOnConflictUpdate(entry);
  
  // 予算を削除
  Future<int> deleteBudget(int id) =>
      (delete(budgetTable)..where((b) => b.id.equals(id))).go();
}
