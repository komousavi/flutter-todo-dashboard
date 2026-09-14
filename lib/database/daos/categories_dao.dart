import 'package:drift/drift.dart';
import '../app_database.dart';
import '../categories.dart';
part 'categories_dao.g.dart';

@DriftAccessor(tables: [Categories])
class CategoriesDao extends DatabaseAccessor<AppDatabase>
    with _$CategoriesDaoMixin {
  CategoriesDao(super.db);

  Future<List<Category>> getAllCategories() {
    return select(categories).get();
  }

  Future<int> addCategory(CategoriesCompanion category) {
    return into(categories).insert(category);
  }

  Future<bool> updateCategory(Category category) {
    return update(categories).replace(category);
  }

  Future<int> deleteCategory(Category category) {
    return delete(categories).delete(category);
  }

  Future<Category?> getCategoryById(int id) {
    return (select(
      categories,
    )..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  Future<bool> categoryNameExists(String name) async {
    final category = await (select(
      categories,
    )..where((c) => c.name.equals(name))).getSingleOrNull();

    return category != null;
  }

  Future<bool> categoryColorExists(int color) async {
    final category = await (select(
      categories,
    )..where((c) => c.color.equals(color))).getSingleOrNull();

    return category != null;
  }

  Future<bool> categoryIconExists(int iconCodePoint) async {
    final category = await (select(
      categories,
    )..where((c) => c.iconCodePoint.equals(iconCodePoint))).getSingleOrNull();

    return category != null;
  }
}
