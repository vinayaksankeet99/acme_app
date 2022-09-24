import 'package:acme/ui/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final TextTheme _textTheme = TextTheme(
  headline1: GoogleFonts.poppins(
    fontSize: 93,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
    color: AppColors.text,
  ),
  headline2: GoogleFonts.poppins(
    fontSize: 58,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    color: AppColors.text,
  ),
  headline3: GoogleFonts.poppins(
    fontSize: 46,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  ),
  headline4: GoogleFonts.poppins(
    fontSize: 33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.text,
  ),
  headline5: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.text,
  ),
  headline6: GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  ),
  subtitle1: GoogleFonts.varelaRound(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    color: AppColors.text,
  ),
  subtitle2: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    color: AppColors.text,
  ),
  bodyText1: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    color: AppColors.textLight,
  ),
  bodyText2: GoogleFonts.varelaRound(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    color: AppColors.textLight,
  ),
  button: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.25,
    color: AppColors.white,
  ),
  caption: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    color: AppColors.textLight,
  ),
  overline: GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1,
    color: AppColors.text,
  ),
);

class AppTheme {
  static ThemeData getThemeData(BuildContext context) {
    return ThemeData(
      primarySwatch: createMaterialColor(AppColors.primary),
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: _textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: AppColors.white),
        titleTextStyle: _textTheme.subtitle2!.copyWith(
          color: AppColors.white,
          fontSize: 18,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          minimumSize: const Size(0, 60),
          padding: const EdgeInsets.only(left: 24, right: 24),
          textStyle: _textTheme.button,
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        hintStyle: _textTheme.bodyText2,
      ),
      scaffoldBackgroundColor: AppColors.background,
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.25,
            color: AppColors.text,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.25,
          ),
          side: const BorderSide(color: AppColors.primary),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        textStyle: _textTheme.bodyText1,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.background,
        disabledColor: AppColors.border.withOpacity(0.25),
        selectedColor: AppColors.primary.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
          side: const BorderSide(
            width: 1,
            color: AppColors.border,
          ),
        ),
        labelStyle: _textTheme.bodyText1,
      ),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
