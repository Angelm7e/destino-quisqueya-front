// data/places_dummy.dart
import 'package:destino_quisqueya_front/models/destiny.model.dart';

final List<Place> placesDummy = [
  Place(
    categoryId: 1,
    id: 'playa-rincon',
    name: 'Playa Rincón',
    province: 'Samaná',
    country: 'República Dominicana',
    description:
        'Considerada una de las playas más hermosas del mundo: arena blanca, aguas turquesa y vegetación exuberante. Ideal para familias y fotos épicas.',
    rating: 4.8,
    location: const GeoPoint(latitude: 19.2829, longitude: -69.3645),
    photos: [
      'assets/localimages/samana1.jpeg',
      'assets/localimages/rincon_2.jpg',
      'assets/localimages/rincon_3.jpg',
    ],
    info: const PlaceInfo(
      howToGet:
          'Desde Las Galeras, toma la carretera a Playa Rincón (aprox. 25 min). También hay botes desde la playa principal.',
      recommendedHours: '08:00–17:30',
      entryFee: 'Gratis (parqueo y sillas con costo opcional)',
      services: [
        PlaceService.parking,
        PlaceService.restaurants,
        PlaceService.restrooms,
        PlaceService.rentals,
      ],
    ),
    reviews: [
      Review(
        authorName: 'Juan P.',
        rating: 5,
        comment: 'Hermosa, agua cristalina. Recomiendo llegar temprano.',
        createdAt: DateTime(2025, 6, 12),
      ),
      Review(
        authorName: 'María G.',
        rating: 4.5,
        comment: 'Muy limpia y tranquila. Hay sombra natural.',
        createdAt: DateTime(2025, 5, 28),
      ),
    ],
    tags: ['playa', 'familiar', 'fotografía'],
  ),

  Place(
    categoryId: 1,
    id: 'playa-rincon',
    name: 'Playa Rincón',
    province: 'Samaná',
    country: 'República Dominicana',
    description:
        'Considerada una de las playas más hermosas del mundo: arena blanca, aguas turquesa y vegetación exuberante. Ideal para familias y fotos épicas.',
    rating: 4.8,
    location: const GeoPoint(latitude: 19.2829, longitude: -69.3645),
    photos: [
      'assets/localimages/samana1.jpeg',
      'assets/localimages/rincon_2.jpg',
      'assets/localimages/rincon_3.jpg',
    ],
    info: const PlaceInfo(
      howToGet:
          'Desde Las Galeras, toma la carretera a Playa Rincón (aprox. 25 min). También hay botes desde la playa principal.',
      recommendedHours: '08:00–17:30',
      entryFee: 'Gratis (parqueo y sillas con costo opcional)',
      services: [
        PlaceService.parking,
        PlaceService.restaurants,
        PlaceService.restrooms,
        PlaceService.rentals,
      ],
    ),
    reviews: [
      Review(
        authorName: 'Juan P.',
        rating: 5,
        comment: 'Hermosa, agua cristalina. Recomiendo llegar temprano.',
        createdAt: DateTime(2025, 6, 12),
      ),
      Review(
        authorName: 'María G.',
        rating: 4.5,
        comment: 'Muy limpia y tranquila. Hay sombra natural.',
        createdAt: DateTime(2025, 5, 28),
      ),
    ],
    tags: ['playa', 'familiar', 'fotografía'],
  ),

  Place(
    categoryId: 2,
    id: '27-charcos-damajagua',
    name: '27 Charcos de Damajagua',
    province: 'Puerto Plata',
    country: 'República Dominicana',
    description:
        'Ruta de aventura por cañones y cascadas con saltos y toboganes naturales. Experiencia guiada con equipo de seguridad.',
    rating: 4.7,
    location: const GeoPoint(latitude: 19.6956, longitude: -70.7418),
    photos: [
      'assets/localimages/damajagua_1.jpg',
      'assets/localimages/damajagua_2.jpg',
      'assets/localimages/damajagua_3.bmp',
    ],
    info: const PlaceInfo(
      howToGet:
          'A 30 min de Puerto Plata por la carretera Navarrete–Puerto Plata. Centro de visitantes señalizado.',
      recommendedHours: '08:30–16:00',
      entryFee: '700 según cantidad de charcos (incluye guía)',
      services: [
        PlaceService.parking,
        PlaceService.restrooms,
        PlaceService.tours,
      ],
    ),
    reviews: [
      Review(
        authorName: 'Carlos M.',
        rating: 4.8,
        comment:
            'Adrenalina pura. Llevar zapatos acuáticos. Los guías son top.',
        createdAt: DateTime(2025, 3, 9),
      ),
      Review(
        authorName: 'Luisa T.',
        rating: 4.4,
        comment: 'El nivel 12 ya cansa, pero vale totalmente la pena.',
        createdAt: DateTime(2025, 4, 22),
      ),
    ],
    tags: ['ríos', 'aventura', 'senderismo'],
  ),

  Place(
    categoryId: 12,
    id: 'altos-de-chavon',
    name: 'Altos de Chavón',
    province: 'La Romana',
    country: 'República Dominicana',
    description:
        'Pueblo de estilo mediterráneo con vistas al río Chavón. Arte, anfiteatro, museos y gastronomía.',
    rating: 4.6,
    location: const GeoPoint(latitude: 18.4238, longitude: -68.8887),
    photos: [
      'assets/localimages/chavon_1.jpg',
      'assets/localimages/chavon_2.jpg',
      'assets/localimages/chavon_3.jpg',
    ],
    info: const PlaceInfo(
      howToGet:
          'Dentro de Casa de Campo. Acceso desde Autopista del Este (peatonal y en vehículo).',
      recommendedHours: '09:00–20:00',
      entryFee: '500 (puede variar por eventos)',
      services: [
        PlaceService.parking,
        PlaceService.restrooms,
        PlaceService.restaurants,
        PlaceService.wifi,
      ],
    ),
    reviews: [
      Review(
        authorName: 'Elena R.',
        rating: 4.7,
        comment: 'Vistas increíbles. Perfecto para fotos al atardecer.',
        createdAt: DateTime(2025, 2, 14),
      ),
      Review(
        authorName: 'Rafael D.',
        rating: 4.3,
        comment: 'Precios algo altos, pero la experiencia lo vale.',
        createdAt: DateTime(2025, 1, 30),
      ),
    ],
    tags: ['ciudad', 'cultura', 'historia'],
  ),
];
