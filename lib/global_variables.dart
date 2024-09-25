import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchShows() async {
  final response =
      await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);

    return jsonData;
  } else {
    throw Exception('Failed to load shows');
  }
}
