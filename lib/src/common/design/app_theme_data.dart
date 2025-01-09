import 'package:flutter/material.dart';

class AppThemeData {
  static InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
  );

  static TextTheme textTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 14),
    bodyMedium: TextStyle(fontSize: 12),
  );

  static final CardTheme lightChildCardTheme = CardTheme(
    color: Colors.orange.shade50,
    elevation: 2,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  static final CardTheme darkChildCardTheme = CardTheme(
    color: Colors.deepOrange.shade50,
    elevation: 2,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  static final CardTheme lightParentCardTheme = CardTheme(
    color: Colors.blue.shade50,
    elevation: 2,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  static final CardTheme darkParentCardTheme = CardTheme(
    color: const Color.fromARGB(255, 38, 100, 208).withOpacity(0.2),
    elevation: 2,
    margin: const EdgeInsets.all(8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  static final ThemeData lightChildTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.orangeAccent,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color.fromARGB(50, 255, 153, 0),
    ),
    textTheme: textTheme,
    cardTheme: lightChildCardTheme,
    inputDecorationTheme: inputDecorationTheme,
  );

  static final ThemeData darkChildTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.deepOrangeAccent,
    textTheme: textTheme,
    cardTheme: darkChildCardTheme,
    inputDecorationTheme: inputDecorationTheme,
  );

  static final ThemeData lightParentTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Colors.blueAccent,
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color.fromARGB(50, 33, 149, 243),
    ),
    textTheme: textTheme,
    cardTheme: lightParentCardTheme,
    inputDecorationTheme: inputDecorationTheme,
  );

  static final ThemeData darkParentTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color.fromARGB(255, 38, 100, 208),
    textTheme: textTheme,
    cardTheme: darkParentCardTheme,
    inputDecorationTheme: inputDecorationTheme,
  );
}
