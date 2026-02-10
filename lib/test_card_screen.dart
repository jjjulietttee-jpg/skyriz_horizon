import 'package:flutter/material.dart';
import 'core/shared/widgets/widgets_export.dart';
import 'core/shared/theme/app_colors.dart';
import 'core/shared/extensions/context_extensions.dart';

class TestCardScreen extends StatelessWidget {
  const TestCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: context.defaultPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: context.heightPercent(0.02)),
                const CustomText(
                  text: 'CardWidget Test',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: context.heightPercent(0.04)),
                CardWidget(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Basic Card',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: context.heightPercent(0.01)),
                      const CustomText(
                        text: 'This card has fade-in and slide-up animations on mount.',
                        fontSize: 16,
                        enableGlow: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.heightPercent(0.02)),
                CardWidget(
                  backgroundColor: AppColors.accentBlue,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Custom Background',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: context.heightPercent(0.01)),
                      const CustomText(
                        text: 'This card has a custom background color with gradient.',
                        fontSize: 16,
                        enableGlow: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.heightPercent(0.02)),
                CardWidget(
                  gradient: const LinearGradient(
                    colors: [AppColors.accentPurple, AppColors.accentBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  elevation: 12.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Custom Gradient',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: context.heightPercent(0.01)),
                      const CustomText(
                        text: 'This card has a custom gradient and higher elevation.',
                        fontSize: 16,
                        enableGlow: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: context.heightPercent(0.02)),
                Row(
                  children: [
                    Expanded(
                      child: CardWidget(
                        height: context.heightPercent(0.15),
                        child: const Center(
                          child: CustomText(
                            text: 'Hover Me',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.widthPercent(0.04)),
                    Expanded(
                      child: CardWidget(
                        height: context.heightPercent(0.15),
                        child: const Center(
                          child: CustomText(
                            text: 'Hover Me Too',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.heightPercent(0.02)),
                const CustomText(
                  text: 'Hover over cards to see scale effect',
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  enableGlow: false,
                  color: AppColors.textSecondary,
                ),
                SizedBox(height: context.heightPercent(0.04)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
