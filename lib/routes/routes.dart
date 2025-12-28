import 'package:destino_quisqueya_front/anonimusFlow/anonimusHome/anonimusHomeScreen.dart';
import 'package:destino_quisqueya_front/anonimusFlow/mostVisited/mostVisitedScreen.dart';
import 'package:destino_quisqueya_front/screens/addPlacesScreen/addPlacesScreen.dart';
import 'package:destino_quisqueya_front/screens/auth/forGotEmail/forgotEmailScreen.dart';
import 'package:destino_quisqueya_front/screens/auth/forgotPassword/forgotPasswordScreen.dart';
import 'package:destino_quisqueya_front/screens/auth/login/loginScreen.dart';
import 'package:destino_quisqueya_front/screens/auth/signUp/flagTest.dart';
import 'package:destino_quisqueya_front/screens/auth/signUp/signUpScreenScreen.dart';
import 'package:destino_quisqueya_front/screens/favoriteScreen/favoriteScreem.dart';
import 'package:destino_quisqueya_front/screens/home/homeScreen.dart';
import 'package:destino_quisqueya_front/models/itinerary.model.dart';
import 'package:destino_quisqueya_front/screens/itineraries/itinerariesScreen.dart';
import 'package:destino_quisqueya_front/screens/itineraries/itineraryDetailScreen.dart';
import 'package:destino_quisqueya_front/screens/itineraries/itineraryFormScreen.dart';
import 'package:destino_quisqueya_front/screens/nearBy/nearByScreen.dart';
import 'package:destino_quisqueya_front/screens/places/placesByCategoryScreen/placesByCategoryScreen.dart';
import 'package:destino_quisqueya_front/screens/places/placesPhotosGallery/placePhotosGalleryScreen.dart';
import 'package:destino_quisqueya_front/screens/profile/profileScreen.dart';
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
  ItineraryDetailScreen.routeName: (context) => const ItineraryDetailScreen(),
  ItineraryFormScreen.routeName: (context) {
    final itinerary = ModalRoute.of(context)?.settings.arguments as Itinerary?;
    return ItineraryFormScreen(itinerary: itinerary);
  },
  PlacesByCategoryScreen.routeName: (context) => const PlacesByCategoryScreen(),
  MostVisitedScreen.routeName: (context) => const MostVisitedScreen(),
  // DestinationDetailScreen.routeName: (context) => const DestinationDetailScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  ForgotEmailScreen.routeName: (context) => ForgotEmailScreen(),
  TestApp.routeName: (context) => TestApp(),
  PlacePhotosGalleryScreen.routeName: (context) => const PlacePhotosGalleryScreen(),

  // Anonimus Screens
  AnonimusHomeScreen.routeName: (context) => const AnonimusHomeScreen(),
};
