import 'package:animations/animations.dart';
import 'package:destino_quisqueya_front/anonimusFlow/mostVisited/mostVisitedScreen.dart';
import 'package:destino_quisqueya_front/screens/places/placeDetailsScreen/placeDetailScreen.dart';
import 'package:destino_quisqueya_front/screens/travelAgency/travelAgencyScreen/travelAgencyScreen.dart';
import 'package:destino_quisqueya_front/utilities/const/app_colors.dart';
import 'package:destino_quisqueya_front/utilities/dummyData/places.dart';
import 'package:destino_quisqueya_front/utilities/dummyData/travelAgency.dart';
import 'package:destino_quisqueya_front/widgets/categoryList.widget.dart';
import 'package:destino_quisqueya_front/widgets/headerCarousel.widget.dart';
import 'package:destino_quisqueya_front/widgets/placesCard.widget.dart';
import 'package:flutter/material.dart';

class AnonimusHomeScreen extends StatefulWidget {
  const AnonimusHomeScreen({super.key});

  static const String routeName = '/AnonimusHomeScreen';

  @override
  State<AnonimusHomeScreen> createState() => _AnonimusHomeScreenState();
}

class _AnonimusHomeScreenState extends State<AnonimusHomeScreen> {
  int initialItenCount = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                "Destino Quisqueya",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.place),
              title: const Text('Categorías'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.hotel),
              title: const Text('Agencias'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: const Text('Favoritos'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Ajustes'),
              onTap: () {},
            ),
          ],
        ),
      ),

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
                isAsset: true,
              ),
            ),
          ),

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
                    itemCount:
                        placesDummy.length + (placesDummy.length > 3 ? 1 : 0),
                    itemBuilder: (BuildContext context, int index) {
                      if (placesDummy.length > 3 &&
                          index == placesDummy.length) {
                        return TweenAnimationBuilder<Offset>(
                          duration: const Duration(milliseconds: 500),
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
                    itemCount:
                        demoAgency.length + (demoAgency.length > 3 ? 1 : 0),
                    itemBuilder: (BuildContext context, int index) {
                      if (demoAgency.length > 3 && index == demoAgency.length) {
                        return TweenAnimationBuilder<Offset>(
                          duration: const Duration(milliseconds: 500),
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
                            TravelAgencyDetailScreen(agency: demoAgency[index]),
                        closedBuilder: (context, VoidCallback openContainer) =>
                            PlaceCardWidget(
                              onTap: () {
                                openContainer();
                              },
                              placeName: demoAgency[index].name,
                              photo: demoAgency[index].photos[index].url,
                            ),
                      );

                      // Text('Item $index', style: TextStyle(fontSize: 20));
                    },
                  ),
                ),
              ],
            ),
          ),
          //Bottom
          SliverToBoxAdapter(child: CategoryListWidget()),
        ],
      ),
    );
  }
}
