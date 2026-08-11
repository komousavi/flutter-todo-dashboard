import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'category_data.dart';

class CategoryChart extends StatelessWidget{
  const CategoryChart({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = CategoryData.all;
    
  return PieChart(
    PieChartData(
      sectionsSpace: 4,
      centerSpaceRadius: 40,
      sections: categories.map((category) {
        return PieChartSectionData(
          value: category.completedTasks.toDouble(),
          color: category.color,
          radius: 18,
          title: '',
        );
      }).toList(),
    )
  );
  }
  
  
}