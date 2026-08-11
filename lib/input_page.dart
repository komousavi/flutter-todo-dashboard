import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
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
import 'package:dropdown_button2/dropdown_button2.dart';
import 'add_category_button.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  DateTime selectedDate = DateTime.now();
  List<Category> get categories => CategoryData.all;
  String selectedCategory = "All";
  String? selectedHiddenCategory;

  List<Task> get tasks => TaskData.all;
  static const int maxVisibleCategories = 5;
  List<Category> get visibleCategories =>
      categories.take(maxVisibleCategories).toList();
  List<Category> get hiddenCategories =>
      categories.skip(maxVisibleCategories).toList();

  final GlobalKey _moreButtonKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final _newCategoryFormKey = GlobalKey<FormState>();

  final TextEditingController taskController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController newCategoryNameController =
      TextEditingController();
  final TextEditingController newCategoryColorController =
      TextEditingController();

  Category? newTaskCategory;
  DateTime? newTaskDueDate;
  IconData? newCategoryIcon;
  Color? newCategoryColor;

  void resetNewCategoryForm() {
    newCategoryNameController.clear();
    newCategoryIcon = null;
    newCategoryColor = null;
  }

  Future<DateTime?> _selectDate({required DateTime firstDate}) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
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

  void _showAddCategoryDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.primaryBackGroundColor,
              insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              title: const Text(
                "New Category",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFF1842D),
                ),
              ),
              content: SingleChildScrollView(
                child: SafeArea(
                  child: Form(
                    key: _newCategoryFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Category Name",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF625B54),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: newCategoryNameController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter a category name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "e.g. Fitness",
                            hintStyle: TextStyle(color: Color(0xFFA89B8F)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Choose Icon",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF625B54),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        FormField<IconData>(
                          initialValue: newCategoryIcon,
                          validator: (value) {
                            if (value == null) {
                              return "Please select an icon";
                            }
                            final iconAlreadyExists = CategoryData.all.any(
                              (category) => category.icon == value,
                            );
                            if (iconAlreadyExists) {
                              return "This icon is already being used";
                            }
                            return null;
                          },
                          builder: (field) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  readOnly: true,
                                  onTap: () async {
                                    final icon = await showIconPicker(
                                      context,
                                      configuration: SinglePickerConfiguration(
                                        iconPackModes: [IconPack.material],
                                        iconPickerShape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            28,
                                          ),
                                        ),
                                        title: Text(
                                          "Pick an icon",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF625B54),
                                          ),
                                        ),
                                        backgroundColor:
                                            AppColors.primaryBackGroundColor,
                                        searchHintText: "Search icons",
                                        searchIcon: Icon(Icons.search_rounded),
                                        iconSize: 30,
                                        iconColor: Colors.grey.shade600,
                                        searchClearIcon: Icon(
                                          Icons.close_rounded,
                                        ),
                                        closeChild: Text(
                                          "Cancel",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF625B54),
                                          ),
                                        ),
                                      ),
                                    );
                                    if (icon != null) {
                                      setDialogState(() {
                                        newCategoryIcon = icon.data;
                                      });
                                      field.didChange(icon.data);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 14,
                                    ),
                                    hintText: newCategoryIcon == null
                                        ? "Select an Icon"
                                        : null,
                                    hintStyle: TextStyle(
                                      color: Color(0xFFA89B8F),
                                    ),
                                    prefixIcon: newCategoryIcon == null
                                        ? Icon(
                                            Icons.add_circle_outline_rounded,
                                            color: Colors.grey,
                                          )
                                        : Center(
                                            child: Icon(
                                              newCategoryIcon,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                          ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xFFE5D7C8),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Color(0xFFFFB35F),
                                        width: 2,
                                      ),
                                    ),
                                    errorText: field.errorText,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 14),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Pick Color",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF625B54),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        FormField<Color>(
                          initialValue: newCategoryColor,

                          validator: (value) {
                            if (value == null) {
                              return "Please select a color";
                            }

                            final colorAlreadyExists = CategoryData.all.any(
                              (category) => category.color == value,
                            );

                            if (colorAlreadyExists) {
                              return "This color is already being used";
                            }

                            return null;
                          },

                          builder: (field) {
                            return TextFormField(
                              readOnly: true,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    Color tempColor =
                                        newCategoryColor ?? Colors.white;

                                    return AlertDialog(
                                      backgroundColor:
                                          AppColors.primaryBackGroundColor,

                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(28),
                                      ),

                                      title: const Text(
                                        "Pick a Color",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFF1842D),
                                        ),
                                      ),

                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ColorPicker(
                                            paletteType: PaletteType.hueWheel,
                                            displayThumbColor: false,
                                            enableAlpha: false,
                                            labelTypes: [],
                                            hexInputBar: false,
                                            colorPickerWidth: 260,
                                            pickerColor: tempColor,

                                            onColorChanged: (color) {
                                              tempColor = color;
                                            },
                                          ),
                                        ],
                                      ),

                                      contentPadding: const EdgeInsets.fromLTRB(
                                        24,
                                        0,
                                        24,
                                        0,
                                      ),

                                      actionsPadding: const EdgeInsets.fromLTRB(
                                        24,
                                        0,
                                        24,
                                        16,
                                      ),

                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: Color(0xFFF1842D),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),

                                        TextButton(
                                          onPressed: () {
                                            setDialogState(() {
                                              newCategoryColor = tempColor;
                                            });

                                            field.didChange(tempColor);
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Select",
                                            style: TextStyle(
                                              color: Color(0xFFF1842D),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },

                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 14,
                                ),
                                filled: true,
                                fillColor: newCategoryColor ?? Colors.white,
                                hintText: newCategoryColor == null
                                    ? "Pick a Color"
                                    : null,
                                hintStyle: TextStyle(color: Color(0xFFA89B8F)),
                                prefixIcon: newCategoryColor == null
                                    ? Icon(
                                        Icons.colorize_rounded,
                                        color: Colors.grey,
                                      )
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Color(0xFFE5D7C8),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    //color: Color(0xFFFFB35F),
                                    width: 2,
                                  ),
                                ),
                                errorText: field.errorText,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    //resetNewCategoryForm();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Color(0xFFFD8F35)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!_newCategoryFormKey.currentState!.validate()) {
                      return;
                    }
                    if (newCategoryIcon == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select an icon")),
                      );
                      return;
                    }
                    if (newCategoryColor == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please select a color")),
                      );
                      return;
                    }
                    final categoryName = newCategoryNameController.text.trim();

                    final alreadyExists = CategoryData.all.any(
                      (category) =>
                          category.name.toLowerCase() ==
                          categoryName.toLowerCase(),
                    );

                    if (alreadyExists) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("This category already exists"),
                        ),
                      );
                      return;
                    }

                    final iconAlreadyExists = CategoryData.all.any(
                      (category) => category.icon == newCategoryIcon,
                    );

                    if (iconAlreadyExists) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("This icon is already being used"),
                        ),
                      );
                      return;
                    }
                    final colorAlreadyExists = CategoryData.all.any(
                      (category) => category.color == newCategoryColor,
                    );

                    if (colorAlreadyExists) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("This color is already being used"),
                        ),
                      );
                      return;
                    }
                    final newCategory = Category(
                      name: categoryName,
                      color: newCategoryColor!,
                      completedTasks: 0,
                      icon: newCategoryIcon!,
                    );
                    setState(() {
                      CategoryData.all.add(newCategory);
                    });
                    //resetNewCategoryForm();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFD8F35),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 2,
                  ),
                  child: const Text("Create"),
                ),
              ],
            );
          },
        );
      },
    );
    resetNewCategoryForm();
  }

  Widget _buildMoreDropdown() {
    return CategoryFilterChip(
      key: _moreButtonKey,
      categoryName: "More",
      onTapAction: () {},
      isSelected: selectedHiddenCategory != null,
    );
  }

  @override
  void dispose() {
    taskController.dispose();
    dueDateController.dispose();
    newCategoryNameController.dispose();

    super.dispose();
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
                  final pickedDate = await _selectDate(
                    firstDate: DateTime(2026),
                  );
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
            // category filter chip
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
                          selectedHiddenCategory = null;
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
                            selectedHiddenCategory = null;
                          });
                        },
                        isSelected: selectedCategory == category.name,
                      ),
                    ),
                    if (hiddenCategories.isNotEmpty) _buildMoreDropdown(),
                    AddCategoryButton(
                      onTap: () {
                        _showAddCategoryDialog();
                      },
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
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Color(0xFFFFFFFF),
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "New Task",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFF1842D),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          newTaskDueDate = null;
                                          newTaskCategory = null;
                                          taskController.clear();
                                          dueDateController.clear();
                                        },
                                        icon: Icon(Icons.close_rounded),
                                        style: IconButton.styleFrom(
                                          backgroundColor: Color(0xFFF4F3F3),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Task Title",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF625B54),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "Please enter a task";
                                      }
                                      return null;
                                    },
                                    controller: taskController,
                                    decoration: InputDecoration(
                                      hintText: "write your task",
                                      hintStyle: TextStyle(
                                        color: Color(0xFFA89B8F),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Color(0xFFFFB35F),
                                          width: 2,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.all(16),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Due Date (optional)",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF625B54),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  TextFormField(
                                    controller: dueDateController,
                                    readOnly: true,
                                    onTap: () async {
                                      final pickedDate = await _selectDate(
                                        firstDate: DateTime.now(),
                                      );
                                      if (pickedDate != null) {
                                        setState(() {
                                          newTaskDueDate = pickedDate;
                                          dueDateController.text = DateFormat(
                                            'MMM d EEEE, yyyy',
                                          ).format(newTaskDueDate!);
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Select due date",
                                      hintStyle: TextStyle(
                                        color: Color(0xFFA89B8F),
                                      ),
                                      prefixIcon: Icon(
                                        Icons.calendar_today_rounded,
                                        color: Colors.grey,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Color(0xFFE5D7C8),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Color(0xFFFFB35F),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Category",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF625B54),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  DropdownButtonFormField2<Category>(
                                    validator: (value) {
                                      if (value == null) {
                                        return "Please select a category";
                                      }
                                      return null;
                                    },
                                    value: newTaskCategory,
                                    items: categories
                                        .map(
                                          (category) =>
                                              DropdownMenuItem<Category>(
                                                value: category,
                                                child: Row(
                                                  children: [
                                                    Icon(category.icon),
                                                    SizedBox(width: 12),
                                                    Text(category.name),
                                                  ],
                                                ),
                                              ),
                                        )
                                        .toList(),
                                    onChanged: (Category? value) {
                                      setState(() {
                                        newTaskCategory = value;
                                      });
                                    },
                                    hint: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Select a category",
                                        style: TextStyle(
                                          color: Color(0xFFA89B8F),
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    isExpanded: true,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Color(0xFFFFB35F),
                                          width: 2,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Color(0xFFE5D7C8),
                                        ),
                                      ),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      elevation: 6,
                                    ),
                                    buttonStyleData: ButtonStyleData(
                                      padding: EdgeInsets.only(
                                        right: 8,
                                        left: 16,
                                      ),
                                    ),
                                    iconStyleData: IconStyleData(
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 28,
                                        color: Color(0xFF625B54),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  SafeArea(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            tasks.add(
                                              Task(
                                                title: taskController.text,
                                                category: newTaskCategory!,
                                                dueDate:
                                                    newTaskDueDate ??
                                                    DateTime.now(),
                                              ),
                                            );
                                            newTaskDueDate = null;
                                            newTaskCategory = null;
                                            taskController.clear();
                                            dueDateController.clear();
                                            Navigator.pop(context);
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFFD8F35),
                                        foregroundColor: Colors.white,
                                        minimumSize: Size(double.infinity, 50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        elevation: 2,
                                      ),
                                      child: const Text(
                                        "Add Task",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
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
            Column(
              children: [
                ...tasks.map(
                  (task) => TaskTile(
                    task: task,
                    onChanged: (bool? value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        task.isCompleted = value;
                        tasks.remove(task);
                        if (value) {
                          tasks.add(task);
                        } else {
                          int insertIndex = tasks.length;
                          for (int i = 0; i < tasks.length; i++) {
                            if (tasks[i].isCompleted) {
                              insertIndex = i;
                              break;
                            }
                          }
                          tasks.insert(insertIndex, task);
                        }
                      });
                    },
                    onDelete: () {
                      setState(() {
                        tasks.remove(task);
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
