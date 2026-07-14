import 'package:flutter/material.dart';
import 'reusable_card.dart';
import 'taskcard_content.dart';
import 'category_tile.dart';
import 'category_data.dart';
import 'category.dart';
import 'category_chart.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'category_filter_chip.dart';
import 'task_data.dart';
import 'task_tile.dart';
import 'task.dart';
import 'package:intl/intl.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  DateTime selectedDate = DateTime.now();
  List<Category> get categories => CategoryData.all;
  String selectedCategory = "All";

  List<Task> get tasks => TaskData.all;
  static const int maxVisibleCategories = 5;
  List<Category> get visibleCategories =>
      categories.take(maxVisibleCategories).toList();
  List<Category> get hiddenCategories =>
      categories.skip(maxVisibleCategories).toList();

  Future<DateTime?> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2026),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.progressIndicator,
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColors.primaryBackGroundColor,
              headerBackgroundColor: AppColors.progressIndicator,
              headerForegroundColor: Colors.white,
              todayBackgroundColor: WidgetStateProperty.all(
                AppColors.progressIndicator,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    return pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            //Header
            Container(
              margin: EdgeInsetsGeometry.only(left: 28, top: 10),
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.progressIndicatorBackground,
                ),
                onPressed: () async {
                  final pickedDate = await _selectDate();
                  if (pickedDate != null) {
                    setState(() {
                      selectedDate = pickedDate;
                    });
                  }
                },
                label: Text(
                  DateFormat('EEEE, d MMMM').format(selectedDate),
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.progressIndicatorTitle,
                  ),
                ),
                icon: Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.progressIndicatorTitle,
                  size: 17,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 30, top: 5, bottom: 20),
              child: Text("Today's Tasks", style: AppTextStyles.mainTitle),
            ),
            Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    thisColor: AppColors.primaryBackGroundColor,
                    thisMargin: const EdgeInsets.only(
                      left: 20,
                      top: 5,
                      bottom: 5,
                      right: 5,
                    ),
                    cardChild: TaskCardContent(
                      taskCardNumberColor: AppColors.black,
                      taskCardTitle: "Total",
                      taskCardNumber: "12",
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    thisColor: AppColors.primaryBackGroundColor,
                    thisMargin: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                      bottom: 5,
                      right: 10,
                    ),
                    cardChild: TaskCardContent(
                      taskCardNumberColor: AppColors.green,
                      taskCardTitle: "Done",
                      taskCardNumber: "4",
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    thisColor: AppColors.primaryBackGroundColor,
                    thisMargin: const EdgeInsets.only(
                      left: 5,
                      top: 5,
                      bottom: 5,
                      right: 20,
                    ),
                    cardChild: TaskCardContent(
                      taskCardNumberColor: AppColors.orange,
                      taskCardTitle: "Do",
                      taskCardNumber: "8",
                    ),
                  ),
                ),
              ],
            ),

            // Overall Completion Card
            ReusableCard(
              thisColor: AppColors.primaryBackGroundColor,
              thisMargin: const EdgeInsets.all(20),
              cardChild: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Overall Completion',
                          style: AppTextStyles.cardsTitle,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('33%', style: AppTextStyles.completionPercent),
                      SizedBox(height: 10),
                      Text(
                        "4 of 12 tasks",
                        style: TextStyle(
                          color: AppColors.progressIndicatorTitle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: LinearProgressIndicator(
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(10),
                          value: 4 / 12,
                          backgroundColor:
                              AppColors.progressIndicatorBackground,
                          color: AppColors.progressIndicator,
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),

            ReusableCard(
              thisColor: AppColors.primaryBackGroundColor,
              thisMargin: const EdgeInsets.all(20),
              cardChild: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('By Category', style: AppTextStyles.cardsTitle),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CategoryChart(),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              ...categories.map((category) {
                                return CategoryTile(category: category);
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ReusableCard(
              thisColor: AppColors.primaryBackGroundColor,
              thisMargin: const EdgeInsets.all(20),
              cardChild: SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryFilterChip(
                      categoryName: 'All',
                      onTapAction: () {
                        setState(() {
                          selectedCategory = "All";
                        });
                      },
                      isSelected: selectedCategory == "All",
                    ),
                    ...visibleCategories.map(
                      (category) => CategoryFilterChip(
                        categoryName: category.name,
                        onTapAction: () {
                          setState(() {
                            selectedCategory = category.name;
                          });
                        },
                        isSelected: selectedCategory == category.name,
                      ),
                    ),
                    if (hiddenCategories.isNotEmpty)
                      CategoryFilterChip(
                        categoryName: "More",
                        onTapAction: () {},
                        isSelected: false,
                      ),
                  ],
                ),
              ),
            ),
            ReusableCard(
              thisColor: AppColors.primaryBackGroundColor,
              thisMargin: const EdgeInsets.all(20),
              cardChild: SizedBox(
                height: 45,
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {});
                  },
                  label: Text(
                    "Add Task",
                    style: TextStyle(
                      color: AppColors.primaryBackGroundColor,
                      fontSize: 17,
                    ),
                  ),
                  icon: Icon(
                    Icons.add,
                    size: 20,
                    color: AppColors.primaryBackGroundColor,
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.progressIndicator,
                    maximumSize: Size(double.infinity, double.infinity),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Column(children: [...tasks.map((task) => TaskTile(task: task))]),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
