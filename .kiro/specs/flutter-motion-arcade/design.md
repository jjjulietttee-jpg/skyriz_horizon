# Design Document: Flutter Motion Arcade Application

## Overview

This design document specifies the architecture and implementation details for a motion-based interactive arcade experience mobile application built with Flutter. The application follows clean architecture principles with clear separation between data, domain, and presentation layers. The design emphasizes adaptive UI, custom reusable components, and a premium motion-inspired visual aesthetic.

The application serves as a structural skeleton with placeholder screens and navigation infrastructure, ready for future game logic implementation. All UI components are adaptive and custom-styled, avoiding default Flutter widgets in favor of branded, animated components with glow, shadow, and gradient effects.

## Architecture

### Clean Architecture Layers

The application follows a three-layer clean architecture pattern:

**Presentation Layer:**
- Screens: UI composition and widget assembly
- Widgets: Reusable UI components
- Bloc: State management for business logic (placeholder structure)
- Controllers: PageController, ScrollController for UI state

**Domain Layer:**
- Placeholder for future business logic
- Use cases for game mechanics (to be implemented)
- Entity models (to be implemented)

**Data Layer:**
- Placeholder for future data sources
- Repository implementations (to be implemented)
- Local storage for username (SharedPreferences or similar)

### Project Structure

```
lib/
├── core/
│   └── shared/
│       ├── widgets/
│       │   ├── custom_elevated_button.dart
│       │   ├── custom_text.dart
│       │   ├── card_widget.dart
│       │   └── custom_popup.dart
│       ├── extensions/
│       │   └── context_extensions.dart
│       ├── utils/
│       │   └── constants.dart
│       └── theme/
│           ├── app_colors.dart
│           ├── app_text_styles.dart
│           └── app_theme.dart
├── features/
│   ├── onboarding/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── onboarding_screen.dart
│   │       └── widgets/
│   │           ├── onboarding_page.dart
│   │           └── page_indicator.dart
│   ├── home/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── home_screen.dart
│   │       └── widgets/
│   │           ├── play_button.dart
│   │           └── quick_access_button.dart
│   ├── game/
│   │   └── presentation/
│   │       ├── screens/
│   │       │   └── game_screen.dart
│   │       └── widgets/
│   │           └── game_placeholder.dart
│   └── profile/
│       └── presentation/
│           ├── screens/
│           │   └── profile_screen.dart
│           └── widgets/
│               ├── achievement_card.dart
│               └── username_input_popup.dart
├── main.dart
└── routes.dart
```

## Components and Interfaces

### Navigation System (routes.dart)

The navigation system uses go_router for declarative routing:

```dart
final GoRouter router = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: '/menu',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/game',
      builder: (context, state) => GameScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
  ],
  errorBuilder: (context, state) => HomeScreen(),
);
```

Navigation methods:
- Forward navigation: `context.push('/route')`
- Backward navigation: `context.pop()`
- Fallback: If pop fails, redirect to '/menu'

### Core Shared Widgets

#### CustomElevatedButton

A highly customizable button widget with animations, shadows, and non-standard shapes.

**Interface:**
```dart
class CustomElevatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  
  CustomElevatedButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.elevation,
    this.padding,
    this.borderRadius,
  });
}
```

**Behavior:**
- Adaptive sizing using Flexible/Expanded parent constraints
- Scale animation on tap (0.95 scale)
- Gradient background with shimmer effect
- Shadow with blur radius
- Custom shape (rounded corners with asymmetric radius)
- Glow effect on hover/press

#### CustomText

A text widget with glow and shadow effects for premium appearance.

**Interface:**
```dart
class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final bool enableGlow;
  final bool enableShadow;
  final TextAlign? textAlign;
  
  CustomText({
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.enableGlow = true,
    this.enableShadow = true,
    this.textAlign,
  });
}
```

**Behavior:**
- Adaptive font sizing based on screen width
- Glow effect using multiple shadow layers with blur
- Drop shadow for depth
- Supports gradient text via shader mask

#### CardWidget

An animated card component for displaying content blocks.

**Interface:**
```dart
class CardWidget extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  
  CardWidget({
    required this.child,
    this.padding,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
  });
}
```

**Behavior:**
- Fade-in animation on mount
- Slide-up animation on mount
- Hover scale effect (1.02 scale)
- Gradient background with opacity
- Soft shadows
- Custom rounded corners

#### CustomPopup

A modal dialog for user input with custom styling.

**Interface:**
```dart
class CustomPopup extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String confirmText;
  final String cancelText;
  
  CustomPopup({
    required this.title,
    required this.content,
    this.onConfirm,
    this.onCancel,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
  });
}
```

**Behavior:**
- Centered modal with backdrop blur
- Fade-in animation
- Scale animation (0.8 to 1.0)
- Custom styled buttons
- Dismissible on backdrop tap

### Feature Screens

#### OnboardingScreen

**State Management:**
- PageController for page navigation
- Current page index (setState)
- Animation controllers for transitions

**Layout:**
- PageView.builder with 3 pages
- NO Sliver widgets
- Column-based layout with Expanded/Flexible
- Page indicator at bottom
- Next and Skip buttons

**Page Structure:**
```dart
class OnboardingPage {
  final String title;
  final String subtitle;
  final Widget visualBlock;
}
```

Each page contains:
- Large title (CustomText with glow)
- Subtitle (CustomText)
- Abstract visual block (CardWidget with placeholder content)
- Generous padding and spacing

**Navigation Logic:**
- Next button: Advance to next page or navigate to /menu on last page
- Skip button: Navigate directly to /menu
- Page indicator: Show current position (3 dots)

#### HomeScreen

**State Management:**
- ScrollController for parallax effects
- Animation controllers for button hover states

**Layout:**
- CustomScrollView with Slivers
- SliverAppBar with bg.png background and parallax
- SliverPadding for content spacing
- SliverToBoxAdapter for main content

**Content Structure:**
- Large title with glow effect
- Play button (largest, central focus)
- Quick access buttons (Profile, Achievements) in row
- All buttons use CustomElevatedButton

**Visual Effects:**
- Parallax background on scroll
- Button hover animations
- Glow effects on titles
- Gradient overlays

#### GameScreen

**State Management:**
- ScrollController for sliver scrolling
- Placeholder state for future game logic

**Layout:**
- CustomScrollView with Slivers
- SliverAppBar with bg.png background
- SliverFillRemaining for content

**Content:**
- Large "Game" placeholder text (CustomText)
- Back/Exit button (CustomElevatedButton)
- Placeholder cards for future game elements

**Navigation:**
- Back button: context.pop() or fallback to /menu

#### ProfileScreen

**State Management:**
- ScrollController for sliver scrolling
- Username state (stored locally)
- First visit flag (SharedPreferences)
- Achievement list (placeholder data)

**Layout:**
- CustomScrollView with Slivers
- SliverAppBar with bg.png background
- SliverList for achievements

**Content:**
- Username display (editable)
- Achievement cards (CardWidget) in grid
- Each card shows placeholder achievement data

**First Visit Logic:**
```dart
void checkFirstVisit() async {
  bool isFirstVisit = await getFirstVisitFlag();
  if (isFirstVisit) {
    showUsernamePopup();
    setFirstVisitFlag(false);
  }
}
```

**Username Popup:**
- CustomPopup with TextField
- Validation: non-empty, max 20 characters
- Save to local storage on confirm
- Display in profile header

## Data Models

### OnboardingPageModel

```dart
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
```

### AchievementModel

```dart
class AchievementModel {
  final String id;
  final String title;
  final String description;
  final bool isUnlocked;
  
  AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isUnlocked,
  });
}
```

### UserProfileModel

```dart
class UserProfileModel {
  final String username;
  final List<AchievementModel> achievements;
  
  UserProfileModel({
    required this.username,
    required this.achievements,
  });
}
```

## Theme System

### AppColors

```dart
class AppColors {
  static const Color primaryDark = Color(0xFF0A0E27);
  static const Color secondaryDark = Color(0xFF1A1F3A);
  static const Color accentBlue = Color(0xFF4A90E2);
  static const Color accentPurple = Color(0xFF7B68EE);
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color cardBackground = Color(0xFF252A45);
  static const Color glowColor = Color(0xFF6A9FFF);
  
  static LinearGradient primaryGradient = LinearGradient(
    colors: [accentBlue, accentPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static LinearGradient backgroundGradient = LinearGradient(
    colors: [primaryDark, secondaryDark],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
```

### AppTextStyles

```dart
class AppTextStyles {
  static TextStyle largeTitle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.08,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
      shadows: [
        Shadow(
          blurRadius: 20.0,
          color: AppColors.glowColor,
          offset: Offset(0, 0),
        ),
        Shadow(
          blurRadius: 10.0,
          color: AppColors.glowColor,
          offset: Offset(0, 0),
        ),
      ],
    );
  }
  
  static TextStyle subtitle(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.045,
      fontWeight: FontWeight.w500,
      color: AppColors.textSecondary,
    );
  }
  
  static TextStyle body(BuildContext context) {
    return TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.04,
      fontWeight: FontWeight.normal,
      color: AppColors.textPrimary,
    );
  }
}
```

### Adaptive Sizing Strategy

All sizing uses relative units based on screen dimensions:

```dart
class AdaptiveSize {
  static double width(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }
  
  static double height(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }
  
  static EdgeInsets padding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: width(context, 0.05),
      vertical: height(context, 0.02),
    );
  }
}
```

## Animation System

### Button Animations

```dart
class ButtonAnimationController {
  AnimationController scaleController;
  Animation<double> scaleAnimation;
  
  void onTapDown() {
    scaleController.forward();
  }
  
  void onTapUp() {
    scaleController.reverse();
  }
}
```

Scale range: 1.0 to 0.95
Duration: 100ms
Curve: Curves.easeInOut

### Card Animations

```dart
class CardAnimationController {
  AnimationController fadeController;
  AnimationController slideController;
  Animation<double> fadeAnimation;
  Animation<Offset> slideAnimation;
  
  void initState() {
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: fadeController, curve: Curves.easeIn),
    );
    
    slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: slideController, curve: Curves.easeOut),
    );
    
    fadeController.forward();
    slideController.forward();
  }
}
```

Duration: 400ms
Stagger delay: 100ms between cards

### Page Transition Animations

```dart
class PageTransitionBuilder {
  static Widget buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
```

### Parallax Scroll Effect

```dart
class ParallaxBackground extends StatelessWidget {
  final ScrollController scrollController;
  final String imagePath;
  
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        double offset = scrollController.hasClients 
          ? scrollController.offset * 0.5 
          : 0.0;
        
        return Transform.translate(
          offset: Offset(0, -offset),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
```

## Local Storage

### Username Storage

```dart
class UserStorage {
  static const String usernameKey = 'user_username';
  static const String firstVisitKey = 'first_visit';
  
  Future<void> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(usernameKey, username);
  }
  
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(usernameKey);
  }
  
  Future<bool> isFirstVisit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(firstVisitKey) ?? true;
  }
  
  Future<void> setFirstVisitComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(firstVisitKey, false);
  }
}
```

## Background Image Handling

All screens use bg.png as background:

**Method 1: BoxDecoration (for non-scrollable areas)**
```dart
Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/bg.png'),
      fit: BoxFit.cover,
    ),
  ),
  child: content,
)
```

**Method 2: SliverAppBar (for scrollable screens)**
```dart
SliverAppBar(
  expandedHeight: 200.0,
  flexibleSpace: FlexibleSpaceBar(
    background: Image.asset(
      'assets/images/bg.png',
      fit: BoxFit.cover,
    ),
  ),
)
```

## Placeholder Data

### Onboarding Pages

```dart
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
```

### Achievement Placeholders

```dart
final List<AchievementModel> placeholderAchievements = [
  AchievementModel(
    id: '1',
    title: 'First Flight',
    description: 'Complete your first session',
    isUnlocked: false,
  ),
  AchievementModel(
    id: '2',
    title: 'Altitude Master',
    description: 'Reach new heights',
    isUnlocked: false,
  ),
  AchievementModel(
    id: '3',
    title: 'Flow State',
    description: 'Achieve perfect control',
    isUnlocked: false,
  ),
  AchievementModel(
    id: '4',
    title: 'Momentum',
    description: 'Maintain consistent progress',
    isUnlocked: false,
  ),
];
```



## Correctness Properties

A property is a characteristic or behavior that should hold true across all valid executions of a system—essentially, a formal statement about what the system should do. Properties serve as the bridge between human-readable specifications and machine-verifiable correctness guarantees.

### Property 1: No Fixed Pixel Sizing

*For any* UI element in the application, the sizing SHALL use relative units (MediaQuery, Expanded, Flexible, constraints, LayoutBuilder) and SHALL NOT use hardcoded pixel values.

**Validates: Requirements 1.11, 2.9, 3.8, 4.10, 8.1**

### Property 2: Universal Background Image

*For all* screens (OnboardingScreen, HomeScreen, GameScreen, ProfileScreen), the background SHALL use the bg.png asset via BoxDecoration or SliverAppBar.

**Validates: Requirements 7.8**

### Property 3: Forward Navigation API

*For any* forward navigation action in the application, the Router SHALL use context.push(route) method.

**Validates: Requirements 5.2**

### Property 4: Backward Navigation API

*For any* backward navigation action in the application, the Router SHALL use context.pop() method.

**Validates: Requirements 5.3**

### Property 5: Username Storage Round-Trip

*For any* valid username string, storing the username and then retrieving it SHALL return the same username value.

**Validates: Requirements 4.5, 4.6**

### Property 6: Custom Widget Adaptive Sizing

*For all* custom widgets (CustomElevatedButton, CustomText, CardWidget), the sizing SHALL adapt proportionally when screen dimensions change.

**Validates: Requirements 6.2, 6.7**

### Property 7: Text Glow Effects

*For all* text elements rendered with CustomText where enableGlow is true, the text SHALL have multiple shadow layers configured to create a glow effect.

**Validates: Requirements 7.5**

### Property 8: Text Shadow Effects

*For all* text elements rendered with CustomText where enableShadow is true, the text SHALL have shadow properties configured.

**Validates: Requirements 7.6**

### Property 9: Gradient Effects

*For all* UI elements using custom styling (buttons, cards, backgrounds), gradient decorations SHALL be applied using LinearGradient.

**Validates: Requirements 7.7**

### Property 10: Layout Widget Usage

*For all* screens with adaptive layouts, the widget tree SHALL contain at least one of: Expanded, Flexible, LayoutBuilder, or constraint-based sizing widgets.

**Validates: Requirements 8.2, 8.3, 8.5**

### Property 11: Padding-Based Spacing

*For all* spacing between UI elements, the application SHALL use EdgeInsets padding rather than fixed-size SizedBox widgets.

**Validates: Requirements 8.4**

### Property 12: Responsive Layout Adaptation

*For any* screen orientation change or screen size change, all UI elements SHALL adjust their dimensions proportionally based on the new screen dimensions.

**Validates: Requirements 8.7, 8.8**

### Property 13: Prohibited Terminology Absence

*For all* code files, UI labels, and string literals in the application, the content SHALL NOT contain any of the following prohibited terms: brand names, app numbers, casino terminology, gambling terminology, betting terminology, or luck-based terminology.

**Validates: Requirements 11.1, 11.2, 11.3, 11.4, 11.5, 11.6, 11.7**

### Property 14: Neutral UI Labels

*For all* UI labels and text content, the terminology SHALL be neutral and avoid specific prohibited categories while remaining clear and descriptive.

**Validates: Requirements 11.8**

### Property 15: Prohibited Feature Absence

*For all* code files and features in the application, there SHALL NOT exist implementations of: daily challenges, streak systems, or reward systems.

**Validates: Requirements 11.11, 11.12, 11.13**

### Property 16: Code Comment Absence

*For all* Dart source files in the application, the code SHALL NOT contain single-line comments (//) or block comments (/* */).

**Validates: Requirements 12.1, 12.2**

### Property 17: Test File Absence

*For all* files and directories in the project, there SHALL NOT exist any test files or a tests/ directory.

**Validates: Requirements 12.4**

### Property 18: Business Logic Separation

*For all* screen files in the presentation layer, the files SHALL contain only UI composition code and SHALL NOT contain business logic implementations.

**Validates: Requirements 9.5, 10.11, 10.12**

### Property 19: Navigation History Maintenance

*For any* sequence of forward navigation actions, the Router SHALL maintain a history stack that allows backward navigation through the same sequence in reverse order.

**Validates: Requirements 5.7**

### Property 20: Custom Widget Non-Default Styling

*For all* instances of CustomElevatedButton and CardWidget, the styling SHALL use custom shapes, colors, and decorations rather than default Flutter button or card styling.

**Validates: Requirements 6.16**

### Property 21: Large UI Element Sizing

*For all* interactive UI elements (buttons, text, titles, icons), the size SHALL be at least 5% of the screen dimension (width or height as appropriate) to ensure large, accessible elements.

**Validates: Requirements 7.4**

### Property 22: Onboarding Page Structure

*For all* onboarding pages displayed in the PageView, each page SHALL contain a title widget, subtitle widget, and visual block widget.

**Validates: Requirements 1.5**

## Error Handling

### Navigation Errors

**Fallback Navigation:**
When context.pop() fails due to empty navigation history, the application SHALL catch the error and redirect to '/menu' route:

```dart
void navigateBack(BuildContext context) {
  if (Navigator.of(context).canPop()) {
    context.pop();
  } else {
    context.push('/menu');
  }
}
```

**Route Not Found:**
When an invalid route is requested, go_router's errorBuilder SHALL redirect to HomeScreen:

```dart
errorBuilder: (context, state) => HomeScreen(),
```

### Storage Errors

**Username Storage Failure:**
When SharedPreferences fails to save username, the application SHALL:
1. Log the error (if talker_flutter is configured)
2. Display a user-friendly error message via SnackBar
3. Allow retry of the save operation

```dart
Future<void> saveUsername(String username) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(usernameKey, username);
  } catch (e) {
    showErrorSnackBar('Failed to save username. Please try again.');
    rethrow;
  }
}
```

**Username Retrieval Failure:**
When SharedPreferences fails to retrieve username, the application SHALL:
1. Return null as the default value
2. Treat the user as a first-time visitor
3. Display the username input popup

### Widget Rendering Errors

**Image Loading Failure:**
When bg.png fails to load, the application SHALL:
1. Display a solid color background (AppColors.primaryDark)
2. Continue rendering other UI elements normally

```dart
decoration: BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/bg.png'),
    fit: BoxFit.cover,
    onError: (exception, stackTrace) {
      // Fallback to solid color handled by BoxDecoration
    },
  ),
  color: AppColors.primaryDark,
),
```

**Animation Controller Disposal:**
All AnimationController instances SHALL be properly disposed in the dispose() method to prevent memory leaks:

```dart
@override
void dispose() {
  scaleController.dispose();
  fadeController.dispose();
  slideController.dispose();
  super.dispose();
}
```

### Input Validation

**Username Validation:**
When user submits username in CustomPopup, the application SHALL validate:
1. Non-empty string (trim whitespace)
2. Maximum 20 characters
3. Minimum 2 characters

```dart
String? validateUsername(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Username cannot be empty';
  }
  if (value.trim().length < 2) {
    return 'Username must be at least 2 characters';
  }
  if (value.length > 20) {
    return 'Username must be 20 characters or less';
  }
  return null;
}
```

## Testing Strategy

### Overview

This application follows a dual testing approach combining unit tests and property-based tests. However, per the project requirements (Requirement 12.3, 12.4), NO tests or tests/ folder SHALL be included in the delivered codebase. This testing strategy documents the testing approach for future development phases when testing is enabled.

### Unit Testing Approach

Unit tests focus on specific examples, edge cases, and integration points:

**Widget Tests:**
- Verify specific widget presence (buttons, text, indicators)
- Test navigation actions trigger correct routes
- Verify popup displays on first profile visit
- Test username input validation with specific examples

**Example Unit Tests:**
- OnboardingScreen displays exactly 3 pages
- Next button advances to page 2 from page 1
- Skip button navigates to /menu from any page
- Play button navigates to /game
- Profile button navigates to /profile
- Back button calls context.pop()
- Username popup appears on first profile visit
- Empty username shows validation error
- Username "ab" (2 chars) passes validation
- Username with 21 characters fails validation

**Integration Tests:**
- Complete onboarding flow from start to HomeScreen
- Navigation from HomeScreen to GameScreen and back
- Username entry flow from first visit to display
- Route fallback when navigation history is empty

### Property-Based Testing Approach

Property-based tests verify universal properties across randomized inputs. Each property test SHALL run a minimum of 100 iterations.

**Testing Library:**
Use the `flutter_test` package with custom property test helpers, or integrate a property-based testing library if available for Flutter/Dart.

**Property Test Configuration:**
```dart
void propertyTest(String description, Function test, {int iterations = 100}) {
  for (int i = 0; i < iterations; i++) {
    test(i);
  }
}
```

**Property Test Examples:**

**Property 1: No Fixed Pixel Sizing**
- Generate random widget trees
- Verify all sizing uses MediaQuery, Expanded, Flexible, or constraints
- Tag: **Feature: flutter-motion-arcade, Property 1: No Fixed Pixel Sizing**

**Property 5: Username Storage Round-Trip**
- Generate random valid username strings (2-20 chars)
- Store each username
- Retrieve and verify it matches the stored value
- Tag: **Feature: flutter-motion-arcade, Property 5: Username Storage Round-Trip**

**Property 6: Custom Widget Adaptive Sizing**
- Generate random screen dimensions
- Render CustomElevatedButton, CustomText, CardWidget
- Verify sizes scale proportionally with screen size
- Tag: **Feature: flutter-motion-arcade, Property 6: Custom Widget Adaptive Sizing**

**Property 12: Responsive Layout Adaptation**
- Generate random screen sizes and orientations
- Render each screen
- Verify all elements adjust proportionally
- Tag: **Feature: flutter-motion-arcade, Property 12: Responsive Layout Adaptation**

**Property 13: Prohibited Terminology Absence**
- Scan all Dart files for prohibited terms
- Generate list of prohibited terms (casino, gambling, betting, luck, brand names)
- Verify no files contain any prohibited terms
- Tag: **Feature: flutter-motion-arcade, Property 13: Prohibited Terminology Absence**

**Property 16: Code Comment Absence**
- Scan all Dart files
- Verify no lines contain // or /* */ comment syntax
- Tag: **Feature: flutter-motion-arcade, Property 16: Code Comment Absence**

**Property 18: Business Logic Separation**
- Scan all screen files in presentation/screens
- Verify files contain only widget composition
- Verify no business logic patterns (complex calculations, data transformations)
- Tag: **Feature: flutter-motion-arcade, Property 18: Business Logic Separation**

### Test Organization

**Test File Structure (when testing is enabled):**
```
test/
├── unit/
│   ├── widgets/
│   │   ├── custom_elevated_button_test.dart
│   │   ├── custom_text_test.dart
│   │   ├── card_widget_test.dart
│   │   └── custom_popup_test.dart
│   ├── screens/
│   │   ├── onboarding_screen_test.dart
│   │   ├── home_screen_test.dart
│   │   ├── game_screen_test.dart
│   │   └── profile_screen_test.dart
│   └── navigation/
│       └── router_test.dart
├── property/
│   ├── adaptive_layout_property_test.dart
│   ├── navigation_property_test.dart
│   ├── storage_property_test.dart
│   ├── styling_property_test.dart
│   └── constraints_property_test.dart
└── integration/
    ├── onboarding_flow_test.dart
    ├── navigation_flow_test.dart
    └── profile_flow_test.dart
```

### Testing Balance

- **Unit tests:** Focus on specific examples and edge cases (20-30 tests)
- **Property tests:** Focus on universal properties across all inputs (22 properties × 100 iterations each)
- **Integration tests:** Focus on complete user flows (5-10 flows)

Avoid writing excessive unit tests for scenarios already covered by property tests. Property tests handle comprehensive input coverage through randomization.

### Manual Verification

Since automated tests are not included in the deliverable, the following manual verification checklist SHALL be used:

**Visual Verification:**
- [ ] All screens display bg.png background
- [ ] All text has visible glow/shadow effects
- [ ] All buttons have custom shapes and animations
- [ ] All cards have fade-in and slide-up animations
- [ ] UI adapts to different screen sizes (test on multiple devices)
- [ ] UI adapts to orientation changes

**Navigation Verification:**
- [ ] Onboarding completes and navigates to HomeScreen
- [ ] Play button navigates to GameScreen
- [ ] Profile button navigates to ProfileScreen
- [ ] Back buttons navigate to previous screen
- [ ] Back navigation falls back to HomeScreen when history is empty

**Functionality Verification:**
- [ ] Username popup appears on first profile visit
- [ ] Username can be entered and saved
- [ ] Username displays on profile screen after saving
- [ ] Username can be edited after initial entry
- [ ] Page indicator shows correct position in onboarding
- [ ] Next button advances through onboarding pages
- [ ] Skip button bypasses remaining onboarding pages

**Code Quality Verification:**
- [ ] No // or /* */ comments in code
- [ ] No tests/ directory exists
- [ ] No test files exist
- [ ] No fixed pixel sizes used (search for numeric literals in sizing)
- [ ] No prohibited terminology in code or UI
- [ ] All files organized according to clean architecture structure
- [ ] Screen files contain only UI composition
- [ ] Business logic separated from presentation

This testing strategy ensures comprehensive coverage while respecting the project constraint of not including tests in the deliverable codebase.
