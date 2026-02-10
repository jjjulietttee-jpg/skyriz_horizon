import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final bool enableGlow;
  final bool enableShadow;
  final TextAlign? textAlign;
  final Gradient? gradient;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.enableGlow = true,
    this.enableShadow = true,
    this.textAlign,
    this.gradient,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final double adaptiveFontSize = fontSize ?? MediaQuery.of(context).size.width * 0.045;
    final Color textColor = color ?? AppColors.textPrimary;
    final FontWeight weight = fontWeight ?? FontWeight.normal;

    final List<Shadow> shadows = [];
    
    if (enableGlow) {
      shadows.addAll([
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
        Shadow(
          blurRadius: 5.0,
          color: AppColors.glowColor.withValues(alpha: 0.5),
          offset: const Offset(0, 0),
        ),
      ]);
    }
    
    if (enableShadow) {
      shadows.add(
        const Shadow(
          blurRadius: 4.0,
          color: Colors.black54,
          offset: Offset(0, 2),
        ),
      );
    }

    final textStyle = TextStyle(
      fontSize: adaptiveFontSize,
      fontWeight: weight,
      color: textColor,
      shadows: shadows.isNotEmpty ? shadows : null,
    );

    final textWidget = Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: textStyle,
    );

    if (gradient != null) {
      return ShaderMask(
        shaderCallback: (bounds) => gradient!.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
        child: textWidget,
      );
    }

    return textWidget;
  }
}
