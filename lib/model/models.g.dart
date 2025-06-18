// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryModelImpl _$$CategoryModelImplFromJson(Map<String, dynamic> json) =>
    _$CategoryModelImpl(
      id: (json['id'] as num).toInt(),
      categoryName: json['categoryName'] as String,
      icon: $enumDecode(_$CategoryIconsEnumMap, json['icon']),
      iconColor: $enumDecode(_$AppColorsEnumMap, json['iconColor']),
      sortOrder: (json['sortOrder'] as num).toInt(),
    );

Map<String, dynamic> _$$CategoryModelImplToJson(_$CategoryModelImpl instance) =>
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

_$TransactionModelImpl _$$TransactionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$TransactionModelImpl(
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      date: DateTime.parse(json['date'] as String),
      itemName: json['itemName'] as String,
      categoryId: (json['categoryId'] as num).toInt(),
    );

Map<String, dynamic> _$$TransactionModelImplToJson(
        _$TransactionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'itemName': instance.itemName,
      'categoryId': instance.categoryId,
    };

_$BudgetModelImpl _$$BudgetModelImplFromJson(Map<String, dynamic> json) =>
    _$BudgetModelImpl(
      id: (json['id'] as num).toInt(),
      amount: (json['amount'] as num).toInt(),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      categoryId: (json['categoryId'] as num).toInt(),
    );

Map<String, dynamic> _$$BudgetModelImplToJson(_$BudgetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'categoryId': instance.categoryId,
    };
