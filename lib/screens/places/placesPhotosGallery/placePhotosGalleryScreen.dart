

import 'package:destino_quisqueya_front/models/destiny.model.dart';
import 'package:flutter/material.dart';

class PlacePhotosGalleryScreen extends StatelessWidget {
  static const routeName = '/placePhotosGallery';
  final Place? place;

  const PlacePhotosGalleryScreen({super.key, this.place});

  @override
  Widget build(BuildContext context) {
    List<String> photos = place?.photos ?? [];
    return Scaffold(
      appBar: AppBar(title: Text('Fotos de ${place?.name ?? ''}')),
      body: photos.isEmpty
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
                    itemCount: photos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              // title: Text('Foto ${index + 1}'),
                              actionsAlignment: MainAxisAlignment.center,
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_circle_left_sharp,size: 50,),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(Icons.arrow_circle_right_sharp,size: 50,),
                                ),
                              ],
                              content: Image.asset(photos[index],fit: BoxFit.cover,),
                            ),
                          );
                        },
                        child: Image.asset(photos[index],fit: BoxFit.cover,),
                      );
                    },
                  ),
                ),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Regresar'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}

