import 'package:destino_quisqueya_front/models/itinerary.model.dart';
import 'package:destino_quisqueya_front/screens/itineraries/itineraryDetailScreen.dart';
import 'package:destino_quisqueya_front/screens/itineraries/itineraryFormScreen.dart';
import 'package:destino_quisqueya_front/utilities/const/app_colors.dart';
import 'package:destino_quisqueya_front/utilities/const/constants.dart';
import 'package:destino_quisqueya_front/utilities/dummyData/itineraries.dart';
import 'package:destino_quisqueya_front/widgets/scaffold.widget.dart';
import 'package:destino_quisqueya_front/widgets/searchBar.widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItinerariesScreen extends StatefulWidget {
  const ItinerariesScreen({super.key});

  static const String routeName = '/itinerariesScreen';

  @override
  State<ItinerariesScreen> createState() => _ItinerariesScreenState();
}

class _ItinerariesScreenState extends State<ItinerariesScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Obtener itinerarios propios
  List<Itinerary> get _myItineraries {
    var itineraries = itinerariesDummy.where((it) => !it.isShared).toList();

    if (_searchQuery.isNotEmpty) {
      itineraries = itineraries
          .where(
            (it) =>
                it.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                it.description.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    // Ordenar por fecha de inicio (próximos primero)
    itineraries.sort((a, b) => a.startDate.compareTo(b.startDate));

    return itineraries;
  }

  // Obtener itinerarios compartidos
  List<Itinerary> get _sharedItineraries {
    var itineraries = itinerariesDummy.where((it) => it.isShared).toList();

    if (_searchQuery.isNotEmpty) {
      itineraries = itineraries
          .where(
            (it) =>
                it.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                it.description.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return itineraries;
  }

  void _createNewItinerary() {
    Navigator.pushNamed(context, ItineraryFormScreen.routeName);
  }

  void _viewItineraryDetails(Itinerary itinerary) {
    Navigator.pushNamed(
      context,
      ItineraryDetailScreen.routeName,
      arguments: itinerary,
    );
  }

  @override
  Widget build(BuildContext context) {
    final myItineraries = _myItineraries;
    final sharedItineraries = _sharedItineraries;

    return DQScaffoldWidget(
      currentIndex: 3,
      body: Column(
        children: [
          // Header
          _buildHeader(context),

          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SearchBarWidget(
              hintText: 'Buscar itinerario...',
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Contenido
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                setState(() {});
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sección: Mis Itinerarios
                    if (myItineraries.isNotEmpty) ...[
                      _buildSectionHeader(
                        context,
                        icon: Icons.calendar_today,
                        title: 'Ver próximos viajes',
                      ),
                      const SizedBox(height: 12),
                      ...myItineraries.map(
                        (itinerary) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                            vertical: 6,
                          ),
                          child: ItineraryCard(
                            itinerary: itinerary,
                            onTap: () => _viewItineraryDetails(itinerary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Sección: Compartidos contigo
                    if (sharedItineraries.isNotEmpty) ...[
                      _buildSectionHeader(
                        context,
                        icon: Icons.people,
                        title: 'Compartidos contigo',
                      ),
                      const SizedBox(height: 12),
                      ...sharedItineraries.map(
                        (itinerary) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                            vertical: 6,
                          ),
                          child: ItineraryCard(
                            itinerary: itinerary,
                            onTap: () => _viewItineraryDetails(itinerary),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Estado vacío
                    if (myItineraries.isEmpty && sharedItineraries.isEmpty)
                      _buildEmptyState(),
                  ],
                ),
              ),
            ),
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
                    Row(
                      children: [
                        Text(
                          'Mis Itinerarios',
                          style: Theme.of(context).textTheme.displayLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(width: 8),
                        const Text('✈️', style: TextStyle(fontSize: 28)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_myItineraries.length} itinerarios creados',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: _createNewItinerary,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: [
          Icon(icon, color: AppColors.lightPrimary, size: 24),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.all(horizontalPadding),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Icon(Icons.flight_takeoff, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 24),
            Text(
              'No tienes itinerarios',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No se encontraron itinerarios con tu búsqueda'
                  : 'Crea tu primer itinerario y planifica tu próximo viaje',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
              textAlign: TextAlign.center,
            ),
            if (_searchQuery.isEmpty) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _createNewItinerary,
                icon: const Icon(Icons.add),
                label: const Text('Crear itinerario'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.lightPrimary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Widget de tarjeta de itinerario
class ItineraryCard extends StatelessWidget {
  final Itinerary itinerary;
  final VoidCallback onTap;

  const ItineraryCard({
    super.key,
    required this.itinerary,
    required this.onTap,
  });

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy', 'es').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de portada
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    itinerary.coverImage,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Badge de compartido
                  if (itinerary.isShared)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.people,
                              size: 14,
                              color: AppColors.lightPrimary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Compartido',
                              style: TextStyle(
                                color: AppColors.lightPrimary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre del itinerario
                  Text(
                    itinerary.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Información del autor si es compartido
                  if (itinerary.isShared && itinerary.sharedBy != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(Icons.person, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            'Por ${itinerary.sharedBy}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic,
                                ),
                          ),
                        ],
                      ),
                    ),

                  // Descripción
                  Text(
                    itinerary.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),

                  // Información adicional
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${itinerary.places.length} lugares',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ),
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${itinerary.durationInDays} días',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Fechas
                  Row(
                    children: [
                      Icon(
                        Icons.event,
                        size: 16,
                        color: AppColors.lightPrimary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${_formatDate(itinerary.startDate)} - ${_formatDate(itinerary.endDate)}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.lightPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
