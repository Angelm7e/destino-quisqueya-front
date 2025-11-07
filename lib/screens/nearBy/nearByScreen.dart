import 'package:destino_quisqueya_front/widgets/scaffold.widget.dart';
import 'package:flutter/material.dart';

class NearByScreen extends StatefulWidget {
  const NearByScreen({super.key});

  static const String routeName = '/NearByScreen';

  @override
  State<NearByScreen> createState() => _NearByScreenState();
}

class _NearByScreenState extends State<NearByScreen> {
  @override
  Widget build(BuildContext context) {
    return DQScaffoldWidget(
      currentIndex: 1,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Text("Close To You Screen")],
      ),
    );
  }
}
