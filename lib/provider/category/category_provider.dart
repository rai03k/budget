import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/common/enum/app_icon.dart';
import 'package:budget/common/enum/category_icons.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../service/database_service.dart';
import '../budget/budget_provider.dart';

part 'category_provider.freezed.dart';
part 'category_provider.g.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState(
      {@Default(0) int id,
      @Default('なし') String title,
      @Default(CategoryIcons.restaurant) CategoryIcons icon,
      @Default(AppColors.green) AppColors color,
      BudgetState? budget}) = _CategoryState;

  // 削除されたカテゴリー用のデフォルトカテゴリ
  static const CategoryState unknownCategory = CategoryState(
    id: -1,
    title: '不明',
    icon: CategoryIcons.question,
    color: AppColors.grey,
  );
}

@Riverpod(keepAlive: true)
class Category extends _$Category {
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  Future<List<CategoryState>> build() async {
    return loadCategories();
  }

  Future<List<CategoryState>> loadCategories() async {
    final categories = await _databaseService.getAllCategories();

    return categories
        .map((category) => CategoryState(
              id: category.id,
              title: category.categoryName,
              icon: category.icon,
              color: category.iconColor,
            ))
        .toList();
  }

  Future<void> saveCategory(CategoryState categoryState) async {
    await _databaseService.saveCategory(
      id: categoryState.id != 0 ? categoryState.id : null,
      categoryName: categoryState.title,
      icon: categoryState.icon,
      iconColor: categoryState.color,
    );
    await refreshCategories(); // 保存後、リスト更新
  }

  Future<void> deleteCategory(int id) async {
    await _databaseService.deleteCategory(id);
    await refreshCategories();
  }

  // カテゴリーリストを更新
  Future<void> refreshCategories() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => loadCategories());
  }
}
