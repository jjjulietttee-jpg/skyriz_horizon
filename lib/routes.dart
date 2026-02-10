import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/splash/presentation/screens/splash_screen.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/game/presentation/screens/game_screen.dart';
import 'features/profile/presentation/screens/profile_screen.dart';
import 'features/profile/presentation/screens/achievements_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SplashScreen(),
        transitionsBuilder: _buildPageTransition,
      ),
    ),
    GoRoute(
      path: '/onboarding',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const OnboardingScreen(),
        transitionsBuilder: _buildPageTransition,
      ),
    ),
    GoRoute(
      path: '/menu',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomeScreen(),
        transitionsBuilder: _buildPageTransition,
      ),
    ),
    GoRoute(
      path: '/game',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const GameScreen(),
        transitionsBuilder: _buildPageTransition,
      ),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const ProfileScreen(),
        transitionsBuilder: _buildPageTransition,
      ),
    ),
    GoRoute(
      path: '/achievements',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const AchievementsScreen(),
        transitionsBuilder: _buildPageTransition,
      ),
    ),
  ],
  errorBuilder: (context, state) => const HomeScreen(),
);

Widget _buildPageTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(
    opacity: animation,
    child: SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.1, 0.0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
      ),
      child: child,
    ),
  );
}
