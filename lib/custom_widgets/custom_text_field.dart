import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../constants.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    this.textInputType = TextInputType.text,
    this.controller,
  });

  final String hint;
  final Icon prefixIcon;
  final TextInputType textInputType;
  final TextEditingController? controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _showPassword = false;
  Icon _passwordIcon = const Icon(BoxIcons.bx_hide);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: TextFormField(
        obscureText: (widget.hint.toLowerCase() == 'password')
            ? !_showPassword
            : _showPassword,
        // obscuringCharacter: '*',
        cursorColor: primaryColor,
        keyboardType: widget.textInputType,
        textCapitalization: TextCapitalization.none,
        controller: widget.controller,
        style: TextStyle(
          color: black,
          fontSize: (0.02 * screenHeight),
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          prefixIconColor: primaryColor,
          suffixIcon: (widget.hint.toLowerCase() != 'password')
              ? null
              : IconButton(
                  onPressed: () {
                    setState(
                      () {
                        _showPassword = !_showPassword;
                        _passwordIcon = (_showPassword)
                            ? const Icon(BoxIcons.bx_show)
                            : const Icon(BoxIcons.bx_hide);
                      },
                    );
                  },
                  icon: _passwordIcon,
                  splashColor: Colors.transparent,
                ),
          suffixIconColor: primaryColor,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: primaryColor,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.all(16),
          // filled: true,
          // fillColor: const Color.fromRGBO(31, 31, 31, 1),
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w400,
            fontSize: (0.023 * screenHeight),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
