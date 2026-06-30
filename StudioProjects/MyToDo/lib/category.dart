import 'package:flutter/material.dart';

class Category {
  late String name;
  late Color color;
  late double completedTasks;
  late int total;
  late IconData icon;

Category ({required this.name, required this.color, required this.completedTasks, required this.icon});

  double get progress => completedTasks / total;
}



