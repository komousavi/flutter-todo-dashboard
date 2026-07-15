import 'category.dart';

class Task {
  late final String title;
  late bool isCompleted;
  late final Category category;

  Task({
    required this.title, required this.category, this.isCompleted = false,
});

}