import 'package:carousel_slider/carousel_slider.dart';
import 'package:destino_quisqueya_front/generated/l10n.dart';
import 'package:destino_quisqueya_front/models/destiny.model.dart';
import 'package:destino_quisqueya_front/screens/places/placeDetailsScreen/placeDetailScreen.dart';
import 'package:destino_quisqueya_front/utilities/const/app_colors.dart';
import 'package:destino_quisqueya_front/utilities/const/constants.dart';
import 'package:destino_quisqueya_front/utilities/dummyData/places.dart';
import 'package:destino_quisqueya_front/widgets/categoryList.widget.dart';
import 'package:destino_quisqueya_front/widgets/placeCardGrid.widget.dart';
import 'package:destino_quisqueya_front/widgets/scaffold.widget.dart';
import 'package:destino_quisqueya_front/widgets/searchBar.widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DQScaffoldWidget(
      currentIndex: currentIndex,
      body: RefreshIndicator(
        onRefresh: () async {
          // Aquí puedes agregar lógica para refrescar datos
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              const SizedBox(height: 10),
              const SearchBarWidget(
                hintText: 'Buscar un destino...',
              ),
              const SizedBox(height: 20),
              CarouselSliderWidget(),
              SizedBox(height: 20),
              CategorySection(),
              SizedBox(height: 20),
              RecommendedSection(),
              SizedBox(height: 20),
              NearbyPlacesSection(),
            ],
          ),
        ),
      ),
    );
  }
}

// Header con saludo personalizado
class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Obtener nombre del usuario desde el provider/auth
    final userName = 'Usuario'; // Reemplazar con nombre real del usuario

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        horizontalPadding,
        40,
        horizontalPadding,
        20,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.lightPrimary,
            AppColors.lightPrimary.withOpacity(0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hola $userName 👋',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '¿A dónde quieres ir hoy?',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 32),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// Carrusel de imágenes destacadas
class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({super.key});

  // Obtener imágenes destacadas de los lugares
  List<String> get featuredImages {
    final sorted = List<Place>.from(placesDummy);
    sorted.sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(3).expand((place) => [place.photos.first]).toList();
  }

  @override
  Widget build(BuildContext context) {
    final images = featuredImages;
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: SizedBox(
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (context, index, realIdx) {
              final src = images[index];
              return Image.asset(
                src,
                fit: BoxFit.cover,
                width: double.infinity,
              );
            },
            options: CarouselOptions(
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              height: 200,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 600),
              enableInfiniteScroll: true,
            ),
          ),
        ),
      ),
    );
  }
}

// Sección de categorías
class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: CategoryListWidget(),
    );
  }
}

// Sección de lugares recomendados
class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  // Obtener lugares destacados (mejor valorados)
  List<Place> get recommendedPlaces {
    final sorted = List<Place>.from(placesDummy);
    sorted.sort((a, b) => b.rating.compareTo(a.rating));
    return sorted.take(6).toList();
  }

  @override
  Widget build(BuildContext context) {
    final places = recommendedPlaces;
    if (places.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.star,
                  color: AppColors.lightPrimary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Lugares Recomendados',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Los más populares y mejor valorados',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return PlaceCardGridWidget(
                place: place,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailScreen(place: place),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// Sección de lugares cercanos
class NearbyPlacesSection extends StatelessWidget {
  const NearbyPlacesSection({super.key});

  // Obtener lugares cercanos (simulado - en producción usarías ubicación real)
  List<Place> get nearbyPlaces {
    return placesDummy.take(4).toList();
  }

  @override
  Widget build(BuildContext context) {
    final places = nearbyPlaces;
    if (places.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.lightPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.location_on,
                  color: AppColors.lightPrimary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).closeToYou,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Explora lugares increíbles cerca de ti',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return PlaceCardGridWidget(
                place: place,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlaceDetailScreen(place: place),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
