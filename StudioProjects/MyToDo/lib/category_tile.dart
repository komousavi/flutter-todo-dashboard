import 'package:flutter/material.dart';
import 'category.dart';
import 'app_colors.dart';

class CategoryTile extends StatelessWidget{
  final Category category;
  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.all(8.0),
     child: Row(
       children: [
         Icon(
           category.icon,
           color: category.color,
           size: 20,
         ),
         SizedBox(width: 20),
         Text(
             category.name,
         ),
         Spacer(),
         Text(
           category.completedTasks.round().toString(),
           style: TextStyle(
             color: AppColors.progressIndicatorTitle,
             fontWeight: FontWeight.bold,
           ),
         ),
       ],
     ),
   );
  }
}