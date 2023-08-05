import 'package:flutter/material.dart';

ThemeData myAppTheme() {
  final baseTheme = ThemeData.light();
  return baseTheme.copyWith(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      labelStyle: const TextStyle(color: Colors.blueGrey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      prefixIconColor: Colors.blueGrey,
      suffixIconColor: Colors.blueGrey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFc1d22b),
      ),
    ),
  );
}
