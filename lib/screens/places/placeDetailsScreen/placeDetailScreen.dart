import 'package:destino_quisquella_front/models/destiny.model.dart';
import 'package:destino_quisquella_front/utilites/app_colors.dart';
import 'package:destino_quisquella_front/widgets/headerCarousel.widget.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatefulWidget {
  const PlaceDetailScreen({super.key, required this.place});
  final Place place;
  static const String routeName = '/placeDetailScreen';

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // final arg = ModalRoute.of(context)!.settings.arguments as Place;

    final place = widget.place;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: AppColors.darkPrimary,
            pinned: true,
            // title: Text(arg.name, style: TextStyle(color: Colors.white)),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(place.name, style: TextStyle(color: Colors.white)),
              background: HeaderCarousel(images: place.photos, isAsset: true),
            ),
          ),
          SliverToBoxAdapter(child: Container()),

          SliverFillRemaining(),
          // SliverFillRemaining(
          //   child: SingleChildScrollView(
          //     // scrollDirection: Axis.horizontal,
          //     physics: NeverScrollableScrollPhysics(),
          //     child: Column(
          //       children: [
          //         SizedBox(
          //           height: 210,
          //           width: double.infinity,
          //           child: ListView.builder(
          //             scrollDirection: Axis.horizontal,
          //             itemCount: placesDummy.length,
          //             itemBuilder: (BuildContext context, int index) {
          //               return PlaceCardWidget(
          //                 onTap: () {},
          //                 placeName: placesDummy[index].name,
          //                 photo: placesDummy[index].photos.first,
          //               );

          //               // Text('Item $index', style: TextStyle(fontSize: 20));
          //             },
          //           ),
          //         ),
          //         Text(
          //           "Busca lugares especificos",
          //           style: TextStyle(
          //             fontSize: 25,
          //             fontWeight: FontWeight.bold,
          //             // color: Colors.black,
          //           ),
          //         ),
          //         GridView.builder(
          //           itemCount: categoriesDummy.length,
          //           shrinkWrap: true,
          //           physics: const NeverScrollableScrollPhysics(),
          //           padding: const EdgeInsets.symmetric(
          //             horizontal: 16,
          //             vertical: 8,
          //           ),
          //           gridDelegate:
          //               const SliverGridDelegateWithFixedCrossAxisCount(
          //                 crossAxisCount: 3,
          //                 mainAxisSpacing: 12,
          //                 crossAxisSpacing: 12,
          //                 childAspectRatio: .9,
          //               ),
          //           itemBuilder: (context, i) {
          //             final cat = categoriesDummy[i];
          //             return CategoryItem(
          //               category: cat,
          //               onTap: (cat) {
          //                 Navigator.pushNamed(
          //                   context,
          //                   PlacesByCategoryScreen.routeName,
          //                   arguments: cat,
          //                 );
          //               },
          //             );
          //           },
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
