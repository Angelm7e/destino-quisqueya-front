import 'package:destino_quisqueya_front/models/destiny.model.dart';
import 'package:destino_quisqueya_front/utilities/const/app_colors.dart';
import 'package:destino_quisqueya_front/widgets/headerCarousel.widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/categoryDetail';
  final Place place;

  const PlaceDetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    Future<void> openMap(double? latitude, double? longitude) async {
      final Uri url = Uri.parse(
        "geo:$latitude,$longitude?q=$latitude,$longitude",
      );

      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //SliverAppBar con carrusel
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: AppColors.darkPrimary,
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(place.name, style: TextStyle(color: Colors.white)),
              background: HeaderCarousel(images: place.photos, isAsset: true),
            ),
          ),

          //TODO: will use this in future versions
          // Positioned(
          //       top: 40,
          //       right: 16,
          //       child: CircleAvatar(
          //         backgroundColor: Colors.black45,
          //         child: IconButton(
          //           icon: const Icon(
          //             Icons.favorite_border,
          //             color: Colors.white,
          //           ),
          //           onPressed: () {},
          //         ),
          //       ),
          //     ),

          //Info principal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          place.name,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 4),
                          Text(place.rating.toString()),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${place.province}, ${place.country}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),

          // 🔹 Descripción
          SliverToBoxAdapter(
            child: SectionCard(
              title: 'Descripción',
              child: Text(
                place.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),

          // 🔹 Galería
          SliverToBoxAdapter(
            child: SectionCard(
              title: 'Galería de fotos',
              child: SizedBox(
                height: 90,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: place.photos.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) => ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      place.photos[i],
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // 🔹 Ubicación
          SliverToBoxAdapter(
            child: SectionCard(
              title: 'Ubicación',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Mini mapa (puede ser una imagen por ahora o Google Maps widget después)
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[200],
                    ),
                    child: const Center(
                      child: Icon(Icons.map, size: 60, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${place.name}, ${place.province}, ${place.country}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => openMap(
                        place.location.latitude,
                        place.location.longitude,
                      ),
                      icon: const Icon(Icons.navigation),
                      label: const Text('Llévame'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 🔹 Información útil
          SliverToBoxAdapter(
            child: SectionCard(
              title: 'Información útil',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(icon: Icons.map, text: place.info.howToGet),
                  if (place.info.recommendedHours != null)
                    InfoRow(
                      icon: Icons.access_time,
                      text: place.info.recommendedHours!,
                    ),
                  if (place.info.entryFee != null)
                    InfoRow(
                      icon: Icons.monetization_on,
                      text: place.info.entryFee!,
                    ),
                  if (place.info.services.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: place.info.services
                          .map(
                            (s) => Chip(
                              avatar: const Icon(Icons.check, size: 16),
                              label: Text(s.name),
                            ),
                          )
                          .toList(),
                    ),
                ],
              ),
            ),
          ),

          // TODO: uncoment this for future versions
          // 🔹 Opiniones
          // SliverToBoxAdapter(
          //   child: _SectionCard(
          //     title: 'Opiniones de viajeros',
          //     child: Column(
          //       children: [
          //         for (final r in place.reviews.take(2))
          //           ListTile(
          //             leading: const Icon(Icons.person),
          //             title: Text(r.authorName),
          //             subtitle: Text(r.comment),
          //             trailing: Row(
          //               mainAxisSize: MainAxisSize.min,
          //               children: List.generate(
          //                 r.rating.round(),
          //                 (i) => const Icon(
          //                   Icons.star,
          //                   size: 16,
          //                   color: Colors.amber,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         Align(
          //           alignment: Alignment.centerRight,
          //           child: TextButton(
          //             onPressed: () {},
          //             child: const Text('Ver más opiniones'),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(child: SizedBox(height: 20)),
          // TODO: uncoment this for future versions
          // 🔹 Botones finales
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         _ActionButton(
          //           icon: FontAwesomeIcons.shareNodes,
          //           label: 'Compartir',
          //         ),
          //         _ActionButton(icon: FontAwesomeIcons.heart, label: 'Guardar'),
          //         _ActionButton(
          //           icon: FontAwesomeIcons.mapLocation,
          //           label: 'Ver en mapa',
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// 🔸 Componentes reutilizables

class SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const SectionCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActionButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Theme.of(
            context,
          ).colorScheme.primary.withOpacity(.1),
          child: FaIcon(icon, color: Theme.of(context).colorScheme.primary),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
