import 'dart:math' as math;

import 'package:destino_quisqueya_front/generated/l10n.dart';
import 'package:destino_quisqueya_front/models/destiny.model.dart';
import 'package:destino_quisqueya_front/screens/places/placeDetailsScreen/placeDetailScreen.dart';
import 'package:destino_quisqueya_front/utilities/const/app_colors.dart';
import 'package:destino_quisqueya_front/utilities/const/constants.dart';
import 'package:destino_quisqueya_front/utilities/dummyData/category.dart';
import 'package:destino_quisqueya_front/utilities/dummyData/places.dart';
import 'package:destino_quisqueya_front/widgets/scaffold.widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NearByScreen extends StatefulWidget {
  const NearByScreen({super.key});

  static const String routeName = '/NearByScreen';

  @override
  State<NearByScreen> createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen>
    with SingleTickerProviderStateMixin {
  int _selectedViewIndex = 0; // 0 = Lista, 1 = Mapa
  int? _selectedCategoryId;
  double _minRating = 0.0;
  double _maxDistance = 100.0; // km
  bool _isLoadingLocation = false;
  final String _currentLocation = 'Santiago de los Caballeros';
  late TabController _tabController;

  // Ubicación simulada del usuario (Santiago de los Caballeros)
  final GeoPoint _userLocation = const GeoPoint(
    latitude: 19.4517,
    longitude: -70.6970,
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedViewIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Calcular distancia entre dos puntos (fórmula de Haversine)
  double _calculateDistance(GeoPoint point1, GeoPoint point2) {
    const double earthRadius = 6371; // km
    final double dLat = _degreesToRadians(point2.latitude - point1.latitude);
    final double dLon = _degreesToRadians(point2.longitude - point1.longitude);

    final double a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(point1.latitude)) *
            math.cos(_degreesToRadians(point2.latitude)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  // Obtener lugares filtrados
  List<Place> get _filteredPlaces {
    var places = List<Place>.from(placesDummy);

    // Filtrar por categoría
    if (_selectedCategoryId != null) {
      places = places
          .where((p) => p.categoryId == _selectedCategoryId)
          .toList();
    }

    // Filtrar por rating mínimo
    places = places.where((p) => p.rating >= _minRating).toList();

    // Calcular distancias y filtrar por distancia máxima
    final placesWithDistance = places.map((place) {
      final distance = _calculateDistance(_userLocation, place.location);
      return {'place': place, 'distance': distance};
    }).toList();

    placesWithDistance.removeWhere(
      (item) => (item['distance'] as double) > _maxDistance,
    );

    // Ordenar por distancia
    placesWithDistance.sort(
      (a, b) => (a['distance'] as double).compareTo(b['distance'] as double),
    );

    return placesWithDistance.map((item) => item['place'] as Place).toList();
  }

  // Obtener distancia de un lugar
  double _getPlaceDistance(Place place) {
    return _calculateDistance(_userLocation, place.location);
  }

  // Obtener nombre de categoría
  String _getCategoryName(int categoryId) {
    final category = categoriesDummy.firstWhere(
      (c) => c.id == categoryId,
      orElse: () => categoriesDummy.first,
    );
    return category.name;
  }

  Future<void> _updateLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    // Simular actualización de ubicación
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoadingLocation = false;
      // En producción, aquí obtendrías la ubicación real
    });
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _FilterBottomSheet(
        selectedCategoryId: _selectedCategoryId,
        minRating: _minRating,
        maxDistance: _maxDistance,
        onApply: (categoryId, rating, distance) {
          setState(() {
            _selectedCategoryId = categoryId;
            _minRating = rating;
            _maxDistance = distance;
          });
        },
      ),
    );
  }

  void _showPlaceBottomSheet(Place place) {
    final distance = _getPlaceDistance(place);
    final categoryName = _getCategoryName(place.categoryId);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _PlaceBottomSheet(
        place: place,
        distance: distance,
        categoryName: categoryName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredPlaces = _filteredPlaces;

    return DQScaffoldWidget(
      currentIndex: 1,
      body: Column(
        children: [
          // Header
          _buildHeader(context),

          // Toggle Mapa/Lista
          _buildViewToggle(),

          // Filtros de categoría rápida
          _buildCategoryFilters(),

          // Contenido (Lista o Mapa)
          Expanded(
            child: _selectedViewIndex == 0
                ? _buildPlacesList(filteredPlaces)
                : _buildMapView(filteredPlaces),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        horizontalPadding,
        40,
        horizontalPadding,
        16,
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
                      S.of(context).closeToYou,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Tu ubicación: $_currentLocation',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  // IconButton(
                  //   icon: _isLoadingLocation
                  //       ? const SizedBox(
                  //           width: 20,
                  //           height: 20,
                  //           child: CircularProgressIndicator(
                  //             strokeWidth: 2,
                  //             valueColor: AlwaysStoppedAnimation<Color>(
                  //               Colors.white,
                  //             ),
                  //           ),
                  //         )
                  //       : const Icon(Icons.refresh, color: Colors.white),
                  //   onPressed: _isLoadingLocation ? null : _updateLocation,
                  // ),
                  IconButton(
                    icon: Stack(
                      children: [
                        const Icon(Icons.filter_list, color: Colors.white),
                        // if (_selectedCategoryId != null ||
                        //     _minRating > 0 ||
                        //     _maxDistance < 100)
                        //   Positioned(
                        //     right: 0,
                        //     top: 0,
                        //     child: Container(
                        //       width: 8,
                        //       height: 8,
                        //       decoration: const BoxDecoration(
                        //         color: Colors.red,
                        //         shape: BoxShape.circle,
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                    onPressed: _showFilterDialog,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildViewToggle() {
    return Container(
      margin: const EdgeInsets.all(horizontalPadding),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: AppColors.lightPrimary,
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[700],
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        tabs: const [
          Tab(icon: Icon(Icons.list, size: 30), text: 'Lista'),
          Tab(icon: Icon(Icons.map, size: 30), text: 'Mapa'),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        itemCount: categoriesDummy.length,
        itemBuilder: (context, index) {
          final category = categoriesDummy[index];
          final isSelected = _selectedCategoryId == category.id;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              showCheckmark: false,
              selected: isSelected,
              label: Text(category.name),
              avatar: FaIcon(
                category.icon,
                size: 16,
                color: isSelected ? Colors.white : category.color,
              ),
              selectedColor: AppColors.lightPrimary,
              checkmarkColor: Colors.white,
              onSelected: (selected) {
                setState(() {
                  _selectedCategoryId = selected ? category.id : null;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildPlacesList(List<Place> places) {
    if (places.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No se encontraron lugares cercanos',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Intenta ajustar los filtros',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _updateLocation,
      child: ListView.builder(
        padding: const EdgeInsets.all(horizontalPadding),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          final distance = _getPlaceDistance(place);
          final categoryName = _getCategoryName(place.categoryId);

          return _PlaceCard(
            place: place,
            distance: distance,
            categoryName: categoryName,
            onTap: () => _showPlaceBottomSheet(place),
            onViewMore: () {
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
    );
  }

  Widget _buildMapView(List<Place> places) {
    // Placeholder para el mapa - en producción usarías google_maps_flutter
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.map, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Vista de mapa',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Integra google_maps_flutter para mostrar el mapa',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            '${places.length} lugares encontrados',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.lightPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Tarjeta de lugar
class _PlaceCard extends StatelessWidget {
  final Place place;
  final double distance;
  final String categoryName;
  final VoidCallback onTap;
  final VoidCallback onViewMore;

  const _PlaceCard({
    required this.place,
    required this.distance,
    required this.categoryName,
    required this.onTap,
    required this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    place.photos.first,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            place.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Información
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.category, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        categoryName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${distance.toStringAsFixed(1)} km',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    place.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onViewMore,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.lightPrimary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Ver más'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Bottom Sheet de filtros
class _FilterBottomSheet extends StatefulWidget {
  final int? selectedCategoryId;
  final double minRating;
  final double maxDistance;
  final Function(int?, double, double) onApply;

  const _FilterBottomSheet({
    required this.selectedCategoryId,
    required this.minRating,
    required this.maxDistance,
    required this.onApply,
  });

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  late int? _selectedCategoryId;
  late double _minRating;
  late double _maxDistance;

  @override
  void initState() {
    super.initState();
    _selectedCategoryId = widget.selectedCategoryId;
    _minRating = widget.minRating;
    _maxDistance = widget.maxDistance;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(horizontalPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Filtros',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Categoría
            Text(
              'Categoría',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Todas'),
                  selected: _selectedCategoryId == null,
                  onSelected: (selected) {
                    setState(() {
                      _selectedCategoryId = null;
                    });
                  },
                ),
                ...categoriesDummy.map((category) {
                  return ChoiceChip(
                    label: Text(category.name),
                    selected: _selectedCategoryId == category.id,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategoryId = selected ? category.id : null;
                      });
                    },
                  );
                }),
              ],
            ),

            const SizedBox(height: 24),

            // Rating mínimo
            Text(
              'Valoración mínima: ${_minRating.toStringAsFixed(1)} ⭐',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SliderTheme(
              data: const SliderThemeData(
                valueIndicatorTextStyle: TextStyle(
                  color:
                      Colors.white, // Cambia aquí el color del texto emergente
                  // fontWeight: FontWeight.bold,
                ),
              ),
              child: Slider(
                value: _minRating,
                min: 0,
                max: 5,
                divisions: 10,
                // thumbColor: Colors.white,
                activeColor: AppColors.lightPrimary,
                label: _minRating.toStringAsFixed(1),
                onChanged: (value) {
                  setState(() {
                    _minRating = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 24),

            // Distancia máxima
            Text(
              'Distancia máxima: ${_maxDistance.toStringAsFixed(0)} km',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            SliderTheme(
              data: const SliderThemeData(
                valueIndicatorTextStyle: TextStyle(
                  color:
                      Colors.white, // Cambia aquí el color del texto emergente
                  // fontWeight: FontWeight.bold,
                ),
              ),
              child: Slider(
                value: _maxDistance,
                min: 5,
                max: 200,
                divisions: 39,
                label: '${_maxDistance.toStringAsFixed(0)} km',
                onChanged: (value) {
                  setState(() {
                    _maxDistance = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 24),

            // Botones
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _selectedCategoryId = null;
                        _minRating = 0.0;
                        _maxDistance = 100.0;
                      });
                    },
                    child: const Text('Limpiar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApply(
                        _selectedCategoryId,
                        _minRating,
                        _maxDistance,
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.lightPrimary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Aplicar'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Bottom Sheet de detalles rápidos del lugar
class _PlaceBottomSheet extends StatelessWidget {
  final Place place;
  final double distance;
  final String categoryName;

  const _PlaceBottomSheet({
    required this.place,
    required this.distance,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(horizontalPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Imagen
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              place.photos.first,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          // Nombre y rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  place.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    place.rating.toStringAsFixed(1),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Categoría y distancia
          Row(
            children: [
              Icon(Icons.category, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                categoryName,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
              const SizedBox(width: 16),
              Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                '${distance.toStringAsFixed(1)} km',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Descripción
          Text(
            place.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),

          const SizedBox(height: 20),

          // Botón ver más
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceDetailScreen(place: place),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.lightPrimary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Ver detalles completos'),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
