import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/constants.dart';
import 'package:pulse/custom_widgets/custom_text_field.dart';
import 'package:pulse/screens/b4_home_page.dart';
// import 'package:pulse/screens/home_page.dart';
import 'package:pulse/screens/pending.dart';
import 'package:pulse/screens/signup_page.dart';

import '../custom_widgets/custom_elevated_button.dart';
// import 'home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColor,
        title: const Text(
          'Login',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 50,
          ),
          splashColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Form(
              child: Column(
                children: [
                  smallSpace,
                  const CustomTextFormField(
                    hint: 'Email',
                    prefixIcon: Icon(Icons.mail_outline_rounded),
                    textInputType: TextInputType.emailAddress,
                  ),
                  smallSpace,
                  const CustomTextFormField(
                    hint: 'Password',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  smallSpace,
                  const CustomElevatedButton(
                    value: 'Login',
                    nextPage: B4HomePage(),
                    buttonElevation: 5,
                    isExpanded: true,
                  ),
                  smallSpace,
                  Text.rich(
                    TextSpan(
                      text: 'Don\'t have an account? ',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: const TextStyle(
                            color: primaryColor,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                  smallSpace2x,
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: primaryColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  smallSpace2x,
                  CustomElevatedButton(
                    value: 'Google',
                    nextPage: const Pending(),
                    isExpanded: true,
                    buttonColor: secondaryColor,
                    buttonForegroungColor: primaryColor,
                    sided: true,
                    child: Row(
                      children: [
                        Brand(Brands.google),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Sign in with Google',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  smallSpace,
                  const CustomElevatedButton(
                    value: 'Apple',
                    nextPage: Pending(),
                    isExpanded: true,
                    buttonColor: secondaryColor,
                    buttonForegroungColor: primaryColor,
                    sided: true,
                    child: Row(
                      children: [
                        Icon(
                          Icons.apple_outlined,
                          size: 40,
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'Sign in with Apple',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  smallSpace,
                  CustomElevatedButton(
                    value: 'Facebook',
                    nextPage: const Pending(),
                    isExpanded: true,
                    buttonColor: secondaryColor,
                    buttonForegroungColor: primaryColor,
                    sided: true,
                    child: Row(
                      children: [
                        Brand(Brands.facebook),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Sign in with Facebook',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
