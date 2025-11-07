import 'package:destino_quisqueya_front/screens/addPlacesScreen/addPlacesScreen.dart';
import 'package:destino_quisqueya_front/utilities/const/app_colors.dart';
import 'package:destino_quisqueya_front/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class DQScaffoldWidget extends StatefulWidget {
  const DQScaffoldWidget({
    super.key,
    required this.currentIndex,
    required this.body,
  });
  final int currentIndex;
  final Widget body;

  @override
  State<DQScaffoldWidget> createState() => _DQScaffoldWidgetState();
}

class _DQScaffoldWidgetState extends State<DQScaffoldWidget> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTabSelected: (index) => setState(() => _currentIndex = index),
        onFabPressed: () {},
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          Navigator.pushNamed(context, AddPlacesScreen.routeName);
        },
        backgroundColor: AppColors.lightPrimary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
