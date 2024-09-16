import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/constants.dart';
import 'package:pulse/custom_widgets/custom_dropdown_button.dart';
import 'package:pulse/custom_widgets/custom_elevated_button.dart';
import 'package:pulse/screens/pending.dart';

import '../custom_widgets/custom_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>(); // Add a global key for the form
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
              key: _formKey, // Assign the form key
              child: Column(
                children: [
                  smallSpace,
                  CustomTextFormField(
                    hint: 'Name',
                    prefixIcon: const Icon(Icons.person_2_outlined),
                    controller: nameController,
                    textFormValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  smallSpace,
                  const CustomDropDownButton(),
                  smallSpace,
                  CustomTextFormField(
                    hint: 'Email',
                    prefixIcon: const Icon(Icons.mail_outline_rounded),
                    textInputType: TextInputType.emailAddress,
                    controller: emailController,
                    textFormValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegex =
                          RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  smallSpace,
                  CustomTextFormField(
                    hint: 'Phone Number',
                    prefixIcon: const Icon(BoxIcons.bx_phone),
                    textInputType: TextInputType.phone,
                    controller: phoneController,
                    textFormValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      final phoneRegex = RegExp(r'^\+?[\d\s]{7,15}$');
                      if (!phoneRegex.hasMatch(value)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  smallSpace,
                  CustomTextFormField(
                    hint: 'Username',
                    prefixIcon: const Icon(Icons.person_add_alt_1_outlined),
                    controller: usernameController,
                    textFormValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a username';
                      }
                      if (value.length < 3) {
                        return 'Username must be at least 3 characters long';
                      }
                      return null;
                    },
                  ),
                  smallSpace,
                  CustomTextFormField(
                    hint: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    controller: passwordController,
                    textFormValidator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
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
                      if (_formKey.currentState?.validate() ?? false) {
                        if (!_isChecked!) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Please agree to the Terms of Service'),
                            ),
                          );
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Pending(),
                          ),
                        );
                      }
                    },
                    isExpanded: true,
                    buttonElevation: 5,
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
