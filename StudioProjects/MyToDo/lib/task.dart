import 'package:flutter/material.dart';
import 'category.dart';

class Task {
  late final String title;
  late final bool isCompleted;
  late final Category category;

  Task({
    required this.title, required this.category, this.isCompleted = false,
});

}