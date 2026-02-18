import 'package:flutter/material.dart';

class PlaneClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w * 0.1, h * 0.5);
    path.quadraticBezierTo(w * 0.5, h * 0.35, w * 0.95, h * 0.5);
    path.quadraticBezierTo(w * 0.5, h * 0.65, w * 0.1, h * 0.5);
    
    path.moveTo(w * 0.7, h * 0.42);
    path.lineTo(w * 0.85, h * 0.5);
    path.lineTo(w * 0.7, h * 0.58);
    path.close();

    path.moveTo(w * 0.4, h * 0.4);
    path.lineTo(w * 0.55, h * 0.1);
    path.lineTo(w * 0.65, h * 0.4);
    
    path.moveTo(w * 0.4, h * 0.6);
    path.lineTo(w * 0.55, h * 0.9);
    path.lineTo(w * 0.65, h * 0.6);

    path.moveTo(w * 0.15, h * 0.45);
    path.lineTo(w * 0.05, h * 0.25);
    path.lineTo(w * 0.25, h * 0.45);
    
    path.moveTo(w * 0.15, h * 0.55);
    path.lineTo(w * 0.05, h * 0.75);
    path.lineTo(w * 0.25, h * 0.55);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class PlanePainter extends CustomPainter {
  final Color color;
  final Color accentColor;

  PlanePainter({required this.color, required this.accentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final accentPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    final wingPath = Path();
    wingPath.moveTo(w * 0.35, h * 0.45);
    wingPath.lineTo(w * 0.5, h * 0.05);
    wingPath.lineTo(w * 0.65, h * 0.45);
    
    wingPath.moveTo(w * 0.35, h * 0.55);
    wingPath.lineTo(w * 0.5, h * 0.95);
    wingPath.lineTo(w * 0.65, h * 0.55);
    canvas.drawPath(wingPath, paint);

    final tailPath = Path();
    tailPath.moveTo(w * 0.15, h * 0.48);
    tailPath.lineTo(w * 0.02, h * 0.25);
    tailPath.lineTo(w * 0.25, h * 0.48);
    
    tailPath.moveTo(w * 0.15, h * 0.52);
    tailPath.lineTo(w * 0.02, h * 0.75);
    tailPath.lineTo(w * 0.25, h * 0.52);
    canvas.drawPath(tailPath, paint);

    final bodyPath = Path();
    bodyPath.moveTo(w * 0.05, h * 0.5);
    bodyPath.quadraticBezierTo(w * 0.4, h * 0.35, w * 0.98, h * 0.5);
    bodyPath.quadraticBezierTo(w * 0.4, h * 0.65, w * 0.05, h * 0.5);
    canvas.drawPath(bodyPath, paint);

    final cockpitPath = Path();
    cockpitPath.moveTo(w * 0.65, h * 0.42);
    cockpitPath.quadraticBezierTo(w * 0.85, h * 0.42, w * 0.95, h * 0.5);
    cockpitPath.quadraticBezierTo(w * 0.85, h * 0.58, w * 0.65, h * 0.58);
    canvas.drawPath(cockpitPath, accentPaint);
    
    final enginePaint = Paint()
      ..color = accentColor.withValues(alpha: 0.6)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawCircle(Offset(w * 0.1, h * 0.5), w * 0.05, enginePaint);
  }

  @override
  bool shouldRepaint(PlanePainter oldDelegate) => 
    color != oldDelegate.color || accentColor != oldDelegate.accentColor;
}
