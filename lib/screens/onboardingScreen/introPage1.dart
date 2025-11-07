import 'package:destino_quisqueya_front/generated/l10n.dart';
import 'package:flutter/material.dart';

class Intropage1 extends StatelessWidget {
  const Intropage1({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      left: false,
      right: false,
      bottom: false,
      child: Column(
        children: [
          Image.asset("assets/landing/image1.png"),
          Text(
            S.of(context).discoverConectEnjoy,
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            S.of(context).discoverSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
