import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/common/enum/category_icons.dart';
import 'package:drift/drift.dart';

@DataClassName('Category')
class CategoryTable extends Table {
  IntColumn get id => integer().autoIncrement()(); // 主キー(自動インクリメント)
  TextColumn get categoryName => text().withDefault(const Constant(''))();
  TextColumn get icon => text().map(const CategoryIconsConverter())();
  TextColumn get iconColor => text().map(const AppColorsConverter())();
  IntColumn get sortOrder => integer()(); // 並び順
}

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
