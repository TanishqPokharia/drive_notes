import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  scaffoldBackgroundColor: const Color.fromARGB(255, 250, 239, 239),
  dialogTheme: DialogTheme(
    backgroundColor: const Color.fromARGB(250, 255, 255, 255),
  ),
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(250, 57, 56, 56),
    foregroundColor: Colors.white,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: const Color.fromARGB(250, 57, 56, 56),
  ),
);
