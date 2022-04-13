import 'package:flutter/material.dart';

class Club {
  final String id;
  final String name;
  final String country;
  final int value;
  final String imageUrl;
  final int europeanTitles;

  Club({
    @required this.id,
    @required this.name,
    @required this.country,
    @required this.value,
    @required this.imageUrl,
    @required this.europeanTitles,
  });
}
