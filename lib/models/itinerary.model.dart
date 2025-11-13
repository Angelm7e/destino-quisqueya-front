// models/itinerary.model.dart
import 'package:destino_quisqueya_front/models/destiny.model.dart';
import 'package:destino_quisqueya_front/models/destinationDetail.model.dart';

class Itinerary {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final List<Place> places;
  final String coverImage;
  final String? sharedBy; // null si es propio, nombre del usuario si es compartido
  final DateTime createdAt;
  final List<ItineraryDay> days;

  const Itinerary({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.places,
    required this.coverImage,
    this.sharedBy,
    required this.createdAt,
    required this.days,
  });

  int get durationInDays {
    return endDate.difference(startDate).inDays + 1;
  }

  bool get isShared => sharedBy != null;
}

