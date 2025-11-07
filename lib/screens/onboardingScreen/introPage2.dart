import 'package:destino_quisqueya_front/generated/l10n.dart';
import 'package:flutter/material.dart';

class Intropage2 extends StatelessWidget {
  const Intropage2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      left: false,
      right: false,
      bottom: false,
      child: Column(
        children: [
          Image.asset("assets/landing/image2.png"),
          SizedBox(height: 20),
          Text(
            S.of(context).explore,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            S.of(context).exploreSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
