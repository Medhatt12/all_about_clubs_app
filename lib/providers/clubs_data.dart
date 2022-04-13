import '../models/club.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ClubsData with ChangeNotifier {
  List<Club> _clubs = [];

  List<Club> get getClubs {
    return [..._clubs];
  }

  Future<void> fetchAndSetClubs() async {
    var url = Uri.parse('https://public.allaboutapps.at/hiring/clubs.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data1 = utf8.decode(response.body.codeUnits);
      final data = json.decode(data1) as List<dynamic>;
      final List<Club> loadedClubs = [];
      if (data == null) {
        return;
      }

      for (var element in data) {
        loadedClubs.add(Club(
          id: element['id'],
          name: element['name'],
          country: element['country'],
          value: element['value'],
          imageUrl: element['image'],
          europeanTitles: element['european_titles'],
        ));
      }

      _clubs = loadedClubs.toList();
      _clubs.sort((a, b) => a.name.compareTo(b.name));
      notifyListeners();
    }
  }

  void getClubsSortedByNameAscending() {
    _clubs.sort((a, b) => a.name.compareTo(b.name));
  }

  void getClubsSortedByValueDescending() {
    _clubs.sort((a, b) => b.value.compareTo(a.value));
  }

  Club findById(String id) {
    return _clubs.firstWhere((club) => club.id == id);
  }
}
