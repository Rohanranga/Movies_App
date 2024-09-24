import 'package:flutter/material.dart';
import 'package:movies_app/downlad_page.dart';
import 'package:movies_app/films_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentpage = 0;

  List<Widget> pages = [
    const FilmsList(),
    const DownloadPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentpage, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 40,
        onTap: (value) {
          setState(
            () {
              currentpage = value;
            },
          );
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'dowloads',
          ),
        ],
      ),
    );
  }
}
