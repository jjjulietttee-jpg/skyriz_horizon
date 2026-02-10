import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../extensions/context_extensions.dart';

class CustomElevatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Gradient? gradient;
  final double? width;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.elevation,
    this.padding,
    this.borderRadius,
    this.gradient,
    this.width,
    this.height,
    this.fontSize,
    this.fontWeight,
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _scaleController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _scaleController.reverse();
    widget.onPressed();
  }

  void _onTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final double adaptiveHeight = widget.height ?? context.buttonHeight;
    final double adaptiveFontSize = widget.fontSize ?? context.mediumTextSize;
    final EdgeInsetsGeometry adaptivePadding = widget.padding ??
        EdgeInsets.symmetric(
          horizontal: context.widthPercent(0.08),
          vertical: context.heightPercent(0.015),
        );
    final BorderRadius adaptiveBorderRadius = widget.borderRadius ??
        BorderRadius.only(
          topLeft: Radius.circular(context.widthPercent(0.08)),
          topRight: Radius.circular(context.widthPercent(0.04)),
          bottomLeft: Radius.circular(context.widthPercent(0.04)),
          bottomRight: Radius.circular(context.widthPercent(0.08)),
        );
    final Gradient buttonGradient =
        widget.gradient ?? AppColors.primaryGradient;
    final Color buttonTextColor = widget.textColor ?? AppColors.textPrimary;
    final double buttonElevation = widget.elevation ?? 8.0;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          height: adaptiveHeight,
          padding: adaptivePadding,
          decoration: BoxDecoration(
            gradient: buttonGradient,
            borderRadius: adaptiveBorderRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: buttonElevation,
                offset: Offset(0, buttonElevation / 2),
              ),
              if (_isPressed)
                BoxShadow(
                  color: AppColors.glowColor.withValues(alpha: 0.6),
                  blurRadius: 20.0,
                  offset: const Offset(0, 0),
                ),
              if (_isPressed)
                BoxShadow(
                  color: AppColors.glowColor.withValues(alpha: 0.4),
                  blurRadius: 30.0,
                  offset: const Offset(0, 0),
                ),
            ],
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: adaptiveFontSize,
                  fontWeight: widget.fontWeight ?? FontWeight.bold,
                  color: buttonTextColor,
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
