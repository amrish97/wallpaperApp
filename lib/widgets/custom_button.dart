import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper/resource/app_colors.dart';
import 'package:wallpaper/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool isCenterLoaderEnable;
  final GestureTapCallback onTap;
  const CustomButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.isCenterLoaderEnable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).primaryColor,
        ),
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Center(
            child: isCenterLoaderEnable
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      color: Colors.white,
                      strokeAlign: 1.0,
                      strokeWidth: 2.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      backgroundColor: Colors.white30,
                    ),
                  )
                : CustomText(
                    text: text,
                    textColor: AppColors.whiteColor,
                    style: GoogleFonts.getFont("Yesteryear",
                        fontSize: 20, color: AppColors.whiteColor),
                  )),
      ),
    );
  }
}
