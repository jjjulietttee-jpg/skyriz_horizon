import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/shared/widgets/custom_elevated_button.dart';
import '../../../../core/shared/extensions/context_extensions.dart';
import '../widgets/onboarding_page.dart';
import '../widgets/page_indicator.dart';
import '../widgets/onboarding_page_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onNextPressed() async {
    if (_currentPage < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('has_seen_onboarding', true);
      if (!mounted) return;
      context.go('/menu');
    }
  }

  void _onSkipPressed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    if (!mounted) return;
    context.go('/menu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.8),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: onboardingPages.length,
                  itemBuilder: (context, index) {
                    return OnboardingPage(
                      pageData: onboardingPages[index],
                    );
                  },
                ),
              ),
              Padding(
                padding: context.defaultPadding,
                child: Column(
                  children: [
                    PageIndicator(
                      currentPage: _currentPage,
                      pageCount: onboardingPages.length,
                    ),
                    SizedBox(height: context.heightPercent(0.03)),
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            text: 'Skip',
                            onPressed: _onSkipPressed,
                          ),
                        ),
                        SizedBox(width: context.widthPercent(0.04)),
                        Expanded(
                          child: CustomElevatedButton(
                            text: _currentPage == onboardingPages.length - 1
                                ? 'Start'
                                : 'Next',
                            onPressed: _onNextPressed,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.heightPercent(0.02)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
