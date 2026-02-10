import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  
  double get screenHeight => MediaQuery.of(this).size.height;
  
  Size get screenSize => MediaQuery.of(this).size;
  
  Orientation get orientation => MediaQuery.of(this).orientation;
  
  bool get isPortrait => orientation == Orientation.portrait;
  
  bool get isLandscape => orientation == Orientation.landscape;
  
  double widthPercent(double percentage) {
    return screenWidth * percentage;
  }
  
  double heightPercent(double percentage) {
    return screenHeight * percentage;
  }
  
  EdgeInsets get defaultPadding {
    return EdgeInsets.symmetric(
      horizontal: widthPercent(0.05),
      vertical: heightPercent(0.02),
    );
  }
  
  EdgeInsets get largePadding {
    return EdgeInsets.symmetric(
      horizontal: widthPercent(0.08),
      vertical: heightPercent(0.03),
    );
  }
  
  EdgeInsets get smallPadding {
    return EdgeInsets.symmetric(
      horizontal: widthPercent(0.03),
      vertical: heightPercent(0.01),
    );
  }
  
  double get largeTextSize => widthPercent(0.08);
  
  double get mediumTextSize => widthPercent(0.05);
  
  double get smallTextSize => widthPercent(0.04);
  
  double get buttonHeight => heightPercent(0.07);
  
  double get cardHeight => heightPercent(0.15);
}
