import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static final mainTitle = GoogleFonts.playfairDisplay(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Color(0xffcd5006)
  );

  static final cardsTitle = TextStyle(color: Color(0xffe69057), fontSize: 17);

  static final completionPercent = GoogleFonts.playfairDisplay(
textStyle:  TextStyle(color: AppColors.deepOrange,
fontSize: 35),);
}

