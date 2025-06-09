import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/app/app.dart';
import 'package:wallpaper/provider/home_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: const App(),
    ),
  );
}
