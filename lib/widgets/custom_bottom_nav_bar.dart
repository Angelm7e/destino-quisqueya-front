import 'package:destino_quisqueya_front/generated/l10n.dart';
import 'package:destino_quisqueya_front/screens/favoriteScreen/favoriteScreem.dart';
import 'package:destino_quisqueya_front/screens/home/homeScreen.dart';
import 'package:destino_quisqueya_front/screens/nearBy/nearByScreen.dart';
import 'package:destino_quisqueya_front/screens/profile/profileScreen.dart';
import 'package:destino_quisqueya_front/utilites/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;
  final VoidCallback onFabPressed;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.onFabPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? AppColors.darkSurface
        : const Color.fromARGB(255, 240, 239, 239);

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: bgColor,
      elevation: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            icon: Icons.home,
            label: S.of(context).home,
            isActive: currentIndex == 0,
            onTap: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
          _buildNavItem(
            context,
            icon: Icons.location_on,
            label: S.of(context).closeToYou,
            isActive: currentIndex == 1,
            onTap: () {
              Navigator.pushNamed(context, NearByScreen.routeName);
            },
          ),
          const SizedBox(width: 48),
          _buildNavItem(
            context,
            icon: Icons.favorite,
            label: S.of(context).favorites,
            isActive: currentIndex == 2,
            onTap: () {
              Navigator.pushNamed(context, FavoriteScreen.routeName);
            },
          ),
          _buildNavItem(
            context,
            icon: Icons.person,
            label: S.of(context).profile,
            isActive: currentIndex == 3,
            onTap: () {
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    Size base = MediaQuery.of(context).size;
    return FittedBox(
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 40,
              color: isActive ? AppColors.lightPrimary : Colors.grey,
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 22,
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(
                    color: isActive ? AppColors.lightPrimary : Colors.grey,
                    fontSize: base.width * 0.45,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
