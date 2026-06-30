import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


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
          style: TextStyle(color: Color(0xffe69057), fontSize: 17),
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
