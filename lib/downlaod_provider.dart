import 'package:flutter/material.dart';

class DownlaodProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> download = [];

  void addFilms(Map<String, dynamic> films) {
    download.add(films);
    notifyListeners();
  }

  void removefilms(Map<String, dynamic> films) {
    download.remove(films);
    notifyListeners();
  }
}
