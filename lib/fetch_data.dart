import 'dart:convert'; // For JSON encoding and decoding
import 'package:http/http.dart' as http;
import 'variables.dart';

/// Function to fetch data from the API and return the list of news articles.
Future<List<Map<String, dynamic>>> fetchHeartHealthData() async {
  final url = Uri.parse("https://newsnow.p.rapidapi.com/newsv2_top_news_cat");
  final headers = {
    'x-rapidapi-key': apiKey, // Replace with your actual key
    'x-rapidapi-host': 'newsnow.p.rapidapi.com',
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    "category": "HEALTH", // Change to relevant category
    "location": "",
    "language": "en",
    "page": 1,
  });

  try {
    final response = await http
        .post(
      url,
      headers: headers,
      body: body,
    )
        .timeout(
      const Duration(minutes: 1),
      onTimeout: () {
        // Timeout after 1 minute
        print('Request timed out after 1 minute.');
        return http.Response('Error: Request Timeout', 408);
      },
    );

    // Log response for debugging
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      // Parse the response and handle possible null values
      final data = jsonDecode(response.body);

      // Check if 'news' is a valid list
      if (data != null && data['news'] != null) {
        List<Map<String, dynamic>> articles = (data['news'] as List)
            .map((article) => {
                  'title': article['title'] ?? 'No Title',
                  'url': article['url'] ?? '',
                  'top_image': article['top_image'] ?? '',
                  'date': article['date'] ?? '',
                  'short_description': article['short_description'] ?? '',
                  'text': article['text'] ?? '',
                  'publisher': article['publisher'] != null
                      ? {
                          'title': article['publisher']['title'] ?? '',
                          'href': article['publisher']['href'] ?? '',
                        }
                      : {},
                })
            .toList();
        return articles;
      } else {
        // If 'news' is not present or not a list, log details
        print('Unexpected response structure. Data: $data');
        return [];
      }
    } else {
      print('Failed to load data: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
