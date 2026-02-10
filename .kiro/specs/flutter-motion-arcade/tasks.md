# Implementation Plan: Flutter Motion Arcade Application

## Overview

This implementation plan breaks down the Flutter motion-based arcade application into discrete coding tasks. The application follows clean architecture with a focus on custom UI components, adaptive layouts, and premium visual styling. Each task builds incrementally, ensuring all components are integrated and functional.

The implementation prioritizes core structure and navigation first, then builds out custom widgets, followed by feature screens, and finally visual polish and animations.

## Tasks

- [x] 1. Project setup and core structure
  - Create Flutter project with clean architecture folder structure
  - Set up core/shared directories: widgets, extensions, utils, theme
  - Set up features directories: onboarding, home, game, profile with presentation subdirectories
  - Add dependencies to pubspec.yaml: go_router, flutter_bloc, shared_preferences
  - Add bg.png asset to assets/images/ and configure in pubspec.yaml
  - _Requirements: 10.1, 10.2, 10.3, 10.4, 10.5, 10.6, 10.7, 10.8, 13.1, 13.2_

- [x] 2. Theme system and color configuration
  - Create core/shared/theme/app_colors.dart with color constants and gradients
  - Create core/shared/theme/app_text_styles.dart with adaptive text styles including glow and shadow effects
  - Create core/shared/theme/app_theme.dart with ThemeData configuration
  - Create core/shared/utils/constants.dart for app-wide constants
  - Create core/shared/extensions/context_extensions.dart for MediaQuery helpers
  - _Requirements: 7.2, 7.5, 7.6, 8.1_

- [x] 3. Core custom widgets
  - [x] 3.1 Implement CustomText widget
    - Create core/shared/widgets/custom_text.dart
    - Implement adaptive font sizing using MediaQuery
    - Add glow effects using multiple shadow layers
    - Add drop shadow effects
    - Support gradient text via ShaderMask
    - _Requirements: 6.6, 6.7, 6.8, 6.9, 7.5, 7.6_
  
  - [x] 3.2 Implement CustomElevatedButton widget
    - Create core/shared/widgets/custom_elevated_button.dart
    - Implement adaptive sizing with Flexible/Expanded support
    - Add scale animation on tap (AnimationController)
    - Apply gradient background with LinearGradient
    - Add shadow effects with elevation
    - Use custom BorderRadius for non-standard shapes
    - Add glow effect on press
    - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5, 7.7_
  
  - [x] 3.3 Implement CardWidget component
    - Create core/shared/widgets/card_widget.dart
    - Add fade-in animation on mount (AnimationController)
    - Add slide-up animation on mount
    - Implement hover scale effect
    - Apply gradient background with opacity
    - Add soft shadows
    - Use custom rounded corners
    - _Requirements: 6.10, 6.11, 6.12, 7.7_
  
  - [x] 3.4 Implement CustomPopup widget
    - Create core/shared/widgets/custom_popup.dart
    - Implement modal dialog with showDialog
    - Add backdrop blur effect
    - Add fade-in and scale animations
    - Support custom title, content, and action buttons
    - Make dismissible on backdrop tap
    - _Requirements: 6.13, 6.14, 6.15_

- [x] 4. Navigation system
  - Create routes.dart with GoRouter configuration
  - Define routes: /onboarding, /menu, /game, /profile
  - Set initialLocation to /onboarding
  - Implement errorBuilder redirecting to HomeScreen
  - Add page transition animations (fade and slide)
  - _Requirements: 5.1, 5.6, 5.7, 13.3_

- [ ] 5. Onboarding feature
  - [x] 5.1 Create onboarding data model
    - Create features/onboarding/presentation/widgets/onboarding_page_model.dart
    - Define OnboardingPageModel class with title, subtitle, description
    - Create list of 3 placeholder onboarding pages with neutral terminology
    - _Requirements: 1.4, 11.8_
  
  - [ ] 5.2 Implement PageIndicator widget
    - Create features/onboarding/presentation/widgets/page_indicator.dart
    - Display 3 dots representing pages
    - Highlight current page with different color/size
    - Use adaptive sizing
    - _Requirements: 1.8, 8.1_
  
  - [x] 5.3 Implement OnboardingPage widget
    - Create features/onboarding/presentation/widgets/onboarding_page.dart
    - Use Column with Expanded/Flexible for layout
    - Display large title using CustomText with glow
    - Display subtitle using CustomText
    - Display abstract visual block using CardWidget
    - Apply generous padding using EdgeInsets
    - _Requirements: 1.5, 1.10, 8.4_
  
  - [x] 5.4 Implement OnboardingScreen
    - Create features/onboarding/presentation/screens/onboarding_screen.dart
    - Use PageView.builder with PageController (NOT Slivers)
    - Manage current page index with setState
    - Add Next button (CustomElevatedButton) that advances pages
    - Add Skip button (CustomElevatedButton) that navigates to /menu
    - Add PageIndicator at bottom
    - Navigate to /menu on completion (last page Next button)
    - Apply bg.png background via BoxDecoration
    - Use adaptive layout with no fixed sizes
    - _Requirements: 1.1, 1.2, 1.3, 1.4, 1.6, 1.7, 1.8, 1.10, 1.11, 1.12, 2.5, 9.1_

- [ ] 6. Home screen feature
  - [ ] 6.1 Implement PlayButton widget
    - Create features/home/presentation/widgets/play_button.dart
    - Use CustomElevatedButton with extra-large sizing
    - Apply prominent gradient and glow effects
    - Add onPressed callback for navigation
    - _Requirements: 2.2, 7.4_
  
  - [ ] 6.2 Implement QuickAccessButton widget
    - Create features/home/presentation/widgets/quick_access_button.dart
    - Use CustomElevatedButton with medium sizing
    - Accept label and onPressed parameters
    - Apply consistent styling
    - _Requirements: 2.3_
  
  - [ ] 6.3 Implement HomeScreen
    - Create features/home/presentation/screens/home_screen.dart
    - Use CustomScrollView with Slivers
    - Add SliverAppBar with bg.png background and parallax effect
    - Use ScrollController for parallax calculations
    - Add SliverPadding for content spacing
    - Use SliverToBoxAdapter for main content
    - Display large title with CustomText and glow effects
    - Add PlayButton that navigates to /game using context.push
    - Add Row with QuickAccessButton for Profile and Achievements
    - Profile button navigates to /profile using context.push
    - Use adaptive layout with no fixed sizes
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.9, 5.2, 7.11, 9.2_

- [ ] 7. Game screen feature
  - [ ] 7.1 Implement GamePlaceholder widget
    - Create features/game/presentation/widgets/game_placeholder.dart
    - Display large "Game" text using CustomText
    - Use CardWidget for visual structure
    - Apply adaptive sizing
    - _Requirements: 3.1_
  
  - [ ] 7.2 Implement GameScreen
    - Create features/game/presentation/screens/game_screen.dart
    - Use CustomScrollView with Slivers
    - Add SliverAppBar with bg.png background
    - Use SliverFillRemaining for content
    - Add GamePlaceholder widget
    - Add large Back/Exit button (CustomElevatedButton)
    - Implement back navigation: check Navigator.canPop(), use context.pop() or fallback to context.push('/menu')
    - Use adaptive layout with no fixed sizes
    - _Requirements: 3.1, 3.2, 3.3, 3.5, 3.6, 3.7, 3.8, 5.3, 5.4_

- [ ] 8. Profile screen feature
  - [ ] 8.1 Create user storage service
    - Create features/profile/data/user_storage.dart
    - Implement saveUsername using SharedPreferences
    - Implement getUsername using SharedPreferences
    - Implement isFirstVisit using SharedPreferences
    - Implement setFirstVisitComplete using SharedPreferences
    - Add error handling with try-catch
    - _Requirements: 4.5_
  
  - [ ] 8.2 Create achievement model and placeholder data
    - Create features/profile/domain/achievement_model.dart
    - Define AchievementModel class with id, title, description, isUnlocked
    - Create list of 4 placeholder achievements with neutral terminology
    - _Requirements: 4.2, 11.8_
  
  - [ ] 8.3 Implement UsernameInputPopup widget
    - Create features/profile/presentation/widgets/username_input_popup.dart
    - Use CustomPopup with TextField for username input
    - Add validation: non-empty, 2-20 characters
    - Display validation errors
    - Call saveUsername on confirm
    - _Requirements: 4.3, 4.4, 4.5_
  
  - [ ] 8.4 Implement AchievementCard widget
    - Create features/profile/presentation/widgets/achievement_card.dart
    - Use CardWidget as base
    - Display achievement title and description using CustomText
    - Show locked/unlocked state visually
    - Apply adaptive sizing
    - _Requirements: 4.2, 4.8_
  
  - [ ] 8.5 Implement ProfileScreen
    - Create features/profile/presentation/screens/profile_screen.dart
    - Use CustomScrollView with Slivers
    - Add SliverAppBar with bg.png background
    - Use SliverList for achievements
    - Check isFirstVisit in initState
    - Show UsernameInputPopup if first visit
    - Display username in header using CustomText
    - Add edit button for username (shows popup again)
    - Display achievement cards in grid using SliverGrid
    - Use adaptive layout with no fixed sizes
    - _Requirements: 4.1, 4.2, 4.3, 4.6, 4.7, 4.9, 4.10_

- [ ] 9. Main app configuration
  - Update main.dart to use MaterialApp.router with GoRouter
  - Set router to the configured GoRouter instance
  - Configure theme using AppTheme
  - Set debugShowCheckedModeBanner to false
  - Ensure no comments in code
  - _Requirements: 5.1, 13.3_

- [ ] 10. Checkpoint - Verify core functionality
  - Run app and verify onboarding displays with 3 pages
  - Verify Next and Skip buttons navigate correctly
  - Verify HomeScreen displays with Play and quick access buttons
  - Verify navigation to GameScreen and ProfileScreen works
  - Verify back navigation works with fallback to /menu
  - Verify username popup appears on first profile visit
  - Verify all screens use bg.png background
  - Ensure all tests pass, ask the user if questions arise.

- [ ] 11. Visual polish and animations
  - [ ] 11.1 Enhance button animations
    - Add hover effects to all CustomElevatedButton instances
    - Tune animation durations and curves
    - Add subtle pulse animation to Play button
    - _Requirements: 6.3_
  
  - [ ] 11.2 Enhance card animations
    - Add stagger delay between achievement cards
    - Tune fade-in and slide-up timings
    - Add subtle hover scale effect
    - _Requirements: 6.11_
  
  - [ ] 11.3 Enhance parallax effects
    - Tune parallax offset multiplier for HomeScreen
    - Add parallax to GameScreen and ProfileScreen
    - Ensure smooth scrolling performance
    - _Requirements: 7.11_
  
  - [ ] 11.4 Enhance text effects
    - Tune glow blur radius and color intensity
    - Adjust shadow offsets for depth
    - Ensure text remains readable on all backgrounds
    - _Requirements: 7.5, 7.6_

- [ ] 12. Code quality and constraints verification
  - [ ] 12.1 Remove all code comments
    - Search entire codebase for // and /* */ comments
    - Remove all comments while ensuring code remains clear
    - _Requirements: 12.1, 12.2_
  
  - [ ] 12.2 Verify terminology constraints
    - Search codebase for prohibited terms: casino, gambling, betting, luck, brand names, app numbers
    - Replace any found terms with neutral alternatives
    - Verify all UI labels are neutral and universal
    - _Requirements: 11.1, 11.2, 11.3, 11.4, 11.5, 11.6, 11.7, 11.8_
  
  - [ ] 12.3 Verify no prohibited features
    - Verify no daily challenges implementation exists
    - Verify no streak systems implementation exists
    - Verify no reward systems implementation exists
    - Verify no Settings screen exists
    - Verify no theme/sound/vibration toggles exist
    - _Requirements: 11.11, 11.12, 11.13, 11.14, 11.15, 11.16, 11.17_
  
  - [ ] 12.4 Verify adaptive layout
    - Search for hardcoded pixel values in sizing
    - Verify all sizing uses MediaQuery, Expanded, Flexible, constraints, or LayoutBuilder
    - Test on multiple screen sizes
    - Test orientation changes
    - _Requirements: 8.1, 8.7, 8.8_
  
  - [ ] 12.5 Verify architecture compliance
    - Verify all shared widgets are in core/shared/widgets
    - Verify all feature code is in features/{feature}/presentation
    - Verify screen files contain only UI composition
    - Verify no business logic in presentation layer
    - Verify routes are defined in routes.dart
    - _Requirements: 10.1, 10.2, 10.6, 10.7, 10.8, 10.9, 10.10, 10.11, 10.12_

- [ ] 13. Final checkpoint - Complete verification
  - Run app on multiple device sizes (phone, tablet)
  - Test all navigation flows
  - Test username entry and persistence
  - Verify all visual effects (glow, shadows, gradients, animations)
  - Verify bg.png displays on all screens
  - Verify no fixed pixel sizes used
  - Verify no comments in code
  - Verify no prohibited terminology
  - Verify no tests/ directory exists
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- This is a structural skeleton implementation - screens use placeholder content
- No tests or tests/ directory should be created per requirements
- All code must be comment-free (no // or /* */)
- All sizing must be adaptive (no fixed pixel values)
- All terminology must be neutral and universal
- Each task builds incrementally on previous tasks
- Checkpoints ensure validation at key milestones
- Focus on clean architecture with separation of concerns
