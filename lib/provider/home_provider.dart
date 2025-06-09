import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';

import 'package:wallpaper/globals.dart';
import 'package:wallpaper/resource/app_images.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class HomeProvider with ChangeNotifier {
  final LocalAuthentication auth = LocalAuthentication();
  String url = "https://api.pexels.com/v1/curated?per_page=80";
  List<dynamic> getList = [];
  bool isCenterLoader = false;
  int page = 1;
  bool isAuthenticated = false;

  Future<void> fetchAPI() async {
    isCenterLoader = true;
    notifyListeners();
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': API_KEY},
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        getList = result['photos'];
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isCenterLoader = false;
      notifyListeners();
    }
  }

  setWallpaper(String image, BuildContext context) async {
    try {
      String url = image;
      File cachedImage = await DefaultCacheManager().getSingleFile(url);
      int location = WallpaperManagerPlus.homeScreen;
      WallpaperManagerPlus().setWallpaper(cachedImage, location);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("WallPaper applied Successfully.")));
      await Future.delayed(Duration(seconds: 2));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> loadMoreImage() async {
    isCenterLoader = true;
    notifyListeners();
    page += 1;
    final url = "https://api.pexels.com/v1/curated?per_page=80&page=$page";
    try {
      final response =
          await http.get(Uri.parse(url), headers: {'Authorization': API_KEY});
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        getList.addAll(result['photos']);
      }
    } catch (e) {
      print("Load more error: $e");
    } finally {
      isCenterLoader = false;
      notifyListeners();
    }
  }

  Future<bool> isAuthenticate() async {
    try {
      isAuthenticated = await auth.authenticate(
          localizedReason:
              'Login using biometric credential for using $appName App',
          options: const AuthenticationOptions(
              biometricOnly: true, stickyAuth: true));
      notifyListeners();
    } catch (e) {
      print("Error: $e");
      isAuthenticated = false;
    }
    return isAuthenticated;
  }

  List<String> developerInfo = [
    "AMRISH KUMAR R.H",
    "Flutter Developer",
    " Made with Flutter \u{1F60E} and Pexels API \u{1F680}",
    AppImages.myImage
  ];
}
