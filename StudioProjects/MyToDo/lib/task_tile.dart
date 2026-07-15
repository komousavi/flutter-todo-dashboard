import 'package:flutter/material.dart';
import 'package:mytodo/app_colors.dart';
import 'package:mytodo/reusable_card.dart';
import 'task.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onChanged,
    required this.onDelete,
  });

  final Task task;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      thisColor: AppColors.primaryBackGroundColor,
      thisMargin: EdgeInsets.symmetric(horizontal: 19, vertical: 5),
      cardChild: Row(
        children: [
          Checkbox(
            value: task.isCompleted,
            onChanged: onChanged,
            activeColor: AppColors.progressIndicator,
            shape: CircleBorder(),
            side: BorderSide(color: AppColors.progressIndicator, width: 0.8),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              task.title,
              style: TextStyle(
                color: task.isCompleted
                    ? Colors.grey.shade400
                    : Colors.grey.shade700,
                fontSize: 15,
                decoration: task.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: onDelete,
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
