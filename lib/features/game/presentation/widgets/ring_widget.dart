import 'package:flutter/material.dart';
import '../../../../core/shared/theme/app_colors.dart';
import '../../domain/entities/ring.dart';

class RingWidget extends StatelessWidget {
  final Ring ring;

  const RingWidget({
    super.key,
    required this.ring,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final ringWidth = screenWidth * 0.15;
    final ringThickness = screenWidth * 0.03;
    final gapSize = screenHeight * ring.gapSize;

    return Positioned(
      left: screenWidth * ring.xPosition - ringWidth / 2,
      top: 0,
      bottom: 0,
      child: SizedBox(
        width: ringWidth,
        child: Column(
          children: [
            Expanded(
              flex: ((ring.yPosition - ring.gapSize / 2) * 1000).toInt(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.accentRed.withValues(alpha: 0.3),
                      AppColors.accentRed.withValues(alpha: 0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ringWidth * 0.3),
                    topRight: Radius.circular(ringWidth * 0.3),
                    bottomLeft: Radius.circular(ringThickness),
                    bottomRight: Radius.circular(ringThickness),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentRed.withValues(alpha: 0.4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: gapSize),
            Expanded(
              flex: ((1.0 - ring.yPosition - ring.gapSize / 2) * 1000).toInt(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.accentRed.withValues(alpha: 0.8),
                      AppColors.accentRed.withValues(alpha: 0.3),
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ringThickness),
                    topRight: Radius.circular(ringThickness),
                    bottomLeft: Radius.circular(ringWidth * 0.3),
                    bottomRight: Radius.circular(ringWidth * 0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentRed.withValues(alpha: 0.4),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
