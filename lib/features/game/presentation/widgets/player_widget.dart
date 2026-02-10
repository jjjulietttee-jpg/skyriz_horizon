import 'package:flutter/material.dart';
import '../../../../core/shared/theme/app_colors.dart';
import '../../domain/entities/player.dart';

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
            // Trail effect
            Positioned(
              left: -playerSize * 0.5,
              child: Container(
                width: playerSize,
                height: playerSize * 0.2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accentOrange.withValues(alpha: 0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: playerSize,
              height: playerSize,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.glowColor.withValues(alpha: 0.8),
                    blurRadius: 20.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.airplanemode_active,
                  size: playerSize,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
