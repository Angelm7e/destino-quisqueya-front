import 'package:animations/animations.dart';
import 'package:destino_quisquella_front/screens/places/placeDetailsScreen/placeDetailScreen.dart';
import 'package:destino_quisquella_front/screens/places/placesByCategoryScreen/placesByCategoryScreen.dart';
import 'package:destino_quisquella_front/utilites/dummyData/places.dart';
import 'package:destino_quisquella_front/widgets/placeCardGrid.widget.dart';
import 'package:flutter/material.dart';

class MostVisitedScreen extends StatelessWidget {
  const MostVisitedScreen({super.key});

  static const String routeName = '/mostVisitedScreen';

  @override
  Widget build(BuildContext context) {
    // List<Place> places = placesDummy
    //     .where((element) => element.categoryId == arg.id)
    //     .toList();
    return Scaffold(
      appBar: AppBar(title: Text("Mas visitados")),
      body: placesDummy.isEmpty
          ? const Center(
              child: Text('No places found', style: TextStyle(fontSize: 25)),
            )
          : Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                    itemCount: placesDummy.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OpenContainer(
                        transitionType: ContainerTransitionType.fadeThrough,
                        closedElevation: 0,
                        openElevation: 0,
                        closedColor: Theme.of(context).scaffoldBackgroundColor,
                        transitionDuration: Duration(milliseconds: 500),
                        openBuilder: (context, _) =>
                            PlaceDetailScreen(place: placesDummy[index]),
                        closedBuilder: (context, VoidCallback openContainer) =>
                            PlaceCardGridWidget(
                              place: placesDummy[index],
                              onTap: () {
                                openContainer();
                              },
                            ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
