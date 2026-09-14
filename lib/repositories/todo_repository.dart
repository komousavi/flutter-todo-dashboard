import '../database/app_database.dart';
import '../database/tasks.dart';
import '../database/categories.dart';

class TodoRepository {
  final AppDatabase db;

  TodoRepository(this.db);

  // Get all tasks
  Future<List<Task>> getAllTasks() {
    return db.tasksDao.getAllTasks();
  }

  // Get all categories
  Future<List<Category>> getAllCategories() {
    return db.categoriesDao.getAllCategories();
  }

  // Add a task
  Future<int> addTask(TasksCompanion task) {
    return db.tasksDao.addTask(task);
  }

  // Add a category
  Future<int> addCategory(CategoriesCompanion category) {
    return db.categoriesDao.addCategory(category);
  }

  // Update a task
  Future<bool> updateTask(Task task) {
    return db.tasksDao.updateTask(task);
  }

  // Delete a task
  Future<int> deleteTask(Task task) {
    return db.tasksDao.deleteTask(task);
  }

  // Update a category
  Future<bool> updateCategory(Category category) {
    return db.categoriesDao.updateCategory(category);
  }

  // Delete a category
  Future<int> deleteCategory(Category category) {
    return db.categoriesDao.deleteCategory(category);
  }

  // Get completed tasks
  Future<List<Task>> getCompletedTasks() {
    return db.tasksDao.getCompletedTasks();
  }

  // Get incomplete tasks
  Future<List<Task>> getIncompleteTasks() {
    return db.tasksDao.getIncompleteTasks();
  }

  // Get tasks by category
  Future<List<Task>> getTasksByCategory(int categoryId) {
    return db.tasksDao.getTasksByCategory(categoryId);
  }

  // Get tasks ordered by due date
  Future<List<Task>> getTasksByDueDate() {
    return db.tasksDao.getTasksByDueDate();
  }

  // Get tasks with their categories
  Future<List<(Task, Category)>> getTasksWithCategories() {
    return db.tasksDao.getTasksWithCategories();
  }

  // Get tasks with a specific category
  Future<List<(Task, Category)>> getTasksWithCategory(int categoryId) {
    return db.tasksDao.getTasksWithCategory(categoryId);
  }

  Future<bool> categoryNameExists(String name) {
    return db.categoriesDao.categoryNameExists(name);
  }

  Future<bool> categoryColorExists(int color) {
    return db.categoriesDao.categoryColorExists(color);
  }

  Future<bool> categoryIconExists(int iconCodePoint) {
    return db.categoriesDao.categoryIconExists(iconCodePoint);
  }
}
