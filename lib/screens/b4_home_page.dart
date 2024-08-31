import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/constants.dart';
import 'package:pulse/screens/pending.dart';
import 'home_page.dart';
import 'test_page.dart';

class B4HomePage extends StatefulWidget {
  const B4HomePage({super.key, required this.userID});

  final String userID;

  @override
  State<B4HomePage> createState() => _B4HomePageState();
}

class _B4HomePageState extends State<B4HomePage> {
  Future<Map<String, String>> _loadUserPersonalData() async {
    final String response = await rootBundle.loadString('assets/users.json');
    final data = json.decode(response) as Map<String, dynamic>;

    // Safely parse the list of users ensuring each user is a Map<String, String>
    List<Map<String, String>> users = (data['users'] as List)
        .map((user) => {
              'id': user['id'].toString(),
              'email': user['email'].toString(),
              'password': user['password'].toString(),
            })
        .toList();

    // Find the user that matches the userID
    return users.firstWhere(
      (user) => user['id'] == widget.userID,
      orElse: () => {}, // Return an empty map if no match is found
    );
  }

  int myCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _loadUserPersonalData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while data is being fetched
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          // Handle error state
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          // Data loaded successfully
          Map<String, String> userInfo = snapshot.data ?? {};

          // Define pages with userInfo available
          List pages = [
            HomePage(userInfo: userInfo),
            const TestPage(),
            const Pending(),
          ];

          return Scaffold(
            extendBodyBehindAppBar: true,
            extendBody: true,
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: primaryColor,
              leading: Container(),
              leadingWidth: 0,
              centerTitle: true,
              title: const Row(
                children: [
                  SizedBox(
                    height: 32,
                    width: 42,
                    child: Image(
                      image: AssetImage('assets/images/Pulse_Icon.png'),
                      color: primaryColor,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Pulse',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
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
      },
    );
  }
}
