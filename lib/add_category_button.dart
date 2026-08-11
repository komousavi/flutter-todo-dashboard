import 'package:flutter/material.dart';

class AddCategoryButton extends StatelessWidget {
  final VoidCallback onTap;

  const AddCategoryButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFFFFB35F),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add_rounded,
              size: 20,
              color: Color(0xFFFF9F3D),
            ),
            SizedBox(width: 5),
            Text(
              "Add Category",
              style: TextStyle(
                color: Color(0xFFFF9F3D),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}