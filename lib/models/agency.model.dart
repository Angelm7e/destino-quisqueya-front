// models/travel_agency.model.dart
class SocialLinks {
  final String? instagram;
  final String? facebook;
  final String? tiktok;
  final String? youtube;

  const SocialLinks({this.instagram, this.facebook, this.tiktok, this.youtube});
}

class AgencyPhoto {
  final String id;
  final String url;
  final String? caption;

  const AgencyPhoto({required this.id, required this.url, this.caption});
}

class DestinationItem {
  final String id;
  final String title;
  final String country;
  final String city;
  final String thumbnailUrl;
  final List<String> tags;
  final double priceFrom; // USD
  final int days;
  final double rating; // 0..5
  final bool featured;

  const DestinationItem({
    required this.id,
    required this.title,
    required this.country,
    required this.city,
    required this.thumbnailUrl,
    required this.tags,
    required this.priceFrom,
    required this.days,
    required this.rating,
    this.featured = false,
  });
}

class TravelAgency {
  final String id;
  final String name;
  final String logoUrl;
  final String description;
  final double rating;
  final int reviewsCount;
  final String phone;
  final String email;
  final String website;
  final String address;
  final String city;
  final String country;
  final List<String> services; // e.g. Flights, Hotels, Tours
  final Map<String, String> openingHours; // e.g. {'Mon-Fri': '9:00–18:00'}
  final SocialLinks social;
  final List<AgencyPhoto> photos;
  final List<DestinationItem> destinations;

  const TravelAgency({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.description,
    required this.rating,
    required this.reviewsCount,
    required this.phone,
    required this.email,
    required this.website,
    required this.address,
    required this.city,
    required this.country,
    required this.services,
    required this.openingHours,
    required this.social,
    required this.photos,
    required this.destinations,
  });
}
