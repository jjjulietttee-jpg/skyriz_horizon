import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/custom_text.dart';
import '../../../../core/shared/theme/app_colors.dart';
import '../../../../core/shared/extensions/context_extensions.dart';

class GameHUD extends StatelessWidget {
  final int score;
  final int highScore;
  final VoidCallback onPause;

  const GameHUD({
    super.key,
    required this.score,
    required this.highScore,
    required this.onPause,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: context.defaultPadding,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Score',
                      fontSize: context.smallTextSize,
                      enableGlow: false,
                      color: AppColors.textSecondary,
                    ),
                    CustomText(
                      text: score.toString(),
                      fontSize: context.largeTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      text: 'Best',
                      fontSize: context.smallTextSize,
                      enableGlow: false,
                      color: AppColors.textSecondary,
                    ),
                    CustomText(
                      text: highScore.toString(),
                      fontSize: context.mediumTextSize,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentPurple,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
