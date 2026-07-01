import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';


class CategoryFilterChip extends StatelessWidget {
  const CategoryFilterChip({super.key, required this.categoryName, required this.onTapAction, required this.isSelected});

  final String categoryName;
  final bool isSelected;
  final VoidCallback onTapAction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapAction,
      borderRadius: BorderRadius.circular(13),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          decoration: BoxDecoration
            (
            borderRadius: BorderRadius.circular(6),
            color: isSelected? AppColors.progressIndicator : AppColors.primaryBackGroundColor,
          ),
          child: Text
            (
            categoryName,
            style: TextStyle(
              color: isSelected? AppColors.primaryBackGroundColor : AppColors.progressIndicatorTitle,
            ),
          ),
        ),
      ),
    );
  }

}