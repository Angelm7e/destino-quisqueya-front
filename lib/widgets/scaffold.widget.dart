import 'package:destino_quisqueya_front/generated/l10n.dart';
import 'package:destino_quisqueya_front/screens/addPlacesScreen/addPlacesScreen.dart';
import 'package:destino_quisqueya_front/screens/auth/login/loginScreen.dart';
import 'package:destino_quisqueya_front/screens/favoriteScreen/favoriteScreem.dart';
import 'package:destino_quisqueya_front/screens/home/homeScreen.dart';
import 'package:destino_quisqueya_front/screens/itineraries/itinerariesScreen.dart';
import 'package:destino_quisqueya_front/screens/nearBy/nearByScreen.dart';
import 'package:destino_quisqueya_front/screens/profile/profileScreen.dart';
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
      resizeToAvoidBottomInset: false,
      drawer: const AppDrawer(),
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

// Drawer personalizado de la aplicación
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Obtener nombre del usuario desde el provider/auth
    final userName = 'Usuario';
    final userEmail = 'usuario@example.com';

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.lightPrimary,
                  AppColors.lightPrimary.withOpacity(0.8),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Text(
                    userName[0].toUpperCase(),
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.lightPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  userName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.lightPrimary),
            title: Text(S.of(context).home),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, HomeScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.location_on,
              color: AppColors.lightPrimary,
            ),
            title: Text(S.of(context).closeToYou),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, NearByScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite, color: AppColors.lightPrimary),
            title: Text(S.of(context).favorites),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, FavoriteScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.view_list_rounded,
              color: AppColors.lightPrimary,
            ),
            title: Text(S.of(context).myReviews),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ItinerariesScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person, color: AppColors.lightPrimary),
            title: Text(S.of(context).profile),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ProfileScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: AppColors.lightPrimary),
            title: Text(S.of(context).settings),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navegar a pantalla de configuraciones
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.darkSecondary),
            title: Text(
              S.of(context).logout,
              style: const TextStyle(color: AppColors.darkSecondary),
            ),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: Text(S.of(context).logoutConfirmation),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: Text(S.of(context).cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginScreen.routeName,
                            (route) => false,
                          );
                        },
                        child: Text(
                          S.of(context).confirm,
                          style: const TextStyle(
                            color: AppColors.darkSecondary,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
