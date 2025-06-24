import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSizes {
  static const double small = 14.0;
  static const double standard = 16.0;
  static const double standardUp = 18.0;
  static const double medium = 20.0;
  static const double large = 28.0;
  static const double xLarge = 32.0;
}

class DeafultColor {
  static const Color myGrey = Colors.grey;
  static const Color greyText = Color(0xFFB3B9C9);
  static const Color wihteText = Color(0xFFFFFFFF);
  static const Color senderMessage = Color(0xFF7A8194);
  static const Color receiverMessage = Color(0xFF373E4E);
  static const Color sentMessageInput = Color(0xFF3D4354);
  static const Color messageListPage = Color(0xFF292F3F);
  static const Color buttonColor = Color(0xFF7A8194);
  static const Color backgroundColor = Color(0xFF182020);
}

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: Colors.white,
    fontFamily: GoogleFonts.alegreyaSans().fontFamily,
    scaffoldBackgroundColor: DeafultColor.backgroundColor,
    textTheme: TextTheme(
      titleMedium: GoogleFonts.alegreyaSans(
        fontSize: FontSizes.medium,
        color: DeafultColor.wihteText,
      ),
      titleLarge: GoogleFonts.alegreyaSans(
        fontSize: FontSizes.large,
        color: DeafultColor.wihteText,
      ),
      bodySmall: GoogleFonts.alegreyaSans(
        fontSize: FontSizes.small,
        color: DeafultColor.greyText,
      ),
      bodyMedium: GoogleFonts.alegreyaSans(
        fontSize: FontSizes.standard,
        color: DeafultColor.wihteText,
      ),
      bodyLarge: GoogleFonts.alegreyaSans(
        fontSize: FontSizes.medium,
        color: DeafultColor.wihteText,
      ),
    ),
  );
}
