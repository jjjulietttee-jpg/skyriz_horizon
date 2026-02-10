import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle largeTitle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.08,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
      shadows: [
        Shadow(
          blurRadius: 20.0,
          color: AppColors.glowColor,
          offset: const Offset(0, 0),
        ),
        Shadow(
          blurRadius: 10.0,
          color: AppColors.glowColor,
          offset: const Offset(0, 0),
        ),
        const Shadow(
          blurRadius: 5.0,
          color: Colors.black54,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  static TextStyle subtitle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.045,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
      shadows: const [
        Shadow(
          blurRadius: 3.0,
          color: Colors.black45,
          offset: Offset(0, 1),
        ),
      ],
    );
  }

  static TextStyle body(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.04,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
      shadows: const [
        Shadow(
          blurRadius: 2.0,
          color: Colors.black38,
          offset: Offset(0, 1),
        ),
      ],
    );
  }

  static TextStyle button(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.05,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
      shadows: [
        Shadow(
          blurRadius: 8.0,
          color: AppColors.glowColor.withValues(alpha: 0.6),
          offset: const Offset(0, 0),
        ),
        const Shadow(
          blurRadius: 4.0,
          color: Colors.black54,
          offset: Offset(0, 1),
        ),
      ],
    );
  }

  static TextStyle caption(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.035,
      fontWeight: FontWeight.w400,
      color: AppColors.textSecondary,
    );
  }
}
