import 'package:destino_quisquella_front/models/destiny.model.dart';
import 'package:flutter/material.dart';

class PlaceCardGridWidget extends StatelessWidget {
  const PlaceCardGridWidget({
    super.key,
    required this.place,
    required this.onTap,
  });

  final Place place;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            SizedBox(
              width: 180,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(11),
                ),
                child: Image.asset(
                  place.photos.first,
                  height: 120,
                  // width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // const SizedBox(height: 10),
            Container(
              height: 50,
              width: 180,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(11),
                  bottomRight: Radius.circular(11),
                ),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  place.name,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
