import 'package:flutter/material.dart';


class ReusableCard extends StatelessWidget {
  const ReusableCard({super.key, required this.thisColor,required this.thisMargin, this.cardChild});

 final Color thisColor;
 final EdgeInsets thisMargin;
 final Widget? cardChild;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: thisMargin,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          spreadRadius: 0,
          blurRadius: 3,
          offset: Offset(0, 1)
        ),
        BoxShadow(
          blurRadius: 2,
          spreadRadius: -1.0,
          color: Colors.black.withValues(alpha: 0.1),
          offset: Offset(0, 1)
        )],
        borderRadius: BorderRadius.circular(10),
        color: thisColor,
      ),
      child: cardChild,
    );
  }
}
// 0 1px 2px -1px rgb(0 0 0 / 0.1))