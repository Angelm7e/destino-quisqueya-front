// data/destination_detail_dummy.dart
import 'package:destino_quisquella_front/models/destinationDetail.model.dart';

final List<DestinationDetail> destinationDetails = [
  DestinationDetail(
    destinationId: 'd1',
    description:
        'Experience pristine beaches, crystal-clear waters and vibrant nightlife. Perfect for families and couples.',
    highlights: [
      'All-inclusive resort',
      'Airport transfer',
      'Snorkeling adventure',
      'Kids club & shows',
    ],
    inclusions: [
      '4 nights accommodation',
      'All meals & drinks',
      'Airport transfer',
      'Snorkeling tour',
    ],
    exclusions: ['Travel insurance', 'Premium excursions', 'Personal expenses'],
    itinerary: [
      ItineraryDay(
        day: 1,
        title: 'Arrival & Relax',
        description: 'Check-in, beach time, welcome dinner.',
      ),
      ItineraryDay(
        day: 2,
        title: 'Snorkeling Adventure',
        description: 'Boat trip to reef and snorkeling.',
      ),
      ItineraryDay(
        day: 3,
        title: 'Resort Day',
        description: 'Relax at pool, optional spa, night show.',
      ),
      ItineraryDay(
        day: 4,
        title: 'Free Day',
        description: 'Optional excursions like buggy or city tour.',
      ),
    ],
    gallery: [
      'assets/localimages/punta_cana.jpg',
      'assets/localimages/agency_1.jpg',
      'assets/localimages/agency_2.jpg',
    ],
    faqs: [
      FAQItem(question: 'Do I need a visa?', answer: 'Most travelers do not.'),
    ],
    reviews: [
      ReviewItem(
        id: 'r1',
        userName: 'Maria G.',
        rating: 5,
        comment: 'Amazing beach and great service!',
        date: DateTime(2025, 6, 12),
      ),
    ],
  ),
  DestinationDetail(
    destinationId: 'd2',
    description:
        'Explore Cartagena’s colorful streets, historic walls and Caribbean vibes.',
    highlights: ['Walking tour', 'Sunset at the walls', 'Local food tasting'],
    inclusions: ['3 nights hotel', 'Breakfast', 'Walking tour'],
    exclusions: ['Flights', 'Tips'],
    itinerary: [
      ItineraryDay(
        day: 1,
        title: 'Arrival & Old Town',
        description: 'Check-in and sunset at the walls.',
      ),
      ItineraryDay(
        day: 2,
        title: 'Walking Tour',
        description: 'Guided old town tour + food tasting.',
      ),
      ItineraryDay(
        day: 3,
        title: 'Free Day',
        description: 'Optional Rosario Islands tour.',
      ),
    ],
    gallery: ['assets/localimages/cartagena.jpg'],
    faqs: [],
    reviews: [
      ReviewItem(
        id: 'r2',
        userName: 'Ana',
        rating: 4.6,
        comment: 'Romantic and safe. Loved it.',
        date: DateTime(2025, 5, 28),
      ),
    ],
  ),
  DestinationDetail(
    destinationId: 'd3',
    description: 'Enjoy Cancún’s beaches, adventure parks and nightlife.',
    highlights: ['Beach parties', 'Adventure parks', 'Snorkeling'],
    inclusions: [
      '5 nights hotel',
      'Breakfast & dinner',
      'Adventure park ticket',
    ],
    exclusions: ['Flights', 'Tips', 'Personal expenses'],
    itinerary: [
      ItineraryDay(
        day: 1,
        title: 'Arrival',
        description: 'Airport pickup, check-in, welcome party.',
      ),
      ItineraryDay(
        day: 2,
        title: 'Adventure Park',
        description: 'Day at Xcaret/Xplor.',
      ),
      ItineraryDay(
        day: 3,
        title: 'Beach Day',
        description: 'Snorkeling and free night.',
      ),
      ItineraryDay(day: 4, title: 'Nightlife', description: 'Coco Bongo show.'),
      ItineraryDay(
        day: 5,
        title: 'Free Day',
        description: 'Shopping or extra excursions.',
      ),
    ],
    gallery: ['assets/localimages/cancun.jpg'],
    faqs: [],
    reviews: [
      ReviewItem(
        id: 'r3',
        userName: 'Luis P.',
        rating: 4.5,
        comment: 'Nightlife is incredible!',
        date: DateTime(2025, 4, 10),
      ),
    ],
  ),
  DestinationDetail(
    destinationId: 'd4',
    description: 'Luxury cruise through the Bahamas, perfect for relaxation.',
    highlights: ['7-night cruise', 'Premium cabins', 'Island excursions'],
    inclusions: ['Cabin accommodation', 'Meals & entertainment on board'],
    exclusions: ['Flights to port', 'Tips', 'Optional excursions'],
    itinerary: [
      ItineraryDay(
        day: 1,
        title: 'Departure',
        description: 'Embark from Miami.',
      ),
      ItineraryDay(day: 2, title: 'Nassau', description: 'Guided city tour.'),
      ItineraryDay(
        day: 3,
        title: 'Private Island',
        description: 'Beach BBQ and water sports.',
      ),
      ItineraryDay(
        day: 4,
        title: 'Free Sailing Day',
        description: 'Onboard activities.',
      ),
    ],
    gallery: ['assets/localimages/bahamas.jpg'],
    faqs: [],
    reviews: [
      ReviewItem(
        id: 'r4',
        userName: 'Sophie',
        rating: 4.8,
        comment: 'Luxury cabins and amazing service!',
        date: DateTime(2025, 7, 19),
      ),
    ],
  ),
];
