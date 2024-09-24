import 'package:http/http.dart' as http;
import 'dart:convert'; // Make sure to import this for JSON decoding

Future<List<dynamic>> fetchShows() async {
  final response =
      await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));

  if (response.statusCode == 200) {
    // Decode the JSON response
    List<dynamic> jsonData = jsonDecode(response.body);

    // Return the data as a list of dynamic objects
    return jsonData;
  } else {
    throw Exception('Failed to load shows');
  }
}
