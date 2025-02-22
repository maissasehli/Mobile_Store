import 'package:flutter/material.dart';

class AppColors {
 // Primary Colors
 static const Color primary = Color(0xFF000000);  // Noir
 static const Color primaryLight = Color.fromARGB(255, 79, 79, 80);  // Bleu original
 static const Color primaryWithOpacity = Color(0x1A6C63FF); // Bleu avec 10% opacité

 // Background Colors
 static const Color background = Color(0xFFF8F9FF);
 static const Color white = Colors.white;

 // Text Colors
 static const Color textPrimary = Color(0xFF1A1A1A);
 static const Color textSecondary = Color(0xFF666666);

 // Shadow Colors
 static Color shadowColor = Colors.black.withOpacity(0.05);
 static Color primaryShadow = primary.withOpacity(0.3);

 // Indicator Colors
 static const Color inactiveIndicator = Color(0xFFE0E0E0);
}