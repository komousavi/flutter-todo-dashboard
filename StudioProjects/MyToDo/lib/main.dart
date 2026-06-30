import 'package:flutter/material.dart';
import 'input_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My ToDo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xfffff7ee)
      ),
      home: InputPage(),
    );
  }
}

