import 'package:flutter/widgets.dart';

enum PlaceCategoryKind {
  beaches,
  rivers,
  cities,
  mountains,
  waterfalls,
  islandsCays,
  monuments,
  nationalParks,
  museums,
  caves,
  lakes,
  festivals,
}

class PlaceCategory {
  final int id;
  final String name;
  final IconData icon;
  final PlaceCategoryKind kind;
  final Color? color;

  const PlaceCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.kind,
    this.color,
  });
}
