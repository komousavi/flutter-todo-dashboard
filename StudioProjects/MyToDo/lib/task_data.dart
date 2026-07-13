import 'task.dart';
import 'category_data.dart';

class TaskData {
  static final List<Task> all = [
    Task(
      title: "Finalize Q4 budget report",
      category: CategoryData.byName("Work"),
      isCompleted: false,
    ),

    Task(
      title: "Schedule team retrospective",
      category: CategoryData.byName("Work"),
      isCompleted: true,
    ),

    Task(
      title: "Go to the gym",
      category: CategoryData.byName("Health"),
      isCompleted: false,
    ),

    Task(
      title: "Buy groceries",
      category: CategoryData.byName("Home"),
      isCompleted: false,
    ),

    Task(
      title: "Call mom",
      category: CategoryData.byName("Personal"),
      isCompleted: true,
    ),
  ];
}