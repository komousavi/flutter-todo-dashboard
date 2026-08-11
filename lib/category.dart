import 'package:flutter/material.dart';

class Category {
  late String name;
  late Color color;
  late double completedTasks;
  late int total;
  late IconData icon;

  Category({
    required this.name,
    required this.color,
    required this.completedTasks,
    required this.icon,
    this.total = 0,
  });

  double get progress => total == 0 ? 0 : completedTasks / total;
}
