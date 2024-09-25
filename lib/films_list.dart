import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/films_card.dart';
import 'dart:convert';
import 'package:movies_app/films_details_page.dart';

class FilmsList extends StatefulWidget {
  const FilmsList({super.key});

  @override
  _FilmsListState createState() => _FilmsListState();
}

class _FilmsListState extends State<FilmsList> {
  late Future<List<dynamic>> futureShows;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureShows = fetchShows(); // Fetch data from API initially
  }

  Future<List<dynamic>> fetchShows([String searchTerm = '']) async {
    final url = searchTerm.isEmpty
        ? 'https://api.tvmaze.com/shows' // Default URL if no search term
        : 'https://api.tvmaze.com/search/shows?q=$searchTerm'; // URL with search term

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return searchTerm.isEmpty
          ? data
          : data.map((item) => item['show']).toList();
    } else {
      throw Exception('Failed to load shows');
    }
  }

  void _searchShows() {
    setState(() {
      // Fetch shows based on the search term
      futureShows = fetchShows(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(50),
        right: Radius.circular(50),
      ),
    );

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ZoomIn(
                  child: Text(
                    'MYFLIX\nMovies',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: _searchShows, // Call the search function
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: futureShows,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No data available'));
                } else {
                  final shows = snapshot.data!;
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = constraints.maxWidth > 800
                          ? 3
                          : (constraints.maxWidth > 600 ? 2 : 1);
                      return GridView.builder(
                        itemCount: shows.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          final show = shows[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          FilmsDetailsPage(films: show),
                                  transitionDuration:
                                      const Duration(milliseconds: 50),
                                  transitionsBuilder:
                                      (context, animation1, animation2, child) {
                                    return ScaleTransition(
                                      scale: animation1,
                                      alignment: Alignment.center,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                            },
                            child: Animate(
                              effects: const [
                                FadeEffect(),
                                ScaleEffect(),
                              ],
                              child: FilmsCard(
                                title: show['name'] ?? 'No Title',
                                director: show['network'] != null
                                    ? show['network']['name']
                                    : 'No Network',
                                image: show['image'] != null
                                    ? show['image']['medium']
                                    : '',
                                backgroundColor: index.isEven
                                    ? const Color.fromRGBO(216, 240, 253, 1)
                                    : const Color.fromRGBO(245, 247, 249, 1),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
