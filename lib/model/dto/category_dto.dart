import 'package:budget/common/enum/app_colors.dart';
import 'package:budget/common/enum/category_icons.dart';
import 'package:budget/data/local/app_database.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:drift/drift.dart' as drift;

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDto {
  final int? id;
  final String categoryName;
  final CategoryIcons icon;
  final AppColors iconColor;
  final int? sortOrder;

  const CategoryDto({
    this.id,
    required this.categoryName,
    required this.icon,
    required this.iconColor,
    this.sortOrder,
  });

  factory CategoryDto.fromJson(Map<String, dynamic> json) =>
      _$CategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDtoToJson(this);

  factory CategoryDto.fromEntity(Category category) {
    return CategoryDto(
      id: category.id,
      categoryName: category.categoryName,
      icon: CategoryIcons.values.firstWhere((e) => e.name == category.icon),
      iconColor: AppColors.values.firstWhere((e) => e.name == category.iconColor),
      sortOrder: category.sortOrder,
    );
  }

  CategoryTableCompanion toEntity() {
    return CategoryTableCompanion(
      id: id != null ? drift.Value(id!) : const drift.Value.absent(),
      categoryName: drift.Value(categoryName),
      icon: drift.Value(icon),
      iconColor: drift.Value(iconColor),
      sortOrder: drift.Value(sortOrder ?? 0),
    );
  }
}