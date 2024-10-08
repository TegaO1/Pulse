import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pulse/constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    super.key,
    required this.userInfo,
  });

  final Map<String, String> userInfo;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<dynamic> healthNews = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up resources if needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 21,
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    hoverColor: Colors.transparent,
                    icon: const Icon(
                      Icons.edit_outlined,
                      color: primaryColor,
                      size: 21,
                      weight: 30,
                    ),
                  )
                ],
              ),
              smallSpace2x,
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_2_rounded,
                  color: secondaryColor,
                  size: 100,
                ),
              ),
              Column(
                children: [
                  Text(
                    "${widget.userInfo["user_name"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 32,
                      color: Color.fromARGB(255, 66, 4, 4),
                    ),
                  ),
                  Text(
                    "${widget.userInfo["email"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "User ID: ID0${widget.userInfo["id"]}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.person_2,
                          color: primaryColor,
                          size: 21,
                        ),
                        const SizedBox(width: 21),
                        Text(
                          "${widget.userInfo["full_name"]}",
                          style: const TextStyle(
                            fontSize: 21,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    smallSpace2x,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          BoxIcons.bx_male_female,
                          color: primaryColor,
                          size: 21,
                        ),
                        const SizedBox(width: 21),
                        Text(
                          "${widget.userInfo["gender"]}",
                          style: const TextStyle(
                            fontSize: 21,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    smallSpace2x,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.call,
                          color: primaryColor,
                          size: 21,
                        ),
                        const SizedBox(width: 21),
                        Text(
                          "${widget.userInfo["phone_number"]}",
                          style: const TextStyle(
                            fontSize: 21,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
