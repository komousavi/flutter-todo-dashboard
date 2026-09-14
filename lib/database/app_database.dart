import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'categories.dart';
import 'tasks.dart';
import 'daos/tasks_dao.dart';
import 'daos/categories_dao.dart';


part 'app_database.g.dart';


@DriftDatabase(
  tables: [Categories, Tasks],
  daos: [TasksDao, CategoriesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    return driftDatabase(
      name: 'mytodo',
    );
  });
}

void testDatabase() async {
  final db = AppDatabase();
  final categoryId = await db.categoriesDao.addCategory(
    CategoriesCompanion.insert(
      name: 'Work',
      color: 0xFF2196F3,
      iconCodePoint: 0xe8b6,
      iconFontFamily: 'MaterialIcons',
      iconFontPackage: const Value(null),
    ),
  );

  print('Category ID: $categoryId');

  final categories = await db.categoriesDao.getAllCategories();

  for (final category in categories) {
    print(category);
  }
  await db.close();
}

void main() {
  testDatabase();
}
