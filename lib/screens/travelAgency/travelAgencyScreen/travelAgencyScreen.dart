// screens/travel_agency_detail.screen.dart
import 'package:animations/animations.dart';
import 'package:destino_quisquella_front/models/agency.model.dart';
import 'package:destino_quisquella_front/screens/travelAgency/destinationsDetailsScreens/destinationsDetailsScreen.dart';
import 'package:destino_quisquella_front/utilites/app_colors.dart';
import 'package:destino_quisquella_front/utilites/dummyData/travelAgency.dart';
import 'package:destino_quisquella_front/widgets/headerCarousel.widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TravelAgencyDetailScreen extends StatefulWidget {
  const TravelAgencyDetailScreen({super.key, this.agency});
  final TravelAgency? agency;

  static const routeName = '/travelAgencyDetail';

  @override
  State<TravelAgencyDetailScreen> createState() =>
      _TravelAgencyDetailScreenState();
}

class _TravelAgencyDetailScreenState extends State<TravelAgencyDetailScreen>
    with TickerProviderStateMixin {
  late final TravelAgency agency;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    agency = widget.agency ?? demoAgency.first;
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerScrolled) => [
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(agency.name, style: TextStyle(color: Colors.white)),
              pinned: true,
              expandedHeight: 280,
              backgroundColor: AppColors.darkPrimary,
              flexibleSpace: FlexibleSpaceBar(
                background: _AgencyHeroCarousel(agency: agency),
                // HeaderCarousel(
                //   images: agency.photos.map((p) => p.url).toList(),
                // ),
                // _AgencyHeroCarousel(agency: agency),
              ),
              actions: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.phone),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.globe),
                  onPressed: () {},
                ),
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _PinnedHeaderDelegate(
                height: 54,
                child: Material(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: TabBar(
                    // dividerColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: false,
                    indicatorWeight: 3,
                    tabs: const [
                      Tab(icon: FaIcon(FontAwesomeIcons.house), text: 'Home'),
                      Tab(
                        icon: FaIcon(FontAwesomeIcons.images),
                        text: 'Photos',
                      ),
                      Tab(
                        icon: FaIcon(FontAwesomeIcons.locationDot),
                        text: 'Destinations',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: [
              _AgencyHomeTab(agency: agency),
              _AgencyPhotosTab(photos: agency.photos),
              _AgencyDestinationsTab(destinations: agency.destinations),
            ],
          ),
        ),
      ),
    );
  }
}

class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  _PinnedHeaderDelegate({required this.child, required this.height});

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => child;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

class _AgencyHeroCarousel extends StatelessWidget {
  const _AgencyHeroCarousel({required this.agency});
  final TravelAgency agency;

  @override
  Widget build(BuildContext context) {
    // Si ya tienes un carousel hecho, úsalo aquí.
    // Placeholder: PageView simple.
    return PageView.builder(
      itemCount: agency.photos.length,
      itemBuilder: (_, i) => Stack(
        fit: StackFit.expand,
        children: [
          HeaderCarousel(images: agency.photos.map((p) => p.url).toList()),
          Positioned(
            left: 16,
            bottom: 16,
            right: 16,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(agency.logoUrl),
                  radius: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    agency.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                _RatingChip(
                  rating: agency.rating,
                  reviews: agency.reviewsCount,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingChip extends StatelessWidget {
  const _RatingChip({required this.rating, required this.reviews});
  final double rating;
  final int reviews;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.45),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const FaIcon(
            FontAwesomeIcons.solidStar,
            size: 14,
            color: Colors.amber,
          ),
          const SizedBox(width: 6),
          Text('$rating', style: const TextStyle(color: Colors.white)),
          Text(' ($reviews)', style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}

class _AgencyHomeTab extends StatelessWidget {
  const _AgencyHomeTab({required this.agency});
  final TravelAgency agency;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text('About', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(agency.description, style: Theme.of(context).textTheme.bodyMedium),

        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _InfoChip(
              icon: FontAwesomeIcons.solidStar,
              label: '${agency.rating} rating',
            ),
            _InfoChip(
              icon: FontAwesomeIcons.commentDots,
              label: '${agency.reviewsCount} reviews',
            ),
            _InfoChip(
              icon: FontAwesomeIcons.locationDot,
              label: '${agency.city}, ${agency.country}',
            ),
          ],
        ),

        const SizedBox(height: 20),
        _SectionTitle(title: 'Services'),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: agency.services.map((s) => Chip(label: Text(s))).toList(),
        ),

        const SizedBox(height: 20),
        _SectionTitle(title: 'Opening hours'),
        const SizedBox(height: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: agency.openingHours.entries
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e.key),
                      Text(
                        e.value,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),

        const SizedBox(height: 20),
        _SectionTitle(title: 'Contact'),
        const SizedBox(height: 8),
        _ContactTile(
          icon: FontAwesomeIcons.phone,
          label: agency.phone,
          onTap: () async {
            // Future<void> openWhatsApp(String phone) async {
            final Uri uri = Uri.parse("https://wa.me/8296426210");
            if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
              throw Exception("No se pudo abrir WhatsApp");
            }
            // }

            // final Uri phoneUri = Uri(scheme: 'tel', path: agency.phone);
            // if (await canLaunchUrl(phoneUri)) {
            //   await launchUrl(phoneUri);
            // } else {
            //   debugPrint("No se pudo iniciar la llamada");
            // }
          },
        ),
        _ContactTile(
          icon: FontAwesomeIcons.envelope,
          label: agency.email,
          onTap: () async {
            final Uri emailUri = Uri(
              scheme: 'mailto',
              path: agency.email,
              // queryParameters: {
              //   'subject': 'Consulta desde Destino Quisqueya',
              //   'body': 'Hola, me gustaría obtener más información sobre...',
              // },
            );

            if (await canLaunchUrl(emailUri)) {
              await launchUrl(
                emailUri,
                mode: LaunchMode.platformDefault, // 👈 mejor para mailto:
              );
            } else {
              debugPrint("No se pudo abrir el cliente de correo");
            }
          },
        ),
        _ContactTile(
          icon: FontAwesomeIcons.globe,
          label: agency.website,
          onTap: () async {
            final Uri uri = Uri.parse(agency.website);

            if (!await launchUrl(
              uri,
              mode: LaunchMode
                  .externalApplication, // abre en navegador/app externa
            )) {
              // throw Exception('No se pudo abrir $url');
            }
          },
        ),

        const SizedBox(height: 12),
        _SectionTitle(title: 'Social'),
        const SizedBox(height: 8),
        Wrap(
          spacing: MediaQuery.of(context).size.width * 0.10,
          children: [
            InkWell(child: FaIcon(FontAwesomeIcons.instagram)),
            InkWell(child: FaIcon(FontAwesomeIcons.facebook)),
            InkWell(child: FaIcon(FontAwesomeIcons.tiktok)),
            InkWell(child: FaIcon(FontAwesomeIcons.youtube)),
          ],
        ),

        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  // Future<void> openWhatsApp(String phone) async {
                  final Uri uri = Uri.parse("https://wa.me/8296938877");
                  if (!await launchUrl(
                    uri,
                    mode: LaunchMode.externalApplication,
                  )) {
                    throw Exception("No se pudo abrir WhatsApp");
                  }
                  // }
                },
                icon: const FaIcon(FontAwesomeIcons.whatsapp),
                label: const Text('Contact'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.globe),
                label: const Text('Website'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(width: 8),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: FaIcon(icon, size: 14),
      label: Text(label),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}

class _ContactTile extends StatelessWidget {
  const _ContactTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: FaIcon(icon, size: 18),
      title: Text(label),
      contentPadding: EdgeInsets.zero,
      onTap: () {
        onTap();
      },
    );
  }
}

class _AgencyPhotosTab extends StatelessWidget {
  const _AgencyPhotosTab({required this.photos});
  final List<AgencyPhoto> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemCount: photos.length,
      itemBuilder: (_, i) {
        final p = photos[i];
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(p.url, fit: BoxFit.cover),
              if ((p.caption ?? '').isNotEmpty)
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.black45,
                    child: Text(
                      p.caption!,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _AgencyDestinationsTab extends StatefulWidget {
  const _AgencyDestinationsTab({required this.destinations});
  final List<DestinationItem> destinations;

  @override
  State<_AgencyDestinationsTab> createState() => _AgencyDestinationsTabState();
}

class _AgencyDestinationsTabState extends State<_AgencyDestinationsTab> {
  final TextEditingController _searchCtrl = TextEditingController();
  final Set<String> _activeTags = {};

  final List<String> _availableTags = const [
    'Beach',
    'City',
    'Adventure',
    'Culture',
    'Cruise',
    'Family',
    'Romantic',
    'Premium',
    'All-inclusive',
    'Offers',
  ];

  List<DestinationItem> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    return widget.destinations.where((d) {
      final matchesQuery =
          q.isEmpty ||
          d.title.toLowerCase().contains(q) ||
          d.city.toLowerCase().contains(q) ||
          d.country.toLowerCase().contains(q) ||
          d.tags.any((t) => t.toLowerCase().contains(q));
      final matchesTags =
          _activeTags.isEmpty || d.tags.any(_activeTags.contains);
      return matchesQuery && matchesTags;
    }).toList()..sort((a, b) {
      // Ejemplo: featured primero, luego rating desc
      if (a.featured != b.featured) return b.featured ? 1 : -1;
      return b.rating.compareTo(a.rating);
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            controller: _searchCtrl,
            decoration: InputDecoration(
              hintText: 'Search destinations, city, tags...',
              prefixIcon: const FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                // size: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              isDense: true,
            ),
            onChanged: (_) => setState(() {}),
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            scrollDirection: Axis.horizontal,
            itemCount: _availableTags.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) {
              final tag = _availableTags[i];
              final selected = _activeTags.contains(tag);
              return FilterChip(
                label: Text(tag),
                selected: selected,
                onSelected: (val) {
                  setState(() {
                    if (val) {
                      _activeTags.add(tag);
                    } else {
                      _activeTags.remove(tag);
                    }
                  });
                },
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            itemCount: items.length,
            itemBuilder: (_, i) {
              return OpenContainer(
                closedElevation: 0,
                openElevation: 0,
                closedColor: Theme.of(context).scaffoldBackgroundColor,
                transitionDuration: Duration(milliseconds: 500),
                openBuilder: (context, _) =>
                    DestinationDetailScreen(item: items[i]),
                closedBuilder: (context, VoidCallback openContainer) =>
                    DestinationCard(
                      item: items[i],
                      onTap: () {
                        openContainer();
                      },
                    ),
              );

              // DestinationCard(item: items[i]);
            },
            // _DestinationCard(item: items[i]),
          ),
        ),
      ],
    );
  }
}

class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key, required this.item, required this.onTap});
  final DestinationItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(item.thumbnailUrl, fit: BoxFit.cover),
                  if (item.featured)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: const [
                            FaIcon(
                              FontAwesomeIcons.fire,
                              size: 12,
                              color: Colors.orangeAccent,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Featured',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.locationDot, size: 14),
                      const SizedBox(width: 6),
                      Text('${item.city}, ${item.country}'),
                      const Spacer(),
                      const FaIcon(
                        FontAwesomeIcons.solidStar,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(item.rating.toStringAsFixed(1)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: item.tags
                        .map(
                          (t) => Chip(
                            label: Text(t),
                            visualDensity: VisualDensity.compact,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$${item.priceFrom.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 6),
                      const Text('from'),
                      const Spacer(),
                      const FaIcon(FontAwesomeIcons.clock, size: 14),
                      const SizedBox(width: 6),
                      Text('${item.days} days'),
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
