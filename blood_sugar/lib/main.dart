import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

enum DiabetesType {
  type1,
  type2,
  gestational,
  elderly,
  child,
  none,
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


class InformationScreen extends StatelessWidget {
  final String beforeMealValue;
  final String afterMealValue;
  final DiabetesType diabetesType;

  InformationScreen({
    required this.beforeMealValue,
    required this.afterMealValue,
    required this.diabetesType,

  });


  String categorizeBloodSugar({
    required double beforeMeal,
    required double afterMeal,
    required DiabetesType diabetesType,
  }) {
    // Handle normal cases for each diabetes type
    switch (diabetesType) {
      case DiabetesType.type1:
      case DiabetesType.type2:
      // Both type 1 and type 2 adults have the same ranges for normal
        if (beforeMeal >= 80 && beforeMeal <= 130 && afterMeal < 180) {
          return "Normal for Adults with Type ${diabetesType == DiabetesType.type1 ? '1' : '2'} Diabetes";
        }
        break;
      case DiabetesType.child:
        if (beforeMeal >= 90 && beforeMeal <= 130 && afterMeal >= 90 && afterMeal <= 150) {
          return "Normal for Children with Type 1 Diabetes";
        }
        break;
      case DiabetesType.gestational:
        if (beforeMeal < 95 && ((afterMeal <= 140 && afterMeal > 120) || afterMeal <= 120)) {
          return "Normal for Pregnant People";
        }
        break;
      case DiabetesType.elderly:
        if (beforeMeal >= 80 && beforeMeal <= 180 && afterMeal <= 200) {
          return "Normal for Elderly (65 or older)";
        }
        break;
      case DiabetesType.none:
        if (beforeMeal <= 99 && afterMeal <= 140) {
          return "Normal for People without Diabetes";
        }
        break;
    }

    // Handle out-of-range cases
    return "Out of Normal Range";
  }


  @override
  Widget build(BuildContext context) {
    // Convert input strings to doubles
    double? beforeMeal = double.tryParse(beforeMealValue);
    double? afterMeal = double.tryParse(afterMealValue);
    String categoryInfo = "Invalid Data";

    // Ensure both conversions are successful
    if (beforeMeal != null && afterMeal != null) {
      categoryInfo = categorizeBloodSugar(
        beforeMeal: beforeMeal,
        afterMeal: afterMeal,
        diabetesType: diabetesType,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Sugar Information'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Before Meal: $beforeMealValue mg/dL',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
              ),
              SizedBox(height: 8.0),
              Text(
                'After Meal: $afterMealValue mg/dL',
                style: Theme
                    .of(context)
                    .textTheme
                    .headline6,
              ),
              SizedBox(height: 16.0),
              Text(
                'Category: $categoryInfo', // Corrected line
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}