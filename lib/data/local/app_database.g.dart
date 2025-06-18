// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CategoryTableTable extends CategoryTable
    with TableInfo<$CategoryTableTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryNameMeta =
      const VerificationMeta('categoryName');
  @override
  late final GeneratedColumn<String> categoryName = GeneratedColumn<String>(
      'category_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  @override
  late final GeneratedColumnWithTypeConverter<CategoryIcons, String> icon =
      GeneratedColumn<String>('icon', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<CategoryIcons>($CategoryTableTable.$convertericon);
  @override
  late final GeneratedColumnWithTypeConverter<AppColors, String> iconColor =
      GeneratedColumn<String>('icon_color', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<AppColors>($CategoryTableTable.$convertericonColor);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, categoryName, icon, iconColor, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_table';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_name')) {
      context.handle(
          _categoryNameMeta,
          categoryName.isAcceptableOrUnknown(
              data['category_name']!, _categoryNameMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      categoryName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_name'])!,
      icon: $CategoryTableTable.$convertericon.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!),
      iconColor: $CategoryTableTable.$convertericonColor.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}icon_color'])!),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
    );
  }

  @override
  $CategoryTableTable createAlias(String alias) {
    return $CategoryTableTable(attachedDatabase, alias);
  }

  static TypeConverter<CategoryIcons, String> $convertericon =
      const CategoryIconsConverter();
  static TypeConverter<AppColors, String> $convertericonColor =
      const AppColorsConverter();
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String categoryName;
  final CategoryIcons icon;
  final AppColors iconColor;
  final int sortOrder;
  const Category(
      {required this.id,
      required this.categoryName,
      required this.icon,
      required this.iconColor,
      required this.sortOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_name'] = Variable<String>(categoryName);
    {
      map['icon'] =
          Variable<String>($CategoryTableTable.$convertericon.toSql(icon));
    }
    {
      map['icon_color'] = Variable<String>(
          $CategoryTableTable.$convertericonColor.toSql(iconColor));
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CategoryTableCompanion toCompanion(bool nullToAbsent) {
    return CategoryTableCompanion(
      id: Value(id),
      categoryName: Value(categoryName),
      icon: Value(icon),
      iconColor: Value(iconColor),
      sortOrder: Value(sortOrder),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      categoryName: serializer.fromJson<String>(json['categoryName']),
      icon: serializer.fromJson<CategoryIcons>(json['icon']),
      iconColor: serializer.fromJson<AppColors>(json['iconColor']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryName': serializer.toJson<String>(categoryName),
      'icon': serializer.toJson<CategoryIcons>(icon),
      'iconColor': serializer.toJson<AppColors>(iconColor),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  Category copyWith(
          {int? id,
          String? categoryName,
          CategoryIcons? icon,
          AppColors? iconColor,
          int? sortOrder}) =>
      Category(
        id: id ?? this.id,
        categoryName: categoryName ?? this.categoryName,
        icon: icon ?? this.icon,
        iconColor: iconColor ?? this.iconColor,
        sortOrder: sortOrder ?? this.sortOrder,
      );
  Category copyWithCompanion(CategoryTableCompanion data) {
    return Category(
      id: data.id.present ? data.id.value : this.id,
      categoryName: data.categoryName.present
          ? data.categoryName.value
          : this.categoryName,
      icon: data.icon.present ? data.icon.value : this.icon,
      iconColor: data.iconColor.present ? data.iconColor.value : this.iconColor,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName, ')
          ..write('icon: $icon, ')
          ..write('iconColor: $iconColor, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, categoryName, icon, iconColor, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.categoryName == this.categoryName &&
          other.icon == this.icon &&
          other.iconColor == this.iconColor &&
          other.sortOrder == this.sortOrder);
}

class CategoryTableCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> categoryName;
  final Value<CategoryIcons> icon;
  final Value<AppColors> iconColor;
  final Value<int> sortOrder;
  const CategoryTableCompanion({
    this.id = const Value.absent(),
    this.categoryName = const Value.absent(),
    this.icon = const Value.absent(),
    this.iconColor = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  CategoryTableCompanion.insert({
    this.id = const Value.absent(),
    this.categoryName = const Value.absent(),
    required CategoryIcons icon,
    required AppColors iconColor,
    required int sortOrder,
  })  : icon = Value(icon),
        iconColor = Value(iconColor),
        sortOrder = Value(sortOrder);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? categoryName,
    Expression<String>? icon,
    Expression<String>? iconColor,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryName != null) 'category_name': categoryName,
      if (icon != null) 'icon': icon,
      if (iconColor != null) 'icon_color': iconColor,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  CategoryTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? categoryName,
      Value<CategoryIcons>? icon,
      Value<AppColors>? iconColor,
      Value<int>? sortOrder}) {
    return CategoryTableCompanion(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryName.present) {
      map['category_name'] = Variable<String>(categoryName.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(
          $CategoryTableTable.$convertericon.toSql(icon.value));
    }
    if (iconColor.present) {
      map['icon_color'] = Variable<String>(
          $CategoryTableTable.$convertericonColor.toSql(iconColor.value));
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryTableCompanion(')
          ..write('id: $id, ')
          ..write('categoryName: $categoryName, ')
          ..write('icon: $icon, ')
          ..write('iconColor: $iconColor, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $TransactionTableTable extends TransactionTable
    with TableInfo<$TransactionTableTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _itemNameMeta =
      const VerificationMeta('itemName');
  @override
  late final GeneratedColumn<String> itemName = GeneratedColumn<String>(
      'item_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES category_table (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, amount, date, itemName, categoryId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_table';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('item_name')) {
      context.handle(_itemNameMeta,
          itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta));
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      itemName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}item_name'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
    );
  }

  @override
  $TransactionTableTable createAlias(String alias) {
    return $TransactionTableTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final int id;
  final int amount;
  final DateTime date;
  final String itemName;
  final int categoryId;
  const Transaction(
      {required this.id,
      required this.amount,
      required this.date,
      required this.itemName,
      required this.categoryId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<int>(amount);
    map['date'] = Variable<DateTime>(date);
    map['item_name'] = Variable<String>(itemName);
    map['category_id'] = Variable<int>(categoryId);
    return map;
  }

  TransactionTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionTableCompanion(
      id: Value(id),
      amount: Value(amount),
      date: Value(date),
      itemName: Value(itemName),
      categoryId: Value(categoryId),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      itemName: serializer.fromJson<String>(json['itemName']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<int>(amount),
      'date': serializer.toJson<DateTime>(date),
      'itemName': serializer.toJson<String>(itemName),
      'categoryId': serializer.toJson<int>(categoryId),
    };
  }

  Transaction copyWith(
          {int? id,
          int? amount,
          DateTime? date,
          String? itemName,
          int? categoryId}) =>
      Transaction(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        itemName: itemName ?? this.itemName,
        categoryId: categoryId ?? this.categoryId,
      );
  Transaction copyWithCompanion(TransactionTableCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      itemName: data.itemName.present ? data.itemName.value : this.itemName,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('itemName: $itemName, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, amount, date, itemName, categoryId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.itemName == this.itemName &&
          other.categoryId == this.categoryId);
}

class TransactionTableCompanion extends UpdateCompanion<Transaction> {
  final Value<int> id;
  final Value<int> amount;
  final Value<DateTime> date;
  final Value<String> itemName;
  final Value<int> categoryId;
  const TransactionTableCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.itemName = const Value.absent(),
    this.categoryId = const Value.absent(),
  });
  TransactionTableCompanion.insert({
    this.id = const Value.absent(),
    required int amount,
    required DateTime date,
    required String itemName,
    required int categoryId,
  })  : amount = Value(amount),
        date = Value(date),
        itemName = Value(itemName),
        categoryId = Value(categoryId);
  static Insertable<Transaction> custom({
    Expression<int>? id,
    Expression<int>? amount,
    Expression<DateTime>? date,
    Expression<String>? itemName,
    Expression<int>? categoryId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (itemName != null) 'item_name': itemName,
      if (categoryId != null) 'category_id': categoryId,
    });
  }

  TransactionTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? amount,
      Value<DateTime>? date,
      Value<String>? itemName,
      Value<int>? categoryId}) {
    return TransactionTableCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      itemName: itemName ?? this.itemName,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionTableCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('itemName: $itemName, ')
          ..write('categoryId: $categoryId')
          ..write(')'))
        .toString();
  }
}

class $BudgetTableTable extends BudgetTable
    with TableInfo<$BudgetTableTable, Budget> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _budgetAmountMeta =
      const VerificationMeta('budgetAmount');
  @override
  late final GeneratedColumn<int> budgetAmount = GeneratedColumn<int>(
      'budget_amount', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _spentAmountMeta =
      const VerificationMeta('spentAmount');
  @override
  late final GeneratedColumn<int> spentAmount = GeneratedColumn<int>(
      'spent_amount', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, budgetAmount, spentAmount, startDate, endDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_table';
  @override
  VerificationContext validateIntegrity(Insertable<Budget> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('budget_amount')) {
      context.handle(
          _budgetAmountMeta,
          budgetAmount.isAcceptableOrUnknown(
              data['budget_amount']!, _budgetAmountMeta));
    }
    if (data.containsKey('spent_amount')) {
      context.handle(
          _spentAmountMeta,
          spentAmount.isAcceptableOrUnknown(
              data['spent_amount']!, _spentAmountMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Budget map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Budget(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      budgetAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}budget_amount']),
      spentAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}spent_amount']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date']),
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
    );
  }

  @override
  $BudgetTableTable createAlias(String alias) {
    return $BudgetTableTable(attachedDatabase, alias);
  }
}

class Budget extends DataClass implements Insertable<Budget> {
  final int id;
  final int? budgetAmount;
  final int? spentAmount;
  final DateTime? startDate;
  final DateTime? endDate;
  const Budget(
      {required this.id,
      this.budgetAmount,
      this.spentAmount,
      this.startDate,
      this.endDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || budgetAmount != null) {
      map['budget_amount'] = Variable<int>(budgetAmount);
    }
    if (!nullToAbsent || spentAmount != null) {
      map['spent_amount'] = Variable<int>(spentAmount);
    }
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    return map;
  }

  BudgetTableCompanion toCompanion(bool nullToAbsent) {
    return BudgetTableCompanion(
      id: Value(id),
      budgetAmount: budgetAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(budgetAmount),
      spentAmount: spentAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(spentAmount),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
    );
  }

  factory Budget.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Budget(
      id: serializer.fromJson<int>(json['id']),
      budgetAmount: serializer.fromJson<int?>(json['budgetAmount']),
      spentAmount: serializer.fromJson<int?>(json['spentAmount']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'budgetAmount': serializer.toJson<int?>(budgetAmount),
      'spentAmount': serializer.toJson<int?>(spentAmount),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
    };
  }

  Budget copyWith(
          {int? id,
          Value<int?> budgetAmount = const Value.absent(),
          Value<int?> spentAmount = const Value.absent(),
          Value<DateTime?> startDate = const Value.absent(),
          Value<DateTime?> endDate = const Value.absent()}) =>
      Budget(
        id: id ?? this.id,
        budgetAmount:
            budgetAmount.present ? budgetAmount.value : this.budgetAmount,
        spentAmount: spentAmount.present ? spentAmount.value : this.spentAmount,
        startDate: startDate.present ? startDate.value : this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
      );
  Budget copyWithCompanion(BudgetTableCompanion data) {
    return Budget(
      id: data.id.present ? data.id.value : this.id,
      budgetAmount: data.budgetAmount.present
          ? data.budgetAmount.value
          : this.budgetAmount,
      spentAmount:
          data.spentAmount.present ? data.spentAmount.value : this.spentAmount,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Budget(')
          ..write('id: $id, ')
          ..write('budgetAmount: $budgetAmount, ')
          ..write('spentAmount: $spentAmount, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, budgetAmount, spentAmount, startDate, endDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Budget &&
          other.id == this.id &&
          other.budgetAmount == this.budgetAmount &&
          other.spentAmount == this.spentAmount &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate);
}

class BudgetTableCompanion extends UpdateCompanion<Budget> {
  final Value<int> id;
  final Value<int?> budgetAmount;
  final Value<int?> spentAmount;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  const BudgetTableCompanion({
    this.id = const Value.absent(),
    this.budgetAmount = const Value.absent(),
    this.spentAmount = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
  });
  BudgetTableCompanion.insert({
    this.id = const Value.absent(),
    this.budgetAmount = const Value.absent(),
    this.spentAmount = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
  });
  static Insertable<Budget> custom({
    Expression<int>? id,
    Expression<int>? budgetAmount,
    Expression<int>? spentAmount,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (budgetAmount != null) 'budget_amount': budgetAmount,
      if (spentAmount != null) 'spent_amount': spentAmount,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
    });
  }

  BudgetTableCompanion copyWith(
      {Value<int>? id,
      Value<int?>? budgetAmount,
      Value<int?>? spentAmount,
      Value<DateTime?>? startDate,
      Value<DateTime?>? endDate}) {
    return BudgetTableCompanion(
      id: id ?? this.id,
      budgetAmount: budgetAmount ?? this.budgetAmount,
      spentAmount: spentAmount ?? this.spentAmount,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (budgetAmount.present) {
      map['budget_amount'] = Variable<int>(budgetAmount.value);
    }
    if (spentAmount.present) {
      map['spent_amount'] = Variable<int>(spentAmount.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetTableCompanion(')
          ..write('id: $id, ')
          ..write('budgetAmount: $budgetAmount, ')
          ..write('spentAmount: $spentAmount, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CategoryTableTable categoryTable = $CategoryTableTable(this);
  late final $TransactionTableTable transactionTable =
      $TransactionTableTable(this);
  late final $BudgetTableTable budgetTable = $BudgetTableTable(this);
  late final CategoryDao categoryDao = CategoryDao(this as AppDatabase);
  late final TransactionDao transactionDao =
      TransactionDao(this as AppDatabase);
  late final BudgetDao budgetDao = BudgetDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [categoryTable, transactionTable, budgetTable];
}

typedef $$CategoryTableTableCreateCompanionBuilder = CategoryTableCompanion
    Function({
  Value<int> id,
  Value<String> categoryName,
  required CategoryIcons icon,
  required AppColors iconColor,
  required int sortOrder,
});
typedef $$CategoryTableTableUpdateCompanionBuilder = CategoryTableCompanion
    Function({
  Value<int> id,
  Value<String> categoryName,
  Value<CategoryIcons> icon,
  Value<AppColors> iconColor,
  Value<int> sortOrder,
});

final class $$CategoryTableTableReferences
    extends BaseReferences<_$AppDatabase, $CategoryTableTable, Category> {
  $$CategoryTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TransactionTableTable, List<Transaction>>
      _transactionTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.transactionTable,
              aliasName: $_aliasNameGenerator(
                  db.categoryTable.id, db.transactionTable.categoryId));

  $$TransactionTableTableProcessedTableManager get transactionTableRefs {
    final manager =
        $$TransactionTableTableTableManager($_db, $_db.transactionTable)
            .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_transactionTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryTableTable> {
  $$CategoryTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryName => $composableBuilder(
      column: $table.categoryName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<CategoryIcons, CategoryIcons, String>
      get icon => $composableBuilder(
          column: $table.icon,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<AppColors, AppColors, String> get iconColor =>
      $composableBuilder(
          column: $table.iconColor,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  Expression<bool> transactionTableRefs(
      Expression<bool> Function($$TransactionTableTableFilterComposer f) f) {
    final $$TransactionTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionTable,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionTableTableFilterComposer(
              $db: $db,
              $table: $db.transactionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryTableTable> {
  $$CategoryTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryName => $composableBuilder(
      column: $table.categoryName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconColor => $composableBuilder(
      column: $table.iconColor, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));
}

class $$CategoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryTableTable> {
  $$CategoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get categoryName => $composableBuilder(
      column: $table.categoryName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CategoryIcons, String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AppColors, String> get iconColor =>
      $composableBuilder(column: $table.iconColor, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> transactionTableRefs<T extends Object>(
      Expression<T> Function($$TransactionTableTableAnnotationComposer a) f) {
    final $$TransactionTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionTable,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionTableTableAnnotationComposer(
              $db: $db,
              $table: $db.transactionTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CategoryTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoryTableTable,
    Category,
    $$CategoryTableTableFilterComposer,
    $$CategoryTableTableOrderingComposer,
    $$CategoryTableTableAnnotationComposer,
    $$CategoryTableTableCreateCompanionBuilder,
    $$CategoryTableTableUpdateCompanionBuilder,
    (Category, $$CategoryTableTableReferences),
    Category,
    PrefetchHooks Function({bool transactionTableRefs})> {
  $$CategoryTableTableTableManager(_$AppDatabase db, $CategoryTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> categoryName = const Value.absent(),
            Value<CategoryIcons> icon = const Value.absent(),
            Value<AppColors> iconColor = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
          }) =>
              CategoryTableCompanion(
            id: id,
            categoryName: categoryName,
            icon: icon,
            iconColor: iconColor,
            sortOrder: sortOrder,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> categoryName = const Value.absent(),
            required CategoryIcons icon,
            required AppColors iconColor,
            required int sortOrder,
          }) =>
              CategoryTableCompanion.insert(
            id: id,
            categoryName: categoryName,
            icon: icon,
            iconColor: iconColor,
            sortOrder: sortOrder,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoryTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({transactionTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (transactionTableRefs) db.transactionTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (transactionTableRefs)
                    await $_getPrefetchedData<Category, $CategoryTableTable,
                            Transaction>(
                        currentTable: table,
                        referencedTable: $$CategoryTableTableReferences
                            ._transactionTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoryTableTableReferences(db, table, p0)
                                .transactionTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoryTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoryTableTable,
    Category,
    $$CategoryTableTableFilterComposer,
    $$CategoryTableTableOrderingComposer,
    $$CategoryTableTableAnnotationComposer,
    $$CategoryTableTableCreateCompanionBuilder,
    $$CategoryTableTableUpdateCompanionBuilder,
    (Category, $$CategoryTableTableReferences),
    Category,
    PrefetchHooks Function({bool transactionTableRefs})>;
typedef $$TransactionTableTableCreateCompanionBuilder
    = TransactionTableCompanion Function({
  Value<int> id,
  required int amount,
  required DateTime date,
  required String itemName,
  required int categoryId,
});
typedef $$TransactionTableTableUpdateCompanionBuilder
    = TransactionTableCompanion Function({
  Value<int> id,
  Value<int> amount,
  Value<DateTime> date,
  Value<String> itemName,
  Value<int> categoryId,
});

final class $$TransactionTableTableReferences
    extends BaseReferences<_$AppDatabase, $TransactionTableTable, Transaction> {
  $$TransactionTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CategoryTableTable _categoryIdTable(_$AppDatabase db) =>
      db.categoryTable.createAlias($_aliasNameGenerator(
          db.transactionTable.categoryId, db.categoryTable.id));

  $$CategoryTableTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoryTableTableTableManager($_db, $_db.categoryTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TransactionTableTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionTableTable> {
  $$TransactionTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get itemName => $composableBuilder(
      column: $table.itemName, builder: (column) => ColumnFilters(column));

  $$CategoryTableTableFilterComposer get categoryId {
    final $$CategoryTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoryTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableTableFilterComposer(
              $db: $db,
              $table: $db.categoryTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionTableTable> {
  $$TransactionTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get itemName => $composableBuilder(
      column: $table.itemName, builder: (column) => ColumnOrderings(column));

  $$CategoryTableTableOrderingComposer get categoryId {
    final $$CategoryTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoryTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableTableOrderingComposer(
              $db: $db,
              $table: $db.categoryTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionTableTable> {
  $$TransactionTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get itemName =>
      $composableBuilder(column: $table.itemName, builder: (column) => column);

  $$CategoryTableTableAnnotationComposer get categoryId {
    final $$CategoryTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoryTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoryTableTableAnnotationComposer(
              $db: $db,
              $table: $db.categoryTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionTableTable,
    Transaction,
    $$TransactionTableTableFilterComposer,
    $$TransactionTableTableOrderingComposer,
    $$TransactionTableTableAnnotationComposer,
    $$TransactionTableTableCreateCompanionBuilder,
    $$TransactionTableTableUpdateCompanionBuilder,
    (Transaction, $$TransactionTableTableReferences),
    Transaction,
    PrefetchHooks Function({bool categoryId})> {
  $$TransactionTableTableTableManager(
      _$AppDatabase db, $TransactionTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> itemName = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
          }) =>
              TransactionTableCompanion(
            id: id,
            amount: amount,
            date: date,
            itemName: itemName,
            categoryId: categoryId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int amount,
            required DateTime date,
            required String itemName,
            required int categoryId,
          }) =>
              TransactionTableCompanion.insert(
            id: id,
            amount: amount,
            date: date,
            itemName: itemName,
            categoryId: categoryId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TransactionTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$TransactionTableTableReferences._categoryIdTable(db),
                    referencedColumn: $$TransactionTableTableReferences
                        ._categoryIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TransactionTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionTableTable,
    Transaction,
    $$TransactionTableTableFilterComposer,
    $$TransactionTableTableOrderingComposer,
    $$TransactionTableTableAnnotationComposer,
    $$TransactionTableTableCreateCompanionBuilder,
    $$TransactionTableTableUpdateCompanionBuilder,
    (Transaction, $$TransactionTableTableReferences),
    Transaction,
    PrefetchHooks Function({bool categoryId})>;
typedef $$BudgetTableTableCreateCompanionBuilder = BudgetTableCompanion
    Function({
  Value<int> id,
  Value<int?> budgetAmount,
  Value<int?> spentAmount,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
});
typedef $$BudgetTableTableUpdateCompanionBuilder = BudgetTableCompanion
    Function({
  Value<int> id,
  Value<int?> budgetAmount,
  Value<int?> spentAmount,
  Value<DateTime?> startDate,
  Value<DateTime?> endDate,
});

class $$BudgetTableTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetTableTable> {
  $$BudgetTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get budgetAmount => $composableBuilder(
      column: $table.budgetAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get spentAmount => $composableBuilder(
      column: $table.spentAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));
}

class $$BudgetTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetTableTable> {
  $$BudgetTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get budgetAmount => $composableBuilder(
      column: $table.budgetAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get spentAmount => $composableBuilder(
      column: $table.spentAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));
}

class $$BudgetTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetTableTable> {
  $$BudgetTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get budgetAmount => $composableBuilder(
      column: $table.budgetAmount, builder: (column) => column);

  GeneratedColumn<int> get spentAmount => $composableBuilder(
      column: $table.spentAmount, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);
}

class $$BudgetTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BudgetTableTable,
    Budget,
    $$BudgetTableTableFilterComposer,
    $$BudgetTableTableOrderingComposer,
    $$BudgetTableTableAnnotationComposer,
    $$BudgetTableTableCreateCompanionBuilder,
    $$BudgetTableTableUpdateCompanionBuilder,
    (Budget, BaseReferences<_$AppDatabase, $BudgetTableTable, Budget>),
    Budget,
    PrefetchHooks Function()> {
  $$BudgetTableTableTableManager(_$AppDatabase db, $BudgetTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> budgetAmount = const Value.absent(),
            Value<int?> spentAmount = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
          }) =>
              BudgetTableCompanion(
            id: id,
            budgetAmount: budgetAmount,
            spentAmount: spentAmount,
            startDate: startDate,
            endDate: endDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> budgetAmount = const Value.absent(),
            Value<int?> spentAmount = const Value.absent(),
            Value<DateTime?> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
          }) =>
              BudgetTableCompanion.insert(
            id: id,
            budgetAmount: budgetAmount,
            spentAmount: spentAmount,
            startDate: startDate,
            endDate: endDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BudgetTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BudgetTableTable,
    Budget,
    $$BudgetTableTableFilterComposer,
    $$BudgetTableTableOrderingComposer,
    $$BudgetTableTableAnnotationComposer,
    $$BudgetTableTableCreateCompanionBuilder,
    $$BudgetTableTableUpdateCompanionBuilder,
    (Budget, BaseReferences<_$AppDatabase, $BudgetTableTable, Budget>),
    Budget,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CategoryTableTableTableManager get categoryTable =>
      $$CategoryTableTableTableManager(_db, _db.categoryTable);
  $$TransactionTableTableTableManager get transactionTable =>
      $$TransactionTableTableTableManager(_db, _db.transactionTable);
  $$BudgetTableTableTableManager get budgetTable =>
      $$BudgetTableTableTableManager(_db, _db.budgetTable);
}

mixin _$CategoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoryTableTable get categoryTable => attachedDatabase.categoryTable;
}
mixin _$TransactionDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoryTableTable get categoryTable => attachedDatabase.categoryTable;
  $TransactionTableTable get transactionTable =>
      attachedDatabase.transactionTable;
}
mixin _$BudgetDaoMixin on DatabaseAccessor<AppDatabase> {
  $BudgetTableTable get budgetTable => attachedDatabase.budgetTable;
}
