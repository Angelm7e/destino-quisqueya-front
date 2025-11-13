// data/itineraries_dummy.dart
import 'package:destino_quisqueya_front/models/destinationDetail.model.dart';
import 'package:destino_quisqueya_front/models/itinerary.model.dart';
import 'package:destino_quisqueya_front/utilities/dummyData/places.dart';

final List<Itinerary> itinerariesDummy = [
  Itinerary(
    id: 'it1',
    name: 'Semana Santa en Samaná',
    description: 'Una semana completa explorando las mejores playas y cascadas de Samaná',
    startDate: DateTime(2025, 4, 12),
    endDate: DateTime(2025, 4, 15),
    places: [
      placesDummy[0], // Playa Rincón
      placesDummy[1], // 27 Charcos
    ],
    coverImage: 'assets/localimages/samana1.jpeg',
    createdAt: DateTime(2025, 3, 1),
    days: [
      ItineraryDay(
        day: 1,
        title: 'Llegada a Samaná',
        description: 'Check-in en hotel, tarde en Playa Rincón, cena local',
      ),
      ItineraryDay(
        day: 2,
        title: 'Aventura en los 27 Charcos',
        description: 'Excursión completa a los charcos de Damajagua',
      ),
      ItineraryDay(
        day: 3,
        title: 'Día de playa',
        description: 'Relajación en Playa Rincón, snorkel y fotos',
      ),
      ItineraryDay(
        day: 4,
        title: 'Despedida',
        description: 'Última mañana en la playa, check-out y regreso',
      ),
    ],
  ),
  Itinerary(
    id: 'it2',
    name: 'Fin de semana verde 🌲',
    description: 'Escapada a las montañas de Jarabacoa',
    startDate: DateTime(2025, 5, 10),
    endDate: DateTime(2025, 5, 12),
    places: [
      placesDummy[1], // 27 Charcos
    ],
    coverImage: 'assets/localimages/damajagua_1.jpg',
    sharedBy: 'Massiel Moreta',
    createdAt: DateTime(2025, 4, 20),
    days: [
      ItineraryDay(
        day: 1,
        title: 'Llegada a Jarabacoa',
        description: 'Check-in, exploración del pueblo, cena',
      ),
      ItineraryDay(
        day: 2,
        title: 'Aventura en la naturaleza',
        description: 'Rafting, senderismo y cascadas',
      ),
      ItineraryDay(
        day: 3,
        title: 'Regreso',
        description: 'Desayuno y regreso a casa',
      ),
    ],
  ),
  Itinerary(
    id: 'it3',
    name: 'Tour cultural en La Romana',
    description: 'Descubre la historia y cultura de La Romana',
    startDate: DateTime(2025, 6, 1),
    endDate: DateTime(2025, 6, 3),
    places: [
      placesDummy[2], // Altos de Chavón
    ],
    coverImage: 'assets/localimages/chavon_1.jpg',
    createdAt: DateTime(2025, 5, 15),
    days: [
      ItineraryDay(
        day: 1,
        title: 'Llegada y Altos de Chavón',
        description: 'Check-in, visita a Altos de Chavón, cena en el anfiteatro',
      ),
      ItineraryDay(
        day: 2,
        title: 'Museos y arte',
        description: 'Visita a museos locales, talleres de arte',
      ),
      ItineraryDay(
        day: 3,
        title: 'Último día',
        description: 'Compras de souvenirs, regreso',
      ),
    ],
  ),
];

