import 'package:flutter/material.dart';
import 'package:pulse/constants.dart';
import 'package:pulse/custom_widgets/custom_text_field.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Form(
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
                const CustomTextFormField(
                  hint: 'Age',
                  prefixIcon: Icon(Icons.calendar_month_outlined),
                ),
                smallSpace,
                const CustomTextFormField(
                  hint: 'Height',
                  prefixIcon: Icon(Icons.height_outlined),
                ),
                smallSpace,
                const CustomTextFormField(
                  hint: 'Weight',
                  prefixIcon: Icon(Icons.scale),
                ),
                smallSpace,
                const CustomTextFormField(
                  hint: 'BPMP',
                  prefixIcon: Icon(Icons.monitor_heart_outlined),
                ),
                smallSpace,
                const CustomTextFormField(
                  hint: 'O level',
                  prefixIcon: Icon(Icons.air_outlined),
                ),
                smallSpace,
                const CustomTextFormField(
                  hint: 'Temperature',
                  prefixIcon: Icon(Icons.thermostat_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
