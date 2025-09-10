// screens/destination_detail.screen.dart
import 'package:destino_quisquella_front/models/agency.model.dart';
import 'package:destino_quisquella_front/models/destinationDetail.model.dart';
import 'package:destino_quisquella_front/utilites/app_colors.dart';
import 'package:destino_quisquella_front/utilites/dummyData/destinations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DestinationDetailScreen extends StatefulWidget {
  const DestinationDetailScreen({super.key, required this.item});
  static const String routeName = '/destinationDetail';

  final DestinationItem item;

  @override
  State<DestinationDetailScreen> createState() =>
      _DestinationDetailScreenState();
}

class _DestinationDetailScreenState extends State<DestinationDetailScreen>
    with TickerProviderStateMixin {
  late final DestinationDetail detail = destinationDetails.firstWhere(
    (d) => d.destinationId == widget.item.id,
    orElse: () => DestinationDetail(
      destinationId: widget.item.id,
      description: 'No detail available yet.',
      highlights: [],
      inclusions: [],
      exclusions: [],
      itinerary: [],
      gallery: [widget.item.thumbnailUrl],
      faqs: [],
      reviews: [],
    ),
  );
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      vsync: this,
    ); // Overview, Itinerary, Photos, Reviews
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, _) => [
              SliverAppBar(
                iconTheme: IconThemeData(color: Colors.white),
                pinned: true,
                backgroundColor: AppColors.darkPrimary,
                expandedHeight: 300,
                title: Text(item.title, style: TextStyle(color: Colors.white)),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.shareNodes),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(FontAwesomeIcons.heart),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: _HeaderGallery(
                    item: item,
                    images: detail.gallery,
                    featured: item.featured,
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _PinnedHeaderDelegate(
                  height: 54,
                  child: Material(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: TabBar(
                      controller: _tabController,
                      indicatorWeight: 3,
                      tabs: const [
                        Tab(
                          icon: FaIcon(FontAwesomeIcons.circleInfo),
                          text: 'Overview',
                        ),
                        Tab(
                          icon: FaIcon(FontAwesomeIcons.route),
                          text: 'Itinerary',
                        ),
                        Tab(
                          icon: FaIcon(FontAwesomeIcons.images),
                          text: 'Photos',
                        ),
                        Tab(
                          icon: FaIcon(FontAwesomeIcons.solidStar),
                          text: 'Reviews',
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
                _OverviewTab(item: item, detail: detail),
                _ItineraryTab(detail: detail),
                _PhotosTab(images: detail.gallery),
                _ReviewsTab(reviews: detail.reviews),
              ],
            ),
          ),
          Positioned(left: 0, right: 0, bottom: 0, child: _BookBar(item: item)),
        ],
      ),

      // bottomNavigationBar: _BookBar(item: item),
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

class _HeaderGallery extends StatefulWidget {
  const _HeaderGallery({
    required this.item,
    required this.images,
    this.featured = false,
  });
  final DestinationItem item;
  final List<String> images;
  final bool featured;

  @override
  State<_HeaderGallery> createState() => _HeaderGalleryState();
}

class _HeaderGalleryState extends State<_HeaderGallery> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          itemCount: widget.images.length,
          onPageChanged: (i) => setState(() => _index = i),
          itemBuilder: (_, i) =>
              Image.asset(widget.images[i], fit: BoxFit.cover),
        ),
        const _TopGradient(),
        Positioned(
          left: 16,
          right: 16,
          bottom: 16,
          child: Row(
            children: [
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.locationDot,
                    color: Colors.white,
                    size: 14,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${widget.item.city}, ${widget.item.country}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.solidStar,
                      color: Colors.amber,
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.item.rating.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (widget.featured)
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                  Text('Featured', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
              (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: i == _index ? Colors.white : Colors.white38,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _TopGradient extends StatelessWidget {
  const _TopGradient();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black54, Colors.transparent],
        ),
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  const _OverviewTab({required this.item, required this.detail});
  final DestinationItem item;
  final DestinationDetail detail;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            Text(
              '\$${item.priceFrom.toStringAsFixed(0)}',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            const Text('from'),
            const Spacer(),
            const FaIcon(FontAwesomeIcons.clock, size: 14),
            const SizedBox(width: 6),
            Text('${item.days} days'),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: item.tags.map((t) => Chip(label: Text(t))).toList(),
        ),
        const SizedBox(height: 16),
        Text('About', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        Text(detail.description),
        if (detail.highlights.isNotEmpty) ...[
          const SizedBox(height: 16),
          _SectionDivider(title: 'Highlights'),
          const SizedBox(height: 8),
          ...detail.highlights.map(
            (h) => _BulletRow(icon: FontAwesomeIcons.circleCheck, text: h),
          ),
        ],
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _CardList(
                title: 'Included',
                icon: FontAwesomeIcons.circleCheck,
                items: detail.inclusions,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _CardList(
                title: 'Not included',
                icon: FontAwesomeIcons.circleXmark,
                items: detail.exclusions,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.whatsapp),
                label: const Text('Chat now'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const FaIcon(FontAwesomeIcons.circleInfo),
                label: const Text('Ask a question'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.title});
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

class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaIcon(icon, size: 14),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _CardList extends StatelessWidget {
  const _CardList({
    required this.title,
    required this.icon,
    required this.items,
  });
  final String title;
  final IconData icon;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FaIcon(icon, size: 16),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 8),
            if (items.isEmpty) const Text('—'),
            ...items.map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('•  '),
                    Expanded(child: Text(e)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ItineraryTab extends StatelessWidget {
  const _ItineraryTab({required this.detail});
  final DestinationDetail detail;

  @override
  Widget build(BuildContext context) {
    if (detail.itinerary.isEmpty) {
      return const Center(child: Text('No itinerary available.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: detail.itinerary.length,
      itemBuilder: (_, i) {
        final day = detail.itinerary[i];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 12),
            childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            leading: CircleAvatar(radius: 16, child: Text('${day.day}')),
            title: Text(day.title),
            subtitle: const Text('Tap to expand'),
            children: [Text(day.description)],
          ),
        );
      },
    );
  }
}

class _PhotosTab extends StatelessWidget {
  const _PhotosTab({required this.images});
  final List<String> images;

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
      itemCount: images.length,
      itemBuilder: (_, i) => ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(images[i], fit: BoxFit.cover),
      ),
    );
  }
}

class _ReviewsTab extends StatelessWidget {
  const _ReviewsTab({required this.reviews});
  final List<ReviewItem> reviews;

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) return const Center(child: Text('No reviews yet.'));
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: reviews.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        final r = reviews[i];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: CircleAvatar(child: Text(r.userName.characters.first)),
            title: Row(
              children: [
                Expanded(child: Text(r.userName)),
                const SizedBox(width: 8),
                const FaIcon(
                  FontAwesomeIcons.solidStar,
                  size: 12,
                  color: Colors.amber,
                ),
                const SizedBox(width: 4),
                Text(r.rating.toStringAsFixed(1)),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(r.comment),
            ),
            trailing: Text(
              '${r.date.year}-${r.date.month.toString().padLeft(2, '0')}-${r.date.day.toString().padLeft(2, '0')}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        );
      },
    );
  }
}

class _BookBar extends StatelessWidget {
  const _BookBar({required this.item});
  final DestinationItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\$${item.priceFrom.toStringAsFixed(0)}',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text('per package', style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.calendarCheck),
            label: const Text('Book now'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
