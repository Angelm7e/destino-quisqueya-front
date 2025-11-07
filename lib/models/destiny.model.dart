// models/place_models.dart

enum PlaceService {
  parking,
  restrooms,
  restaurants,
  lifeguards,
  tours,
  rentals, // chairs/umbrellas, kayaks, etc.
  wifi,
}

class GeoPoint {
  final double latitude;
  final double longitude;

  const GeoPoint({required this.latitude, required this.longitude});
}

class Review {
  final String authorName;
  final double rating; // 0..5
  final String comment;
  final DateTime createdAt;

  const Review({
    required this.authorName,
    required this.rating,
    required this.comment,
    required this.createdAt,
  });
}

class PlaceInfo {
  final String howToGet; // brief directions
  final String? recommendedHours; // e.g. "08:00–17:00"
  final String? entryFee; // e.g. "RD$200 (parqueo opcional)"
  final List<PlaceService> services;

  const PlaceInfo({
    required this.howToGet,
    this.recommendedHours,
    this.entryFee,
    this.services = const [],
  });
}

class Place {
  final String id;
  final String name;
  final String province; // or city/municipality if you prefer
  final String country;
  final String description;
  final double rating; // avg rating
  final GeoPoint location;
  final List<String> photos; // asset paths or URLs
  final PlaceInfo info;
  final List<Review> reviews;
  final List<String> tags; // e.g. ["playa", "familiar"]
  final int categoryId;

  const Place({
    required this.id,
    required this.name,
    required this.province,
    required this.country,
    required this.description,
    required this.rating,
    required this.location,
    required this.photos,
    required this.info,
    required this.reviews,
    this.tags = const [],
    required this.categoryId,
  });
}
