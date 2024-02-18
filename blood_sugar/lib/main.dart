import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'input_screen.dart'; // Import the InputScreen widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Blood Sugar Monitor',
      home: InputScreen(),
    );
  }
}
