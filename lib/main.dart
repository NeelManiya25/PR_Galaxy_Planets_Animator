import 'package:flutter/material.dart';
import 'package:pr_galaxy_plants/controllers/providers/json_decode_provider.dart';
import 'package:pr_galaxy_plants/controllers/providers/theme_provider.dart';
import 'package:pr_galaxy_plants/models/theme_model.dart';
import 'package:pr_galaxy_plants/views/screens/Details_Page.dart';
import 'package:pr_galaxy_plants/views/screens/Favorites_Page.dart';
import 'package:pr_galaxy_plants/views/screens/Home_Page.dart';
import 'package:pr_galaxy_plants/views/screens/Settings_Page.dart';
import 'package:pr_galaxy_plants/views/screens/Splash_Screen.dart';
import 'package:pr_galaxy_plants/views/screens/intro_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDark = prefs.getBool('isDark') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            themeModel: ThemeModel(
              isDark: isDark,
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => JsonDecodeProvider(),
        ),
      ],
      builder: (context, child) => Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          themeMode: (Provider.of<ThemeProvider>(context).themeModel.isDark)
              ? ThemeMode.dark
              : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const intro_page(),
            'splashScreen': (context) => const SplashScreen(),
            'home_page': (context) => const HomePage(),
            'settings_page': (context) => const SettingsPage(),
            'details_page': (context) => const DetailsPage(),
            'favorites_page': (context) => const FavoritesPage(),
          },
        ),
      ),
    ),
  );
}
