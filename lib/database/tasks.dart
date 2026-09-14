import 'package:drift/drift.dart';
import 'categories.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  DateTimeColumn get createdDate => dateTime()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(Constant(false))();
  IntColumn get categoryId =>
      integer().references(Categories, #id)();
}
