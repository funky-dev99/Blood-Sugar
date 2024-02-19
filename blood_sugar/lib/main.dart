import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diabetes Category Info',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputScreen(),
    );
  }
}

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  String _selectedAge = 'children';
  TextEditingController _beforeMealController = TextEditingController();
  TextEditingController _afterMealController = TextEditingController();

  void validateData() {
    int beforeMeal = int.tryParse(_beforeMealController.text) ?? -1;
    int afterMeal = int.tryParse(_afterMealController.text) ?? -1;

    if (beforeMeal == -1 || afterMeal == -1) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Data'),
          content: Text('Please enter valid blood glucose values.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      String diagnosis = '';

      if (_selectedAge == 'children') {
        if (beforeMeal >= 90 &&
            beforeMeal <= 130 &&
            afterMeal >= 90 &&
            afterMeal <= 150) {
          diagnosis = 'Normal';
        } else {
          diagnosis = 'Diabetes';
        }
      } else if (_selectedAge == 'pregnant') {
        if (beforeMeal < 95 && afterMeal == 140 && afterMeal == 120) {
          diagnosis = 'Normal';
        } else {
          diagnosis = 'Diabetes';
        }
      } else if (_selectedAge == '65High') {
        if (beforeMeal >= 80 &&
            beforeMeal <= 180 &&
            afterMeal >= 80 &&
            afterMeal <= 200) {
          diagnosis = 'Normal';
        } else {
          diagnosis = 'Diabetes';
        }
      } else if (_selectedAge == '65Low') {
        if (beforeMeal >= 80 &&
            beforeMeal <= 180 &&
            afterMeal >= 80 &&
            afterMeal <= 200) {
          diagnosis = 'Normal';
        } else {
          diagnosis = 'Diabetes';
        }
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InfoScreen(
            selectedAge: _selectedAge,
            beforeMeal: beforeMeal,
            afterMeal: afterMeal,
            diagnosis: diagnosis,
            categoryInfo: '',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: Center(
            child: Text(
          'Enter Blood Glucose Data',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(
                'images/image01.png',
                width: 200,
              )),
              SizedBox(height: 20),
              Text('Before Meal (mg/dL):'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: TextField(
                  controller: _beforeMealController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 16.0, // Example: Change the font size
                    color: Colors.teal, // Example: Change the text color
                    fontWeight: FontWeight.bold, // Example: Make the text bold
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // Border style when TextField is enabled
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // Border style when TextField is focused
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('After Meal (mg/dL):'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: TextField(
                  controller: _afterMealController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    fontSize: 16.0, // Example: Change the font size
                    color: Colors.teal, // Example: Change the text color
                    fontWeight: FontWeight.bold, // Example: Make the text bold
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      // Border style when TextField is enabled
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      // Border style when TextField is focused
                      borderSide: BorderSide(color: Colors.teal, width: 2.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Select Age:'),
              DropdownButton<String>(
                value: _selectedAge,
                onChanged: (value) {
                  setState(() {
                    _selectedAge = value!;
                  });
                },
                items: <String>[
                  'children',
                  'pregnant',
                  '65 High',
                  '65 Low',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: validateData,
                    child: const Text(
                      'Show Info',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoScreen extends StatelessWidget {
  final String selectedAge;
  final int beforeMeal;
  final int afterMeal;
  final String diagnosis;

  InfoScreen({
    required this.selectedAge,
    required this.beforeMeal,
    required this.afterMeal,
    required this.diagnosis,
    required String categoryInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          'Blood Glucose Information',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true, // Center the title
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InputScreen()),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              'images/image02.png',
              width: 200,
            )),
            SizedBox(height: 20),
            Text(
              'Selected Age: $selectedAge',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text('Before Meal (mg/dL): $beforeMeal',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text('After Meal (mg/dL): $afterMeal',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.teal,
                  width: 1
                )
              ),
                child: Text('Diagnosis: $diagnosis',
                    style: TextStyle(fontSize: 20))),
          ],
        ),
      ),
    );
  }
}
