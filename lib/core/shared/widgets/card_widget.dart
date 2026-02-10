import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../extensions/context_extensions.dart';

class CardWidget extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Gradient? gradient;
  final double? width;
  final double? height;

  const CardWidget({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.gradient,
    this.width,
    this.height,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
    
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _onHoverEnter(PointerEvent details) {
    setState(() {
      _isHovered = true;
    });
    _scaleController.forward();
  }

  void _onHoverExit(PointerEvent details) {
    setState(() {
      _isHovered = false;
    });
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsGeometry adaptivePadding = widget.padding ??
        EdgeInsets.all(context.widthPercent(0.04));
    final BorderRadius adaptiveBorderRadius = widget.borderRadius ??
        BorderRadius.circular(context.widthPercent(0.05));
    final double cardElevation = widget.elevation ?? 6.0;
    
    final Gradient cardGradient = widget.gradient ??
        LinearGradient(
          colors: [
            widget.backgroundColor?.withValues(alpha: 0.8) ?? 
                AppColors.cardBackground.withValues(alpha: 0.8),
            widget.backgroundColor?.withValues(alpha: 0.6) ?? 
                AppColors.cardBackground.withValues(alpha: 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: MouseRegion(
            onEnter: _onHoverEnter,
            onExit: _onHoverExit,
            child: Container(
              width: widget.width,
              height: widget.height,
              padding: adaptivePadding,
              decoration: BoxDecoration(
                gradient: cardGradient,
                borderRadius: adaptiveBorderRadius,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: cardElevation,
                    offset: Offset(0, cardElevation / 2),
                  ),
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: cardElevation * 2,
                    offset: Offset(0, cardElevation),
                  ),
                  if (_isHovered)
                    BoxShadow(
                      color: AppColors.glowColor.withValues(alpha: 0.3),
                      blurRadius: 15.0,
                      offset: const Offset(0, 0),
                    ),
                ],
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
