import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colors from Tailwind CSS (v3.0) - June 2022
///
/// https://tailwindcss.com/docs/customizing-colors

const int _primaryColor = 0xFF6366F1;
const MaterialColor primarySwatch = MaterialColor(_primaryColor, <int, Color>{
  50: Color(0xFFEEF2FF),
  100: Color(0xFFE0E7FF),
  200: Color(0xFFC7D2FE),
  300: Color(0xFFA5B4FC),
  400: Color(0xFF818CF8),
  500: Color(_primaryColor),
  600: Color(0xFF4F46E5),
  700: Color(0xFF4338CA),
  800: Color(0xFF3730A3),
  900: Color(0xFF312E81),
});

const int _textColor = 0xFF64748B;
const MaterialColor textSwatch = MaterialColor(_textColor, <int, Color>{
  50: Color(0xFFF8FAFC),
  100: Color(0xFFF1F5F9),
  200: Color(0xFFE2E8F0),
  300: Color(0xFFCBD5E1),
  400: Color(0xFF94A3B8),
  500: Color(_textColor),
  600: Color(0xFF475569),
  700: Color(0xFF334155),
  800: Color(0xFF1E293B),
  900: Color(0xFF0F172A),
});

const Color errorColor = Color(0xFFDC2626);

final ColorScheme lightColorScheme = ColorScheme.light(
  primary: primarySwatch.shade500,
  secondary: primarySwatch.shade500,
  onSecondary: Colors.white,
  error: errorColor,
  onSurface: textSwatch.shade500,
  surface: textSwatch.shade200,
  surfaceContainerHighest: Colors.white,
  shadow: textSwatch.shade900.withOpacity(.1),
);

final ColorScheme darkColorScheme = ColorScheme.dark(
  primary: primarySwatch.shade500,
  secondary: primarySwatch.shade500,
  onSecondary: Colors.white,
  error: errorColor,
  onSurface: textSwatch.shade400,
  surface: const Color(0xFF171724),
  surfaceContainerHighest: const Color(0xFF282832),
  shadow: textSwatch.shade900.withOpacity(.2),
);

final ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.lato(
      color: textSwatch.shade700,
    ),
    displayMedium: GoogleFonts.lato(
      color: textSwatch.shade600,
    ),
    displaySmall: GoogleFonts.lato(
      color: textSwatch.shade500,
    ),
    headlineLarge: GoogleFonts.lato(
      color: textSwatch.shade700,
    ),
    headlineMedium: GoogleFonts.lato(
      color: textSwatch.shade600,
    ),
    headlineSmall: GoogleFonts.lato(
      color: textSwatch.shade500,
    ),
    titleLarge: GoogleFonts.lato(
      color: textSwatch.shade700,
    ),
    titleMedium: GoogleFonts.lato(
      color: textSwatch.shade600,
    ),
    titleSmall: GoogleFonts.lato(
      color: textSwatch.shade500,
    ),
    bodyLarge: GoogleFonts.lato(
      color: textSwatch.shade700,
    ),
    bodyMedium: GoogleFonts.lato(
      color: textSwatch.shade600,
    ),
    bodySmall: GoogleFonts.lato(
      color: textSwatch.shade500,
    ),
    labelLarge: GoogleFonts.lato(
      color: textSwatch.shade700,
    ),
    labelMedium: GoogleFonts.lato(
      color: textSwatch.shade600,
    ),
    labelSmall: GoogleFonts.lato(
      color: textSwatch.shade500,
    ),
  ),
);

final ThemeData darkTheme = lightTheme.copyWith(
  colorScheme: darkColorScheme,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.lato(
      color: textSwatch.shade200,
    ),
    displayMedium: GoogleFonts.lato(
      color: textSwatch.shade300,
    ),
    displaySmall: GoogleFonts.lato(
      color: textSwatch.shade400,
    ),
    headlineLarge: GoogleFonts.lato(
      color: textSwatch.shade200,
    ),
    headlineMedium: GoogleFonts.lato(
      color: textSwatch.shade300,
    ),
    headlineSmall: GoogleFonts.lato(
      color: textSwatch.shade400,
    ),
    titleLarge: GoogleFonts.lato(
      color: textSwatch.shade200,
    ),
    titleMedium: GoogleFonts.lato(
      color: textSwatch.shade300,
    ),
    titleSmall: GoogleFonts.lato(
      color: textSwatch.shade400,
    ),
    bodyLarge: GoogleFonts.lato(
      color: textSwatch.shade200,
    ),
    bodyMedium: GoogleFonts.lato(
      color: textSwatch.shade300,
    ),
    bodySmall: GoogleFonts.lato(
      color: textSwatch.shade400,
    ),
    labelLarge: GoogleFonts.lato(
      color: textSwatch.shade200,
    ),
    labelMedium: GoogleFonts.lato(
      color: textSwatch.shade300,
    ),
    labelSmall: GoogleFonts.lato(
      color: textSwatch.shade400,
    ),
  ),
);
