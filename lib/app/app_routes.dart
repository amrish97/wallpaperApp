import 'package:flutter/material.dart';
import 'package:wallpaper/screens/homepage.dart';
import 'package:wallpaper/screens/splash.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> appNavigator = {
    AppRouteEnum.authPage.name: (context) => const AuthPage(),
    AppRouteEnum.homePage.name: (context) => const Homepage(),
  };
}

enum AppRouteEnum { authPage, homePage }
