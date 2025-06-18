import 'package:drift/drift.dart';

@DataClassName('Budget')
class BudgetTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get budgetAmount => integer().nullable()();
  IntColumn get spentAmount => integer().nullable()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
}
