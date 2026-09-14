import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tasks.dart';
import '../categories.dart';

part 'tasks_dao.g.dart';

@DriftAccessor(tables: [Tasks, Categories])
class TasksDao extends DatabaseAccessor<AppDatabase> with _$TasksDaoMixin {
  TasksDao(AppDatabase db) : super(db);

  Future<List<Task>> getAllTasks() {
    return select(tasks).get();
  }

  Future<List<Task>> getCompletedTasks() {
    return (select(tasks)..where((t) => t.isCompleted.equals(true))).get();
  }

  Future<List<Task>> getIncompleteTasks() {
    return (select(tasks)..where((t) => t.isCompleted.equals(false))).get();
  }

  Future<List<Task>> getTasksByCategory(int categoryId) {
    return (select(tasks)..where((t) => t.categoryId.equals(categoryId))).get();
  }

  Future<List<Task>> getTasksByDueDate() {
    return (select(tasks)..orderBy([
          (t) => OrderingTerm(expression: t.dueDate, nulls: NullsOrder.last),
        ]))
        .get();
  }

  Future<int> addTask(TasksCompanion task) {
    return into(tasks).insert(task);
  }

  Future<bool> updateTask(Task task) {
    return update(tasks).replace(task);
  }

  Future<int> deleteTask(Task task) {
    return delete(tasks).delete(task);
  }

  Future<Task?> getTaskById(int id) {
    return (select(tasks)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<(Task, Category)>> getTasksWithCategories() async {
    final results = await (select(tasks).join([
      innerJoin(categories, categories.id.equalsExp(tasks.categoryId)),
    ])).get();

    return results.map((result) {
      return (result.readTable(tasks), result.readTable(categories));
    }).toList();
  }

  Future<List<(Task, Category)>> getTasksWithCategory(int categoryId) async {
    final results = await (select(tasks).join([
      innerJoin(categories, categories.id.equalsExp(tasks.categoryId)),
    ])..where(categories.id.equals(categoryId))).get();

    return results.map((result) {
      return (result.readTable(tasks), result.readTable(categories));
    }).toList();
  }
}
