import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/constants.dart';
import 'package:pulse/custom_widgets/custom_dropdown_button.dart';
import 'package:pulse/custom_widgets/custom_elevated_button.dart';
import 'package:pulse/screens/pending.dart';

import '../custom_widgets/custom_text_field.dart';
// import 'package:icons_plus/icons_plus.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool? _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColor,
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
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Form(
              child: Column(
                children: [
                  smallSpace,
                  const CustomTextFormField(
                    hint: 'Name',
                    prefixIcon: Icon(Icons.person_2_outlined),
                  ),
                  smallSpace,
                  const CustomDropDownButton(),
                  smallSpace,
                  const CustomTextFormField(
                    hint: 'Email',
                    prefixIcon: Icon(Icons.mail_outline_rounded),
                    textInputType: TextInputType.emailAddress,
                  ),
                  smallSpace,
                  const CustomTextFormField(
                    hint: 'Phone Number',
                    prefixIcon: Icon(BoxIcons.bx_phone),
                    textInputType: TextInputType.phone,
                  ),
                  smallSpace,
                  const CustomTextFormField(
                    hint: 'Username',
                    prefixIcon: Icon(Icons.person_add_alt_1_outlined),
                  ),
                  smallSpace,
                  const CustomTextFormField(
                    hint: 'Password',
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                  ),
                  smallSpace,
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        activeColor: primaryColor,
                        checkColor: secondaryColor,
                        side: const BorderSide(
                          color: primaryColor,
                          width: 2,
                        ),
                        onChanged: (bool? newVal) {
                          setState(
                            () {
                              _isChecked = newVal!;
                            },
                          );
                        },
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'I agree to the medical ',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms of Service',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                style: const TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                              const TextSpan(
                                text: ' and ',
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                style: const TextStyle(
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  smallSpace2x,
                  CustomElevatedButton(
                    value: 'Sign Up',
                    onPressedFunc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Pending(),
                        ),
                      );
                    },
                    isExpanded: true,
                    buttonElevation: 5,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
