import 'package:flutter/material.dart';
import '../../../../core/shared/theme/app_colors.dart';
import '../../../../core/shared/extensions/context_extensions.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const PageIndicator({
    super.key,
    required this.currentPage,
    this.pageCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(
            horizontal: context.widthPercent(0.01),
          ),
          width: currentPage == index
              ? context.widthPercent(0.08)
              : context.widthPercent(0.025),
          height: context.widthPercent(0.025),
          decoration: BoxDecoration(
            gradient: currentPage == index
                ? AppColors.primaryGradient
                : null,
            color: currentPage == index
                ? null
                : AppColors.textSecondary.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(context.widthPercent(0.02)),
            boxShadow: currentPage == index
                ? [
                    BoxShadow(
                      color: AppColors.glowColor.withValues(alpha: 0.6),
                      blurRadius: 10.0,
                      offset: const Offset(0, 0),
                    ),
                    BoxShadow(
                      color: AppColors.glowColor.withValues(alpha: 0.3),
                      blurRadius: 20.0,
                      offset: const Offset(0, 0),
                    ),
                  ]
                : null,
          ),
        ),
      ),
    );
  }
}
