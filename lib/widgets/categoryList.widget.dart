import 'package:destino_quisqueya_front/screens/places/placesByCategoryScreen/placesByCategoryScreen.dart';
import 'package:destino_quisqueya_front/utilities/dummyData/category.dart';
import 'package:destino_quisqueya_front/widgets/categoryIten.widget.dart';
import 'package:flutter/material.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}
