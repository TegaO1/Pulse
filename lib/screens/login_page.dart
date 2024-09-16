import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/constants.dart';
import 'package:pulse/custom_widgets/custom_text_field.dart';
import 'package:pulse/screens/b4_home_page.dart';
import 'package:pulse/screens/pending.dart';
import 'package:pulse/screens/signup_page.dart';
import '../custom_widgets/custom_elevated_button.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:crypto/crypto.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

  /// Function to load and parse the JSON file containing user data
  Future<List<Map<String, String>>> _loadUserData() async {
    final String response = await rootBundle.loadString('assets/users.json');
    final data = json.decode(response) as Map<String, dynamic>;

    // Safely parse the list of users ensuring each user is a Map<String, String>
    List<Map<String, String>> users = (data['users'] as List)
        .map((user) => {
              'email': user['email'].toString(),
              'password': user['password'].toString(),
              'id': user['id'].toString(),
              'user_name': user['user_name'].toString(),
              'full_name': user['Ella Joy'].toString(),
              'gender': user['gender'].toString(),
              'phone_number': user['phone_number'].toString(),
            })
        .toList();
    return users;
  }

  /// Function to authenticate the user based on email and password
  Future<void> _authenticateUser() async {
    final String email = emailController.text.trim();
    // final String password = passwordController.text;

    // Load user data from JSON
    final List<Map<String, String>> users = await _loadUserData();

    // Check if the entered credentials match any user in the JSON file
    final isAuthenticated = users.any(
      (user) =>
          user['email'] == email && user['password'] == _convertToSha256(),
    );
    String userID = '';

    for (var user in users) {
      if (isAuthenticated && user['email'] == email) {
        userID = user['id'].toString();
      }
    }

    // Ensure the widget is still mounted before calling setState
    if (mounted) {
      if (isAuthenticated) {
        // Navigate to the home page if authentication is successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => B4HomePage(
              userID: userID,
            ),
          ),
        );
      } else {
        // Show an error message if authentication fails
        setState(() {
          errorMessage = 'Invalid email or password. Please try again.';
        });
      }
    }
  }

  String _convertToSha256() {
    final input = passwordController.text;
    final bytes = utf8.encode(input); // Convert input to bytes
    final digest = sha256.convert(bytes);
    return digest.toString(); // Generate SHA-256 hash
  }

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
              key: _formKey,
              child: Column(
                children: [
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
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
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
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
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
                  CustomElevatedButton(
                    value: 'Login',
                    onPressedFunc: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _authenticateUser(); // Call authenticate function
                      }
                    }, // Call authenticate function
                    buttonElevation: 5,
                    isExpanded: true,
                    replace: true,
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
                    onPressedFunc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Pending(),
                        ),
                      );
                    },
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
                  CustomElevatedButton(
                    value: 'Apple',
                    onPressedFunc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Pending(),
                        ),
                      );
                    },
                    isExpanded: true,
                    buttonColor: secondaryColor,
                    buttonForegroungColor: primaryColor,
                    sided: true,
                    child: const Row(
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
                    onPressedFunc: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Pending(),
                        ),
                      );
                    },
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
