class OnboardingPageModel {
  final String title;
  final String subtitle;
  final String description;

  OnboardingPageModel({
    required this.title,
    required this.subtitle,
    required this.description,
  });
}

final List<OnboardingPageModel> onboardingPages = [
  OnboardingPageModel(
    title: 'Welcome',
    subtitle: 'Experience the Flow',
    description: 'Immerse yourself in motion',
  ),
  OnboardingPageModel(
    title: 'Navigate',
    subtitle: 'Master the Controls',
    description: 'Precision at your fingertips',
  ),
  OnboardingPageModel(
    title: 'Begin',
    subtitle: 'Start Your Journey',
    description: 'Adventure awaits',
  ),
];
