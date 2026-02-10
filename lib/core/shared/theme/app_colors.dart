import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryDark = Color(0xFF1A0505); // Deep dark red/brown
  static const Color secondaryDark = Color(0xFF2D0A0A); // Slightly lighter dark red
  static const Color accentRed = Color(0xFFE52121); // Vibrant Aviator Red
  static const Color accentOrange = Color(0xFFFF5F1F); // Fiery Orange
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFD3D3D3);
  static const Color cardBackground = Color(0xFF3D1414);
  static const Color glowColor = Color(0xFFFF2400); // Scarlet glow

  // Aliases for backward compatibility and app-wide consistency
  static const Color accentBlue = Color(0xFFE52121); // Redirect to accentRed
  static const Color accentPurple = Color(0xFFFF5F1F); // Redirect to accentOrange

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [accentRed, accentOrange],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [primaryDark, secondaryDark, primaryDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
