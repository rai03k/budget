import 'package:drift/drift.dart';
import 'category_table.dart';

@DataClassName('Transaction')
class TransactionTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get amount => integer()();
  DateTimeColumn get date => dateTime()();
  TextColumn get itemName => text()();
  IntColumn get categoryId => integer().references(CategoryTable, #id)();
}
