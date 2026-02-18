import 'package:flutter/material.dart';
import '../../../../core/shared/theme/app_colors.dart';
import '../../domain/entities/player.dart';
import 'plane_painter.dart';

class PlayerWidget extends StatelessWidget {
  final Player player;

  const PlayerWidget({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final playerSize = screenHeight * player.size;

    return Positioned(
      left: MediaQuery.of(context).size.width * 0.2 - playerSize / 2,
      top: screenHeight * player.yPosition - playerSize / 2,
      child: Transform.rotate(
        angle: player.angle,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: -playerSize * 0.6,
              child: Container(
                width: playerSize * 0.8,
                height: playerSize * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accentOrange.withValues(alpha: 0.9),
                      AppColors.accentRed.withValues(alpha: 0.4),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(playerSize),
                ),
              ),
            ),
            Container(
              width: playerSize * 1.2,
              height: playerSize * 1.2,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CustomPaint(
                painter: PlanePainter(
                  color: AppColors.textPrimary,
                  accentColor: AppColors.accentRed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
