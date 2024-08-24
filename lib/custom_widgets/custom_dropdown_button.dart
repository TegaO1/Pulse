import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
// import 'package:icons_plus/icons_plus.dart';

import '../constants.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton({
    super.key,
  });

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  String? _selectedValue;

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
      child: DropdownButton(
        value: _selectedValue,
        onChanged: (String? newValue) {
          setState(
            () {
              _selectedValue = (newValue != '0') ? newValue : _selectedValue;
            },
          );
        },
        items: const [
          DropdownMenuItem<String>(
            value: '1',
            child: Row(
              children: [
                Icon(
                  BoxIcons.bx_male,
                  color: primaryColor,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Male',
                  ),
                ),
              ],
            ),
          ),
          DropdownMenuItem<String>(
            value: '2',
            child: Row(
              children: [
                Icon(
                  BoxIcons.bx_female,
                  color: primaryColor,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Female',
                  ),
                ),
              ],
            ),
          )
        ],
        hint: Row(
          children: [
            const Icon(
              BoxIcons.bx_male_female,
              color: primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Select Gender',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: (0.023 * screenHeight),
                ),
              ),
            ),
          ],
        ),
        icon: const Icon(
          BoxIcons.bxs_down_arrow,
          color: primaryColor,
        ),
        dropdownColor: secondaryColor,
        underline: const Text(''),
        style: TextStyle(
          color: black,
          fontSize: (0.02 * screenHeight),
          fontWeight: FontWeight.w500,
        ),
        isExpanded: true,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      ),
    );
  }
}
