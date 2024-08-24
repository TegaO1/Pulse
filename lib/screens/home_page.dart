import 'package:flutter/material.dart';
import 'package:pulse/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Sample list of health news items
  final List<String> healthNews = [
    'Regular exercise can help you maintain a healthy weight.',
    'Eating a balanced diet is crucial for good health.',
    'Stay hydrated by drinking plenty of water.',
    'Adequate sleep is important for overall well-being.',
    'Mental health is just as important as physical health.',
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColor,
        leading: Container(),
        leadingWidth: 0,
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
      resizeToAvoidBottomInset:
          true, // Avoid overflow when the keyboard appears
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text.rich(
                  style: TextStyle(
                    fontSize: 0.05 * screenHeight,
                    color: primaryColor,
                    fontWeight: FontWeight.w900,
                  ),
                  const TextSpan(
                    text: 'Hello,\n',
                    children: [
                      TextSpan(
                        text: 'Samuel',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SearchBar(
                backgroundColor: WidgetStatePropertyAll(secondaryColor),
                elevation: WidgetStatePropertyAll(1),
                shadowColor: WidgetStatePropertyAll(secondaryColor),
                leading: Icon(
                  Icons.search_rounded,
                  color: primaryColor,
                  size: 30,
                ),
                padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                hintText: 'Search for Tests',
                hintStyle: WidgetStatePropertyAll(
                  TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Health News',
                style: TextStyle(
                  fontSize: 0.024 * screenHeight,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200, // Set a fixed height for the horizontal list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: healthNews.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(right: 10),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: 0.8 * screenWidth,
                        decoration: const BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Health News ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                              ),
                            ),
                            const Text(
                              '...did you know?',
                              style: TextStyle(
                                color: primaryColor,
                                fontStyle: FontStyle.italic,
                                fontSize: 17,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                healthNews[index],
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'History',
                style: TextStyle(
                  fontSize: 0.024 * screenHeight,
                  fontWeight: FontWeight.w700,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: (screenHeight * 0.75),
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: 100, // Sample item count
                  itemBuilder: (context, index) {
                    return const Text(
                      '----- History Section -----',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
