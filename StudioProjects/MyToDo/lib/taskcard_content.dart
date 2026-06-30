import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_text_styles.dart';


class TaskCardContent extends StatelessWidget {
  const TaskCardContent({super.key,required this.taskCardNumberColor, required this.taskCardTitle, required this.taskCardNumber});

  final Color taskCardNumberColor;
  final String taskCardTitle;
  final String taskCardNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          taskCardTitle,
          style: AppTextStyles.cardsTitle,
        ),
        SizedBox(height: 10),
        Text(
            taskCardNumber,
            style: GoogleFonts.playfairDisplay(
              textStyle: TextStyle(color: taskCardNumberColor),
              fontSize: 45,)
        )
      ],
    );
  }
}
