import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension ResponsiveContext on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  // Breakpoints
  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;

  // High-density column counts as requested
  int get toolGridColumns {
    if (isMobile) return 3; // High density for mobile
    if (isTablet) return 4; // Professional grid for tablet
    return 6; // Wide layout for web/desktop
  }

  // Vertical height for the cards
  double get toolTileHeight {
    if (isMobile)
      return 85; // Slightly taller on mobile for 3-col vertical stacking
    return 75; // Compact horizontal-style for larger screens
  }
}

extension PlatformInfo on Object {
  bool get isWeb => kIsWeb;

  bool get isMobile =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  bool get isDesktop =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows);
}
