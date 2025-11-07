import 'package:destino_quisqueya_front/generated/l10n.dart';
import 'package:destino_quisqueya_front/routes/routes.dart';
import 'package:destino_quisqueya_front/screens/auth/login/loginScreen.dart';
import 'package:destino_quisqueya_front/screens/onboardingScreen/onboardingScreen.dart';
import 'package:destino_quisqueya_front/theme/app_theme.dart';
import 'package:destino_quisqueya_front/utilities/utilitis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_intl_example/generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ocultar barras del sistema (como ya lo tenías)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Widget initialPage() {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mientras se carga SharedPreferences, muestra una pantalla de carga
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Maneja errores si los hay
          return Text('Error: ${snapshot.error}');
        } else {
          final prefs = snapshot.data;
          final bool seenOnboarding =
              prefs?.getBool(CacheAcess.showOnboarding) ?? true;
          if (seenOnboarding) {
            return const OnboardingScreen();
          } else {
            return const LoginScreen();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        routes: routes,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        // LocalizationsDelegate this is the configuration part for i18n
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: initialPage(),
      ),
    );
  }
}
