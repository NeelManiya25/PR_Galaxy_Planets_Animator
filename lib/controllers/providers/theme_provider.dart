import 'package:flutter/material.dart';
import 'package:pr_galaxy_plants/models/theme_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeModel themeModel;

  ThemeProvider({required this.themeModel});

  changeTheme() async {
    themeModel.isDark = !themeModel.isDark;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool('isDark', themeModel.isDark);

    notifyListeners();
  }
}
