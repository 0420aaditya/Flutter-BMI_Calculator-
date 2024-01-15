import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
        colorScheme: ColorScheme.dark().copyWith(
          primary: Color(0xFF0A0E21),
          secondary: Colors.purpleAccent,
        ),
      ),
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double bmiResult = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('images/app_logo.jpg'),
            ),
            SizedBox(width: 8.0),
            Text('BMI Calculator',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
          ],
        ),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'bmiHero',
              child: Container(
                height: 200.0, // Adjust the height as needed
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'images/bmi_hero_image.png'), // Replace with your image asset
                    // fit: BoxFit
                    //     .cover, // Ensure the image covers the entire space
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Height (ft)',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Weight (kg)',
                        labelStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        calculateBMI();
                        showBMICategoryDialog();
                      },
                      icon: Icon(Icons.calculate),
                      label: Text('Calculate BMI'),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary,
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF1D1E33),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'BMI Result',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            bmiResult.toStringAsFixed(2),
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    double height = double.parse(heightController.text);
    height = height * 30.48;
    double weight = double.parse(weightController.text);

    setState(() {
      // BMI calculation formula: BMI = weight (kg) / (height (m) * height (m))
      bmiResult = weight / ((height / 100) * (height / 100));
    });
  }

  void showBMICategoryDialog() {
    String category;
    if (bmiResult < 16.0) {
      category = 'Very Severely Underweight';
    } else if (bmiResult >= 16.0 && bmiResult < 16.9) {
      category = 'Severely Underweight';
    } else if (bmiResult >= 17.0 && bmiResult < 18.4) {
      category = 'Underweight';
    } else if (bmiResult >= 18.5 && bmiResult < 24.9) {
      category = 'Normal (Healthy)';
    } else if (bmiResult >= 25.0 && bmiResult < 29.9) {
      category = 'Overweight';
    } else if (bmiResult >= 30.0 && bmiResult < 34.9) {
      category = 'Moderately Obese';
    } else if (bmiResult >= 35.0 && bmiResult < 39.9) {
      category = 'Severely Obese';
    } else {
      category = 'Very Severely Obese';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('BMI Category'),
          content: Text('Your BMI category is: $category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
