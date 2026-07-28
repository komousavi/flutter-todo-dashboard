import 'category.dart';

class Task {
  final String title;
  bool isCompleted;
  final Category category;
  final DateTime dueDate;

  Task({
    required this.title, required this.category, this.isCompleted = false, required this.dueDate
});

}