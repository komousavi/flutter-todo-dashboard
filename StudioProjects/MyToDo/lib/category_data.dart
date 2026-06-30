import 'package:flutter/material.dart';
import 'category.dart';

class CategoryData{

   static final List<Category>_categories = [
     Category(name: "Work", color: Colors.orange, completedTasks: 4, icon: Icons.work_outline_rounded),
     Category(name: "Personal", color: Colors.yellow.shade200, completedTasks: 3, icon: Icons.person),
     Category(name: "Health", color: Colors.green.shade400, completedTasks: 2, icon: Icons.apple),
     Category(name: "Home", color: Colors.red.shade400, completedTasks: 3, icon: Icons.home)
   ];

   static List<Category> get all =>_categories;
}
