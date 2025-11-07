import 'package:animations/animations.dart';
import 'package:destino_quisqueya_front/models/category.model.dart';
import 'package:destino_quisqueya_front/models/destiny.model.dart';
import 'package:destino_quisqueya_front/screens/places/placeDetailsScreen/placeDetailScreen.dart';
import 'package:destino_quisqueya_front/utilities/dummyData/places.dart';
import 'package:destino_quisqueya_front/widgets/placeCardGrid.widget.dart';
import 'package:flutter/material.dart';

class PlacesByCategoryScreen extends StatefulWidget {
  const PlacesByCategoryScreen({super.key});

  static const String routeName = '/placesByCategoryScreen';

  @override
  State<PlacesByCategoryScreen> createState() => _PlacesByCategoryScreenState();
}

class _PlacesByCategoryScreenState extends State<PlacesByCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as PlaceCategory;
    List<Place> places = placesDummy
        .where((element) => element.categoryId == arg.id)
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text(arg.name)),
      body: places.isEmpty
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
                    itemCount: places.length,
                    itemBuilder: (BuildContext context, int index) {
                      return OpenContainer(
                        transitionType: ContainerTransitionType.fadeThrough,
                        closedElevation: 0,
                        openElevation: 0,
                        closedColor: Theme.of(context).scaffoldBackgroundColor,
                        transitionDuration: Duration(milliseconds: 500),
                        openBuilder: (context, _) =>
                            PlaceDetailScreen(place: places[index]),
                        closedBuilder: (context, VoidCallback openContainer) =>
                            PlaceCardGridWidget(
                              place: places[index],
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
