import 'task.dart';
import 'category_data.dart';

class TaskData {
  static final List<Task> all = [
    Task(
      title: "Finalize Q4 budget report",
      category: CategoryData.byName("Work"),
      isCompleted: false,
      dueDate: DateTime.now(),
    ),

    Task(
      title: "Schedule team retrospective",
      category: CategoryData.byName("Work"),
      isCompleted: false,
      dueDate: DateTime.now(),
    ),

    Task(
      title: "Go to the gym",
      category: CategoryData.byName("Health"),
      isCompleted: false,
      dueDate: DateTime.now(),
    ),

    Task(
      title: "Buy groceries",
      category: CategoryData.byName("Home"),
      isCompleted: false,
      dueDate: DateTime.now(),
    ),

    Task(
      title: "Call mom",
      category: CategoryData.byName("Personal"),
      isCompleted: false,
      dueDate: DateTime.now(),
    ),
  ];
}
