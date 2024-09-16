import 'package:flutter/material.dart';
import 'package:pulse/constants.dart';
import 'package:pulse/custom_widgets/custom_elevated_button.dart';
import 'package:pulse/custom_widgets/custom_text_field.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final _formKey = GlobalKey<FormState>(); // Add a form key for validation
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  bool isTested = false;
  double bmi = 0.0;
  String ageGrade = "";
  String healthStatus = "";

  Map<String, Map<String, double>> bmiScale = {
    "Children": {
      "Underweight": 0.005,
      "Healthy": 0.85,
      "Overweight": 0.95,
    },
    "Adult": {
      "Underweight": 18.5,
      "Healthy": 24.9,
      "Overweight": 29.9,
      "Obesity C1": 34.9,
      "Obesity C2": 39.9,
    },
    "Older Adult": {
      "Underweight": 18.5,
      "Healthy": 24.9,
      "Overweight": 29.9,
    },
  };

  void calculateBMI(double weight, double height) {
    // Calculate BMI using the formula: BMI = weight (kg) / height (m)^2
    setState(() {
      bmi = weight / (height * height);
      determineAgeGrade(int.parse(ageController.text));
      checkHealthStatus();
      isTested = true;
    });
  }

  void determineAgeGrade(int age) {
    if (age >= 2 && age <= 19) {
      ageGrade = "Children";
    } else if (age >= 20 && age <= 64) {
      ageGrade = "Adult";
    } else if (age >= 65) {
      ageGrade = "Older Adult";
    } else {
      ageGrade = "Unknown";
    }
  }

  void checkHealthStatus() {
    if (ageGrade == "Children") {
      if (bmi < bmiScale[ageGrade]!["Underweight"]!) {
        healthStatus = "Underweight";
      } else if (bmi < bmiScale[ageGrade]!["Healthy"]!) {
        healthStatus = "Healthy";
      } else if (bmi < bmiScale[ageGrade]!["Overweight"]!) {
        healthStatus = "Overweight";
      } else {
        healthStatus = "Obese";
      }
    } else if (ageGrade == "Adult" || ageGrade == "Older Adult") {
      if (bmi < bmiScale[ageGrade]!["Underweight"]!) {
        healthStatus = "Underweight";
      } else if (bmi <= bmiScale[ageGrade]!["Healthy"]!) {
        healthStatus = "Healthy";
      } else if (bmi <= bmiScale[ageGrade]!["Overweight"]!) {
        healthStatus = "Overweight";
      } else if (ageGrade == "Adult" &&
          bmi <= bmiScale[ageGrade]!["Obesity C1"]!) {
        healthStatus = "Obesity C1";
      } else if (ageGrade == "Adult" &&
          bmi <= bmiScale[ageGrade]!["Obesity C2"]!) {
        healthStatus = "Obesity C2";
      } else {
        healthStatus = "Severe Obesity";
      }
    } else {
      healthStatus = "Unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              children: [
                Text(
                  'Test Form',
                  style: TextStyle(
                    fontSize: 0.03 * screenHeight,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                smallSpace2x,
                CustomTextFormField(
                  hint: 'Age',
                  prefixIcon: const Icon(Icons.calendar_month_outlined),
                  controller: ageController,
                  textInputType: TextInputType.number,
                  textFormValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    final age = int.tryParse(value);
                    if (age == null || age < 2 || age > 120) {
                      return 'Please enter a valid age between 2 and 120';
                    }
                    return null;
                  },
                ),
                smallSpace,
                CustomTextFormField(
                  hint: 'Height (m)',
                  prefixIcon: const Icon(Icons.height_outlined),
                  controller: heightController,
                  textInputType: TextInputType.number,
                  textFormValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height';
                    }
                    final height = double.tryParse(value);
                    if (height == null || height <= 0 || height > 2.5) {
                      return 'Please enter a valid height in meters (e.g., 1.75)';
                    }
                    return null;
                  },
                ),
                smallSpace,
                CustomTextFormField(
                  hint: 'Weight (kg)',
                  prefixIcon: const Icon(Icons.scale),
                  controller: weightController,
                  textInputType: TextInputType.number,
                  textFormValidator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    final weight = double.tryParse(value);
                    if (weight == null || weight <= 0 || weight > 300) {
                      return 'Please enter a valid weight in kilograms (e.g., 70)';
                    }
                    return null;
                  },
                ),
                smallSpace2x,
                CustomElevatedButton(
                  value: "Test",
                  onPressedFunc: () {
                    if (_formKey.currentState!.validate()) {
                      calculateBMI(
                        double.parse(weightController.text),
                        double.parse(heightController.text),
                      );
                    }
                  },
                  isExpanded: true,
                ),
                smallSpace2x,
                Text(
                  'Test Result',
                  style: TextStyle(
                    fontSize: 0.03 * screenHeight,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isTested)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: double.infinity),
                        Text(
                          'BMI: ${bmi.toStringAsFixed(4)}',
                          style: TextStyle(
                            fontSize: 0.024 * screenHeight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Age Grade: $ageGrade',
                          style: TextStyle(
                            fontSize: 0.024 * screenHeight,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Health Status: $healthStatus',
                          style: TextStyle(
                            fontSize: 0.024 * screenHeight,
                            fontWeight: FontWeight.w600,
                            color: healthStatus == "Healthy"
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!isTested)
                  Text(
                    "...waiting for test result",
                    style: TextStyle(
                      fontSize: 0.024 * screenHeight,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
