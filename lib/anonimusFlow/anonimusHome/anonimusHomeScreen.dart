import 'package:animations/animations.dart';
import 'package:destino_quisquella_front/anonimusFlow/mostVisited/mostVisitedScreen.dart';
import 'package:destino_quisquella_front/screens/places/placeDetailsScreen/placeDetailScreen.dart';
import 'package:destino_quisquella_front/screens/places/placesByCategoryScreen/placesByCategoryScreen.dart';
import 'package:destino_quisquella_front/utilites/app_colors.dart';
import 'package:destino_quisquella_front/utilites/dummyData/category.dart';
import 'package:destino_quisquella_front/utilites/dummyData/places.dart';
import 'package:destino_quisquella_front/widgets/categoryIten.widget.dart';
import 'package:destino_quisquella_front/widgets/headerCarousel.widget.dart';
import 'package:destino_quisquella_front/widgets/placesCard.widget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AnonimusHomeScreen extends StatefulWidget {
  const AnonimusHomeScreen({super.key});

  static const String routeName = '/AnonimusHomeScreen';

  @override
  State<AnonimusHomeScreen> createState() => _AnonimusHomeScreenState();
}

class _AnonimusHomeScreenState extends State<AnonimusHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            expandedHeight: 300,
            backgroundColor: AppColors.darkPrimary,
            foregroundColor: Colors.white,
            clipBehavior: Clip.hardEdge,
            leading: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 40),
              onPressed: () {},
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              title: const Text(
                "Destino quisquella",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              background: HeaderCarousel(
                images: placesDummy[2].photos,
                // Si usas assets, cambia isAsset: true
                isAsset: true,
              ),
            ),
          ),
          // SliverAppBar(
          // centerTitle: true,
          // backgroundColor: AppColors.darkPrimary,
          // pinned: true,
          // expandedHeight: 300,
          // // toolbarHeight: 150,
          // // snap: true,
          // // floating: true,
          // leading: Icon(Icons.menu, color: Colors.white, size: 40),
          // // floating: true,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: CarouselSlider(
          //       items: placesDummy[2].photos
          //           .map(
          //             (item) => Expanded(
          //               child: Image.asset(item),
          //               // decoration: BoxDecoration(
          //               //   borderRadius: BorderRadius.circular(10),
          //               //   image: DecorationImage(image: ),
          //               // ),
          //             ),
          //           )
          //           .toList(),
          //       options: CarouselOptions(height: 300, autoPlay: true),
          //     ),
          //     title: Text(
          //       S.of(context).appTitle,
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
          // SliverPersistentHeader(
          //   pinned: true,
          //   delegate: _PinnedHeaderDelegate(
          //     child: Container(
          //       color: Colors.white,
          //       padding: const EdgeInsets.all(16.0),
          //       alignment: Alignment.centerLeft,
          //       child: const Text(
          //         'Encabezado Fijo',
          //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //     height: 60,
          //   ),
          // ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 10),
                  child: Text(
                    "Lo más visitado",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      // color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 210,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: placesDummy.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == placesDummy.length) {
                        return TweenAnimationBuilder<Offset>(
                          duration: const Duration(milliseconds: 500),
                          // empieza fuera de la pantalla a la derecha
                          // termina en su posición normal
                          tween: Tween(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ),
                          curve: Curves.easeOut,
                          builder: (context, offset, child) {
                            return Transform.translate(
                              offset:
                                  offset * MediaQuery.of(context).size.width,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    MostVisitedScreen.routeName,
                                  );
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  // height: 150,
                                  width: 120,
                                  child: Center(
                                    child: Text(
                                      'Ver todos',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }

                      return OpenContainer(
                        closedElevation: 0,
                        openElevation: 0,
                        closedColor: Theme.of(context).scaffoldBackgroundColor,
                        transitionDuration: Duration(milliseconds: 500),
                        openBuilder: (context, _) =>
                            PlaceDetailScreen(place: placesDummy[index]),
                        closedBuilder: (context, VoidCallback openContainer) =>
                            PlaceCardWidget(
                              onTap: () {
                                openContainer();
                              },
                              placeName: placesDummy[index].name,
                              photo: placesDummy[index].photos.first,
                            ),
                      );

                      // Text('Item $index', style: TextStyle(fontSize: 20));
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: CarouselSlider(
              items: placesDummy[2].photos
                  .map(
                    (item) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image: AssetImage(item)),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(height: 250, autoPlay: true),
            ),
          ),

          // SliverList(
          //   delegate: SliverChildBuilderDelegate((context, index) {
          //     return Container(
          //       width: 200,
          //       margin: const EdgeInsets.all(8),
          //       color: Colors.blue[100 * ((index % 8) + 1)],
          //       alignment: Alignment.center,
          //       child: Text(
          //         'Ítem #$index',
          //         style: const TextStyle(fontSize: 20),
          //       ),
          //     );
          //   }, childCount: 10),
          // ),
          // SliverToBoxAdapter(
          //   child:
          //   GridView.builder(
          //     itemCount: categoriesDummy.length,
          //     shrinkWrap: true,
          //     physics: const NeverScrollableScrollPhysics(),
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 3,
          //       mainAxisSpacing: 12,
          //       crossAxisSpacing: 12,
          //       childAspectRatio: .9,
          //     ),
          //     itemBuilder: (context, i) {
          //       final cat = categoriesDummy[i];
          //       return _CategoryItem(
          //         category: cat,
          //         onTap: (cat) {
          //           Navigator.pushNamed(
          //             context,
          //             '/category',
          //             arguments: cat.kind,
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
          SliverAnimatedList(
            // key: const Key('list'),
            // physics: const BouncingScrollPhysics(),
            // shrinkWrap: true,
            itemBuilder: (context, index, animation) {
              return SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                child: ListTile(title: Text('Item $index')),
              );
            },
            initialItemCount: 5,
          ),
          SliverToBoxAdapter(
            child: Text(
              'Scroll down to see more content',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SliverFillRemaining(
            child: SingleChildScrollView(
              // scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 210,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: placesDummy.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PlaceCardWidget(
                          onTap: () {},
                          placeName: placesDummy[index].name,
                          photo: placesDummy[index].photos.first,
                        );

                        // Text('Item $index', style: TextStyle(fontSize: 20));
                      },
                    ),
                  ),
                  Text(
                    "Busca lugares especificos",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      // color: Colors.black,
                    ),
                  ),
                  GridView.builder(
                    itemCount: categoriesDummy.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: .9,
                        ),
                    itemBuilder: (context, i) {
                      final cat = categoriesDummy[i];
                      return CategoryItem(
                        category: cat,
                        onTap: (cat) {
                          Navigator.pushNamed(
                            context,
                            PlacesByCategoryScreen.routeName,
                            arguments: cat,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
//   final Widget child;
//   final double height;
//   _PinnedHeaderDelegate({required this.child, required this.height});
//   @override
//   double get minExtent => height;
//   @override
//   double get maxExtent => height;
//   @override
//   Widget build(
//     BuildContext context,
//     double shrinkOffset,
//     bool overlapsContent,
//   ) {
//     return Material(elevation: overlapsContent ? 4 : 0, child: child);
//   }
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
//       true;
// }

