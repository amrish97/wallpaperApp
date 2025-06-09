import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper/globals.dart';
import 'package:wallpaper/provider/home_provider.dart';
import 'package:wallpaper/resource/app_images.dart';
import 'package:wallpaper/screens/homepage.dart';
import 'package:wallpaper/widgets/custom_text.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<HomeProvider>(context, listen: false).isAuthenticate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        if (value.isAuthenticated) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
            );
          });
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: [
            SizedBox(
              height: double.infinity,
              child: Image.asset(
                AppImages.splashImage,
                fit: BoxFit.cover,
              ),
            ),
            PositionedDirectional(
              top: MediaQuery.of(context).size.height * 0.12,
              start: MediaQuery.of(context).size.width * 0.33,
              child: CustomText(
                text: "$appName\u{1F609}",
                style: GoogleFonts.getFont("Yesteryear",
                    fontSize: 30, letterSpacing: 1.8, color: Colors.white),
              ),
            ),
          ]),
        );
      },
    );
  }
}
