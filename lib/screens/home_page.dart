import 'package:flutter/material.dart';
import 'package:pulse/constants.dart';
import 'package:pulse/custom_widgets/custom_elevated_button.dart';
import 'package:pulse/fetch_data.dart'; // Import the fetchHeartHealthData function from this file

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.userInfo,
  });

  final Map<String, String> userInfo;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> healthNews = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchHealthNews();
  }

  @override
  void dispose() {
    // Clean up resources if needed
    super.dispose();
  }

  // Function to fetch health news and handle errors
  Future<void> fetchHealthNews() async {
    if (!mounted) return; // Check if widget is still mounted

    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      List<dynamic> fetchedNews = await fetchHeartHealthData();

      if (mounted) {
        setState(() {
          healthNews = fetchedNews;
          isLoading = false;
          hasError = fetchedNews.isEmpty;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          healthNews = [];
          isLoading = false;
          hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                  TextSpan(
                    text: 'Hello,\n',
                    children: [
                      TextSpan(
                        text: '${widget.userInfo['user_name']}',
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
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
                height: 300, // Adjusted height to fit the content
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      ) // Show loader while fetching data
                    : hasError
                        ? Center(
                            child: Column(
                              children: [
                                smallSpace2x,
                                const Text(
                                  'Retry or Check your Internet Connection.',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                CustomElevatedButton(
                                  value: 'Retry',
                                  onPressedFunc: fetchHealthNews,
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: healthNews.length,
                            itemBuilder: (context, index) {
                              final article = healthNews[index];
                              return Container(
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.only(bottom: 10),
                                width: 0.8 * screenWidth,
                                child: Stack(
                                  children: [
                                    // Background image
                                    Positioned.fill(
                                      child: article['top_image'] != null
                                          ? Image.network(
                                              article['top_image'],
                                              fit: BoxFit.cover,
                                            )
                                          : Container(
                                              color: Colors.grey[300],
                                            ),
                                    ),
                                    // Overlay for text
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        color: Colors.black.withOpacity(0.5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              article['title'] ?? 'No Title',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              article['short_description'] ??
                                                  'No Description',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
