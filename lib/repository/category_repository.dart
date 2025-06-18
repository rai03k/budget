import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/common/enum/category_icons.dart';
import 'package:budget/data/local/app_database.dart';
import 'package:budget/data/local/tables/category_table.dart';
import 'package:drift/drift.dart';

class CategoryRepository {
  final AppDatabase _database;
  
  CategoryRepository(this._database);

  /// すべてのカテゴリを取得
  Future<List<Category>> getAllCategories() async {
    return await _database.categoryDao.getAllCategories();
  }

  /// カテゴリを監視
  Stream<List<Category>> watchAllCategories() {
    return _database.categoryDao.watchAllCategories();
  }

  /// IDでカテゴリを取得
  Future<Category?> getCategoryById(int id) async {
    return await _database.categoryDao.getCategoryById(id);
  }

  /// カテゴリを保存・更新
  Future<int> saveCategory({
    int? id,
    required String categoryName,
    required CategoryIcons icon,
    required AppColors iconColor,
    int? sortOrder,
  }) async {
    final companion = CategoryTableCompanion(
      id: id != null ? Value(id) : const Value.absent(),
      categoryName: Value(categoryName),
      icon: Value(icon),
      iconColor: Value(iconColor),
      sortOrder: sortOrder != null ? Value(sortOrder) : const Value.absent(),
    );
    
    return await _database.categoryDao.saveCategory(companion);
  }

  /// カテゴリを削除
  Future<int> deleteCategory(int id) async {
    return await _database.categoryDao.deleteCategory(id);
  }
}
