import 'package:flutter/material.dart';

const _primary = Color(0xFF0E5B7A);
const _secondary = Color(0xFF2BB673);
const _tertiary = Color(0xFFE8A33D);
const _surface = Color(0xFFF6F7FB);
const _ink = Color(0xFF111827);
const _muted = Color(0xFF6B7280);

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: _primary,
    brightness: Brightness.light,
    primary: _primary,
    secondary: _secondary,
    tertiary: _tertiary,
    surface: _surface,
  );

  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: _surface,
    colorScheme: scheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        height: 1.1,
        color: _ink,
      ),
      displayMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        height: 1.15,
        color: _ink,
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        height: 1.2,
        color: _ink,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: _ink,
      ),
      titleLarge: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: _ink,
      ),
      titleMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: _ink,
      ),
      bodyLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.45,
        color: _ink,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.45,
        color: _muted,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: _muted,
      ),
      labelLarge: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: _ink,
      ),
      labelMedium: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: .5,
        color: _muted,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE6EAF0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE6EAF0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: _primary, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      labelStyle: const TextStyle(color: _muted, fontSize: 14),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFE6EAF0),
      thickness: 1,
      space: 1,
    ),
  );
}
