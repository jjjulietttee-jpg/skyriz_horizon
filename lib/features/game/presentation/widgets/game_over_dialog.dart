import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/custom_text.dart';
import '../../../../core/shared/widgets/custom_elevated_button.dart';
import '../../../../core/shared/theme/app_colors.dart';
import '../../../../core/shared/extensions/context_extensions.dart';

class GameOverDialog extends StatelessWidget {
  final int score;
  final int highScore;
  final VoidCallback onRestart;
  final VoidCallback onExit;

  const GameOverDialog({
    super.key,
    required this.score,
    required this.highScore,
    required this.onRestart,
    required this.onExit,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNewHighScore = score == highScore && score > 0;

    return Center(
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.widthPercent(0.85),
          ),
          margin: EdgeInsets.symmetric(vertical: context.heightPercent(0.05)),
          padding: EdgeInsets.all(context.widthPercent(0.05)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.cardBackground.withValues(alpha: 0.98),
                AppColors.secondaryDark.withValues(alpha: 0.98),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(context.widthPercent(0.06)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.7),
                blurRadius: 30.0,
                offset: const Offset(0, 15),
              ),
              BoxShadow(
                color: AppColors.glowColor.withValues(alpha: 0.3),
                blurRadius: 40.0,
                offset: const Offset(0, 0),
              ),
            ],
            border: Border.all(
              color: AppColors.accentBlue.withValues(alpha: 0.4),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'Flight Complete',
                fontSize: context.mediumTextSize * 1.2,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.heightPercent(0.02)),
              if (isNewHighScore) ...[
                CustomText(
                  text: '🎉 New Record! 🎉',
                  fontSize: context.mediumTextSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentPurple,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.heightPercent(0.015)),
              ],
              Container(
                padding: EdgeInsets.all(context.widthPercent(0.04)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryDark.withValues(alpha: 0.6),
                      AppColors.secondaryDark.withValues(alpha: 0.4),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(context.widthPercent(0.04)),
                ),
                child: Column(
                  children: [
                    CustomText(
                      text: 'Score',
                      fontSize: context.smallTextSize,
                      enableGlow: false,
                      color: AppColors.textSecondary,
                    ),
                    SizedBox(height: context.heightPercent(0.008)),
                    CustomText(
                      text: score.toString(),
                      fontSize: context.largeTextSize * 1.3,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: context.heightPercent(0.015)),
                    CustomText(
                      text: 'Best: $highScore',
                      fontSize: context.mediumTextSize,
                      enableGlow: false,
                      color: AppColors.accentPurple,
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.heightPercent(0.03)),
              CustomElevatedButton(
                text: 'Fly Again',
                onPressed: onRestart,
                fontSize: context.mediumTextSize,
              ),
              SizedBox(height: context.heightPercent(0.015)),
              CustomElevatedButton(
                text: 'Exit',
                onPressed: onExit,
                gradient: LinearGradient(
                  colors: [
                    AppColors.textSecondary.withValues(alpha: 0.6),
                    AppColors.textSecondary.withValues(alpha: 0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                fontSize: context.mediumTextSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
