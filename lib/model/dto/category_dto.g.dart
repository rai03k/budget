// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDto _$CategoryDtoFromJson(Map<String, dynamic> json) => CategoryDto(
      id: (json['id'] as num?)?.toInt(),
      categoryName: json['categoryName'] as String,
      icon: $enumDecode(_$CategoryIconsEnumMap, json['icon']),
      iconColor: $enumDecode(_$AppColorsEnumMap, json['iconColor']),
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryDtoToJson(CategoryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
      'icon': _$CategoryIconsEnumMap[instance.icon]!,
      'iconColor': _$AppColorsEnumMap[instance.iconColor]!,
      'sortOrder': instance.sortOrder,
    };

const _$CategoryIconsEnumMap = {
  CategoryIcons.restaurant: 'restaurant',
  CategoryIcons.menu: 'menu',
  CategoryIcons.history: 'history',
  CategoryIcons.home: 'home',
  CategoryIcons.settings: 'settings',
  CategoryIcons.star: 'star',
  CategoryIcons.favorite: 'favorite',
  CategoryIcons.person: 'person',
  CategoryIcons.email: 'email',
  CategoryIcons.phone: 'phone',
  CategoryIcons.locationOn: 'locationOn',
  CategoryIcons.calendarToday: 'calendarToday',
  CategoryIcons.cameraAlt: 'cameraAlt',
  CategoryIcons.musicNote: 'musicNote',
  CategoryIcons.shoppingCart: 'shoppingCart',
  CategoryIcons.work: 'work',
  CategoryIcons.school: 'school',
  CategoryIcons.carRental: 'carRental',
  CategoryIcons.question: 'question',
};

const _$AppColorsEnumMap = {
  AppColors.red: 'red',
  AppColors.blue: 'blue',
  AppColors.green: 'green',
  AppColors.yellow: 'yellow',
  AppColors.orange: 'orange',
  AppColors.purple: 'purple',
  AppColors.pink: 'pink',
  AppColors.brown: 'brown',
  AppColors.cyan: 'cyan',
  AppColors.lime: 'lime',
  AppColors.indigo: 'indigo',
  AppColors.teal: 'teal',
  AppColors.amber: 'amber',
  AppColors.grey: 'grey',
};
