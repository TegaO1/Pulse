import 'package:flutter/material.dart';
import 'package:pulse/constants.dart';
import 'package:pulse/custom_widgets/custom_elevated_button.dart';
import 'package:pulse/screens/login_page.dart';

import 'signup_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        backgroundColor: secondaryColor,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: (0.15 * screenHeight),
              child: const Image(
                image: AssetImage(
                  'assets/images/Pulse_Icon.png',
                ),
                color: primaryColor,
                fit: BoxFit.fitHeight,
              ),
            ),
            Text(
              'Pulse',
              style: TextStyle(
                fontSize: (0.054 * screenHeight),
                color: primaryColor,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: (0.04 * screenHeight),
            ),
            Text(
              'Let\'s get started!',
              style: TextStyle(
                fontSize: (0.035 * screenHeight),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: (0.01 * screenHeight)),
              child: Text(
                '...with health solutions right at your fingertips',
                style: TextStyle(
                  fontSize: (0.024 * screenHeight),
                  fontWeight: FontWeight.w400,
                  color: const Color.fromARGB(255, 95, 93, 93),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: (0.06 * screenHeight),
            ),
            CustomElevatedButton(
              value: 'Login',
              onPressedFunc: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              buttonElevation: 5,
            ),
            smallSpace,
            CustomElevatedButton(
              value: 'Sign Up',
              onPressedFunc: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpPage(),
                  ),
                );
              },
              buttonColor: Colors.white,
              buttonForegroungColor: primaryColor,
              sided: true,
            ),
          ],
        ),
      ),
    );
  }
}
