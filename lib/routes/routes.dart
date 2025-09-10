import 'package:destino_quisquella_front/anonimusFlow/anonimusHome/anonimusHomeScreen.dart';
import 'package:destino_quisquella_front/anonimusFlow/mostVisited/mostVisitedScreen.dart';
import 'package:destino_quisquella_front/screens/addPlacesScreen/addPlacesScreen.dart';
import 'package:destino_quisquella_front/screens/auth/login/loginScreen.dart';
import 'package:destino_quisquella_front/screens/auth/signUp/signUpScreenScreen.dart';
import 'package:destino_quisquella_front/screens/favoriteScreen/favoriteScreem.dart';
import 'package:destino_quisquella_front/screens/home/homeScreen.dart';
import 'package:destino_quisquella_front/screens/itineraries/itinerariesScreen.dart';
import 'package:destino_quisquella_front/screens/nearBy/nearByScreen.dart';
import 'package:destino_quisquella_front/screens/places/placesByCategoryScreen/placesByCategoryScreen.dart';
import 'package:destino_quisquella_front/screens/profile/profileScreen.dart';
import 'package:destino_quisquella_front/screens/travelAgency/destinationsDetailsScreens/destinationsDetailsScreen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  NearByScreen.routeName: (context) => const NearByScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  FavoriteScreen.routeName: (context) => const FavoriteScreen(),
  AddPlacesScreen.routeName: (context) => const AddPlacesScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  ItinerariesScreen.routeName: (context) => const ItinerariesScreen(),
  PlacesByCategoryScreen.routeName: (context) => const PlacesByCategoryScreen(),
  MostVisitedScreen.routeName: (context) => const MostVisitedScreen(),
  // DestinationDetailScreen.routeName: (context) => const DestinationDetailScreen(),

  // Anonimus Screens
  AnonimusHomeScreen.routeName: (context) => const AnonimusHomeScreen(),
};
