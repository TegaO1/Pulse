import 'package:flutter/material.dart';

import '../constants.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.value,
    required this.nextPage,
    this.buttonColor = primaryColor,
    this.buttonForegroungColor = Colors.white,
    this.buttonElevation = 0,
    this.child = const Text(''),
    this.isExpanded = false,
    this.sided = false,
    this.sideColor = primaryColor,
  });

  final String value;
  final Widget nextPage;
  final double buttonElevation;
  final Color buttonColor;
  final Color buttonForegroungColor;
  final Widget child;
  final bool isExpanded;
  final bool sided;
  final Color sideColor;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        foregroundColor: buttonForegroungColor,
        fixedSize: Size(
          (isExpanded) ? double.maxFinite : (0.74 * screenWidth),
          (0.072 * screenHeight),
        ),
        elevation: buttonElevation,
        shadowColor: buttonColor,
        overlayColor: primaryColor,
        side: (sided)
            ? BorderSide(
                color: sideColor,
                width: 2,
              )
            : BorderSide.none,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => nextPage,
          ),
        );
      },
      child: (child is Text)
          ? Text(
              value,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w600,
              ),
            )
          : child,
    );
  }
}
