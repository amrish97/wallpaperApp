import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wallpaper/app/app_routes.dart';
import 'package:wallpaper/globals.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> lightColor = [
      Colors.cyanAccent,
      Colors.deepOrange,
      Colors.greenAccent,
      Colors.redAccent,
      Colors.blueAccent,
      Colors.purpleAccent,
      Colors.yellowAccent,
      Colors.pinkAccent,
      Colors.tealAccent,
      Colors.amberAccent,
      Colors.indigoAccent,
      Colors.deepPurpleAccent,
      Colors.limeAccent,
      Colors.orangeAccent,
    ];

    List<Color> darkColor = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.yellow,
      Colors.pink,
      Colors.orange,
      Colors.grey,
      Colors.white
    ];

    Color getRandomColors() {
      final isDark =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
      final random = Random();
      print("isDark--- ${isDark}");
      return isDark
          ? darkColor[random.nextInt(darkColor.length)]
          : lightColor[random.nextInt(lightColor.length)];
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: getRandomColors(),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: getRandomColors(),
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.system,
      initialRoute: AppRouteEnum.authPage.name,
      routes: AppRoutes.appNavigator,
    );
  }
}
