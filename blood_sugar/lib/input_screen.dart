import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'diabetes_types.dart';
import 'information_screen.dart'; // Import the InformationScreen widget

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController beforeMealController = TextEditingController();
  final TextEditingController afterMealController = TextEditingController();
  DiabetesType selectedDiabetesType = DiabetesType.none;

  void navigateToInfoScreen(BuildContext context) {
    Get.to(() => InformationScreen(
      beforeMealValue: beforeMealController.text,
      afterMealValue: afterMealController.text,
      diabetesType: selectedDiabetesType,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Blood Sugar Levels'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<DiabetesType>(
              value: selectedDiabetesType,
              onChanged: (DiabetesType? newValue) {
                setState(() {
                  selectedDiabetesType = newValue!;
                });
              },
              items: DiabetesType.values.map((DiabetesType type) {
                return DropdownMenuItem<DiabetesType>(
                  value: type,
                  child: Text(type.toString().split('.').last),
                );
              }).toList(),
            ),
            TextField(
              controller: beforeMealController,
              decoration: InputDecoration(labelText: 'Before Meal'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: afterMealController,
              decoration: InputDecoration(labelText: 'After Meal'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () => navigateToInfoScreen(context),
              child: Text('Show info'),
            ),
          ],
        ),
      ),
    );
  }
}
