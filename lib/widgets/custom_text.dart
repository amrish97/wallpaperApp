import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  TextStyle? style;
  Color? textColor;

  CustomText({super.key, required this.text, this.style, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      style: style ?? GoogleFonts.getFont("Open Sans", color: textColor, fontSize: 15),
    );
  }
}
