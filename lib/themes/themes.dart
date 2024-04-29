import 'package:flutter/material.dart';

// Define dark theme
final ThemeData darkTheme = ThemeData(
brightness: Brightness.dark, // Set brightness to dark
colorScheme: ColorScheme.dark(
  primary: Color(0xFF39EBB1), // Customize primary color
  secondary: Color(0xFFE7E7E7), 
  background: Color(0xFF1b212f),// Customize secondary color
  //shadow: Color(0xFF777375),
),
textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), // Customize text styles for dark theme
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white), // Example of customizing body text color
    // Add more text styles as needed);
),
);

// Define dark theme
final ThemeData lightTheme = ThemeData(
brightness: Brightness.light, // Set brightness to dark
colorScheme: ColorScheme.light(
  primary: Color.fromARGB(255, 95, 149, 145), // Customize primary color
  secondary: Color.fromARGB(255, 136, 141, 150), 
  background: Color.fromARGB(255, 231, 235, 238),// Customize secondary color
  //shadow: Color(0xFF777375),
),
textTheme: TextTheme(
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), // Customize text styles for dark theme
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white), // Example of customizing body text color
    // Add more text styles as needed);
),
);

