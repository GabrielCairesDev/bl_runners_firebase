import 'package:flutter/material.dart';

ThemeData myAppTheme() {
  final baseTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // useMaterial3: true,
  );
  return baseTheme.copyWith(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      labelStyle: const TextStyle(color: Colors.blueGrey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      prefixIconColor: Colors.blueGrey,
      suffixIconColor: Colors.blueGrey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFc1d22b),
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF2e355a),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        ),
      ),
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFc1d22b),
    ),
  );
}
