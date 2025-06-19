import 'package:drift/drift.dart';

@DataClassName('Budget')
class BudgetTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get categoryId => integer()();              // カテゴリID（必須）
  IntColumn get year => integer()();                    // 年（例：2024）
  IntColumn get month => integer()();                   // 月（1-12）
  IntColumn get budgetAmount => integer()();            // 予算金額（必須）
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();  // 作成日時
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();  // 更新日時

  // カテゴリID + 年 + 月の組み合わせをユニークにする
  @override
  List<Set<Column>> get uniqueKeys => [
    {categoryId, year, month}
  ];
}
