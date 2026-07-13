import 'package:flutter/material.dart';
import 'package:mytodo/app_colors.dart';
import 'package:mytodo/reusable_card.dart';
import 'task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});

  final Task task;
  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      thisColor: AppColors.primaryBackGroundColor,
      thisMargin: EdgeInsets.symmetric(horizontal: 19,vertical: 5),
      cardChild: Row(
        children: [
          Checkbox(
            value: task.isCompleted,
            onChanged: (value) {},
            activeColor: AppColors.progressIndicator,
            shape: CircleBorder(),
            side: BorderSide(
              color: AppColors.progressIndicator,
              width: 0.8,
            ),
          ),
          SizedBox(width: 8),
          Expanded(child: Text(task.title, style: TextStyle(color: Colors.grey.shade700,fontSize: 15),)),
          SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete_forever_rounded,
              size: 18,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
