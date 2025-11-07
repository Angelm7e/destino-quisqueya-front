import 'package:destino_quisqueya_front/widgets/scaffold.widget.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  static const String routeName = '/favoriteScreen';

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return DQScaffoldWidget(
      currentIndex: 2,
      body: Column(children: [Text("Favorite Screen")]),
    );
  }
}
