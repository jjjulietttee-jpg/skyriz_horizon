import 'package:flutter/material.dart';
import '../../../../core/shared/widgets/custom_text.dart';
import '../../../../core/shared/widgets/card_widget.dart';
import '../../../../core/shared/extensions/context_extensions.dart';
import 'onboarding_page_model.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingPageModel pageData;

  const OnboardingPage({
    super.key,
    required this.pageData,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.largePadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          CustomText(
            text: pageData.title,
            fontSize: context.largeTextSize,
            fontWeight: FontWeight.bold,
            enableGlow: true,
            enableShadow: true,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: context.heightPercent(0.03)),
          CustomText(
            text: pageData.subtitle,
            fontSize: context.mediumTextSize,
            fontWeight: FontWeight.w500,
            enableGlow: false,
            enableShadow: true,
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 1),
          Flexible(
            flex: 4,
            child: CardWidget(
              padding: context.defaultPadding,
              child: Center(
                child: CustomText(
                  text: pageData.description,
                  fontSize: context.smallTextSize,
                  fontWeight: FontWeight.normal,
                  enableGlow: false,
                  enableShadow: true,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
