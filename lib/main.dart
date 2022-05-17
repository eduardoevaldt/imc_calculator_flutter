// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, duplicate_ignore, avoid_print, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:imc_calculator/widgets/widget_info_button.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BmiCalculator(),
    );
  }
}

class BmiCalculator extends StatefulWidget {
  BmiCalculator({Key? key}) : super(key: key);

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  int currentindex = 0;
  double result = 0;
  double height = 0;
  double weight = 0;

  TextEditingController heightController = TextEditingController(text: "175");
  TextEditingController weightController = TextEditingController(text: "80");

  var bmiStats = "-";

  void onCalculateAgain() {
    setState(() {
      result = 0;
      bmiStats = "-";

      weightController.text = "80";
      heightController.text = "175";
    });
  }

  void onCalculateBmi() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);

      result = weight / math.pow(height / 100, 2);

      if (result < 18.5) {
        bmiStats = "Underweight";
      } else if (result < 25) {
        bmiStats = "Normal";
      } else if (result < 30) {
        bmiStats = "Overweight";
      } else {
        bmiStats = "Obesity";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          InfoButtonWidget(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  radioButton(
                    Image.asset('assets/images/man.png'),
                    Color.fromARGB(255, 62, 168, 255),
                    0,
                  ),
                  radioButton(
                    Image.asset('assets/images/woman.png'),
                    Color.fromARGB(255, 253, 122, 166),
                    1,
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Your weight "),
                            Text(
                              "(kg)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: TextField(
                            style: const TextStyle(fontSize: 30),
                            keyboardType: TextInputType.number,
                            controller: weightController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              filled: true,
                              fillColor: Colors.grey[150],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Your height "),
                            Text(
                              "(cm)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: TextField(
                            style: const TextStyle(fontSize: 30),
                            keyboardType: TextInputType.number,
                            controller: heightController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                              filled: true,
                              fillColor: Colors.grey[150],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Center(
                  child: SizedBox(
                    width: 290,
                    child: ElevatedButton(
                      onPressed: () {
                        onCalculateBmi();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(22),
                      ),
                      child: const Text(
                        "Calculate your BMI",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  "Your BMI is :",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Center(
                child: Text(
                  result.toStringAsFixed(1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: Text(
                  bmiStats.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: onCalculateAgain,
                  child: const Text(
                    "Calculate BMI again",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      currentindex = index;
    });
  }

  Widget radioButton(Image value, Color color, int index) {
    return Expanded(
      // ignore: deprecated_member_use
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: MaterialButton(
          color: currentindex == index ? color : Colors.grey[10],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          onPressed: () {
            changeIndex(index);
          },
          child: (value),
        ),
      ),
    );
  }
}
