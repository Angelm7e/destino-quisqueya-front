// models/destination_detail.model.dart
class ItineraryDay {
  final int day;
  final String title;
  final String description;
  ItineraryDay({
    required this.day,
    required this.title,
    required this.description,
  });
}

class ReviewItem {
  final String id;
  final String userName;
  final double rating; // 0..5
  final String comment;
  final DateTime date;
  ReviewItem({
    required this.id,
    required this.userName,
    required this.rating,
    required this.comment,
    required this.date,
  });
}

class FAQItem {
  final String question;
  final String answer;
  FAQItem({required this.question, required this.answer});
}

class DestinationDetail {
  final String destinationId; // ties to DestinationItem.id
  final String description;
  final List<String> highlights; // bullets
  final List<String> inclusions; // what’s included
  final List<String> exclusions; // what’s not included
  final List<ItineraryDay> itinerary;
  final List<String> gallery; // asset paths or URLs
  final List<FAQItem> faqs;
  final List<ReviewItem> reviews;

  DestinationDetail({
    required this.destinationId,
    required this.description,
    required this.highlights,
    required this.inclusions,
    required this.exclusions,
    required this.itinerary,
    required this.gallery,
    required this.faqs,
    required this.reviews,
  });
}
