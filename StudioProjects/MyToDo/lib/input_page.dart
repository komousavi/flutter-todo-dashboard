import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reusable_card.dart';
import 'taskcard_content.dart';
import 'category_tile.dart';
import 'category_data.dart';
import 'category.dart';
import 'category_chart.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  List<Category> get categories => CategoryData.all;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 30, top: 30, bottom: 30),
              child: Text(
                "Today's Tasks",
                style: GoogleFonts.playfairDisplay(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    thisColor: const Color(0xffffffff),
                    thisMargin: const EdgeInsets.only(
                      left: 20,
                      top: 5,
                      bottom: 5,
                      right: 5,
                    ),
                    cardChild: TaskCardContent(
                      taskCardNumberColor: const Color(0xff000000),
                      taskCardTitle: "Total",
                      taskCardNumber: "12",
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    thisColor: const Color(0xffffffff),
                    thisMargin: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                      bottom: 5,
                      right: 10,
                    ),
                    cardChild: TaskCardContent(
                      taskCardNumberColor: const Color(0xff469a77),
                      taskCardTitle: "Done",
                      taskCardNumber: "4",
                    ),
                  ),
                ),
                Expanded(
                  child: ReusableCard(
                    thisColor: const Color(0xffffffff),
                    thisMargin: const EdgeInsets.only(
                      left: 5,
                      top: 5,
                      bottom: 5,
                      right: 20,
                    ),
                    cardChild: TaskCardContent(
                      taskCardNumberColor: const Color(0xffff4500),
                      taskCardTitle: "Do",
                      taskCardNumber: "8",
                    ),
                  ),
                ),
              ],
            ),

            // Overall Completion Card
            ReusableCard(
              thisColor: const Color(0xffffffff),
              thisMargin: const EdgeInsets.all(20),
              cardChild: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        Text(
                          'Overall Completion',
                          style: TextStyle(color: Color(0xffe69057)),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          '33%',
                          style: GoogleFonts.playfairDisplay(
                            textStyle: const TextStyle(color: Color(0xffff4500),
                            fontSize: 35,)
                          )
                      ),
                      SizedBox(height: 10),
                      Text(
                          "4 of 12 tasks",
                        style: TextStyle(
                          color: Color(0xffef8c4d)
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: LinearProgressIndicator(
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(10),
                          value: 4 / 12,
                          backgroundColor: Color(0xffffebd5),
                          color: Color(0xffffa33d),
                        ),
                      ),
                       SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),

            ReusableCard(
              thisColor: const Color(0xffffffff),
              thisMargin: const EdgeInsets.all(20),
              cardChild: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('By Category'),
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
                    )
                  ],
                ),
              ),
            ),

            ReusableCard(
              thisColor: const Color(0xffffffff),
              thisMargin: const EdgeInsets.all(20),
            ),

            ReusableCard(
              thisColor: const Color(0xffffffff),
              thisMargin: const EdgeInsets.all(20),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
