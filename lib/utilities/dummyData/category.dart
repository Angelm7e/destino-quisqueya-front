import 'package:destino_quisqueya_front/models/category.model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<PlaceCategory> categoriesDummy = [
  PlaceCategory(
    id: 1,
    name: 'Playas',
    icon: FontAwesomeIcons.umbrellaBeach,
    kind: PlaceCategoryKind.beaches,
    color: const Color(0xFF0EA5E9),
  ),
  PlaceCategory(
    id: 2,
    name: 'Ríos',
    icon: FontAwesomeIcons.water,
    kind: PlaceCategoryKind.rivers,
    color: const Color(0xFF22D3EE),
  ),
  PlaceCategory(
    id: 3,
    name: 'Ciudades',
    icon: FontAwesomeIcons.city,
    kind: PlaceCategoryKind.cities,
    color: const Color(0xFF64748B),
  ),
  PlaceCategory(
    id: 4,
    name: 'Montañas',
    icon: FontAwesomeIcons.mountain,
    kind: PlaceCategoryKind.mountains,
    color: const Color(0xFF16A34A),
  ),
  PlaceCategory(
    id: 5,
    name: 'Cascadas',
    icon: FontAwesomeIcons.personSwimming,
    kind: PlaceCategoryKind.waterfalls,
    color: const Color(0xFF0EA5E9),
  ),
  PlaceCategory(
    id: 6,
    name: 'Islas y Cayos',
    icon: FontAwesomeIcons.earthAmericas, // alias en FA6
    kind: PlaceCategoryKind.islandsCays,
    color: const Color(0xFF06B6D4),
  ),
  PlaceCategory(
    id: 7,
    name: 'Monumentos',
    icon: FontAwesomeIcons.landmark,
    kind: PlaceCategoryKind.monuments,
    color: const Color(0xFF8B5CF6),
  ),
  PlaceCategory(
    id: 8,
    name: 'Parques Nacionales',
    icon: FontAwesomeIcons.tree,
    kind: PlaceCategoryKind.nationalParks,
    color: const Color(0xFF16A34A),
  ),
  PlaceCategory(
    id: 9,
    name: 'Museos',
    icon: FontAwesomeIcons.buildingColumns,
    kind: PlaceCategoryKind.museums,
    color: const Color(0xFFF59E0B),
  ),
  PlaceCategory(
    id: 10,
    name: 'Cuevas',
    icon: FontAwesomeIcons.personHiking,
    kind: PlaceCategoryKind.caves,
    color: const Color(0xFFFB7185),
  ),
  PlaceCategory(
    id: 11,
    name: 'Lagunas y Lagos',
    icon: FontAwesomeIcons.waterLadder,
    kind: PlaceCategoryKind.lakes,
    color: const Color(0xFF22D3EE),
  ),
  PlaceCategory(
    id: 12,
    name: 'Festivales y Eventos',
    icon: FontAwesomeIcons.mask, // carnaval / eventos
    kind: PlaceCategoryKind.festivals,
    color: const Color(0xFFE11D48),
  ),
];
