import 'package:destino_quisqueya_front/widgets/scaffold.widget.dart';
import 'package:flutter/material.dart';

class AddPlacesScreen extends StatefulWidget {
  const AddPlacesScreen({super.key});

  static const String routeName = '/addPlacesScreen';

  @override
  State<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends State<AddPlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return DQScaffoldWidget(
      currentIndex: 5,
      body: Column(children: [Text("Add Places Screen")]),
    );
  }
}
