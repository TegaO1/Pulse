import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/constants.dart';
import 'package:pulse/screens/pending.dart';

import 'home_page.dart';

class B4HomePage extends StatefulWidget {
  const B4HomePage({super.key});

  @override
  State<B4HomePage> createState() => _B4HomePageState();
}

class _B4HomePageState extends State<B4HomePage> {
  int myCurrentIndex = 0;
  List pages = const [
    HomePage(),
    Pending(),
    Pending(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Container(
        // margin: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 25,
              offset: const Offset(8, 20),
            ),
          ],
        ),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            backgroundColor: secondaryColor,
            selectedItemColor: primaryColor,
            unselectedItemColor: Colors.black,
            elevation: 20,
            currentIndex: myCurrentIndex,
            onTap: (index) {
              setState(() {
                myCurrentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_outlined,
                    size: 32,
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.medical_services_outlined,
                    size: 32,
                  ),
                  label: 'Test'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Iconsax.profile_circle_outline,
                    size: 32,
                  ),
                  label: 'Profile'),
            ],
          ),
        ),
      ),
      body: pages[myCurrentIndex],
    );
  }
}
