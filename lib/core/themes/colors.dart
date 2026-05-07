import 'package:flutter/material.dart';

/// SAFECORE Color Palette
/// High contrast emergency colors with dark background theme
class AppColors {
  AppColors._();

  // MARK: Emergency Colors
  /// Primary emergency red - used for critical actions and alerts
  static const Color emergencyRed = Color(0xFFE94560);
  
  /// Secondary emergency orange - used for warnings and secondary actions
  static const Color emergencyOrange = Color(0xFFF5A623);
  
  /// Success green - used for confirmed/safe status
  static const Color successGreen = Color(0xFF34C759);
  
  /// Info blue - used for informational elements
  static const Color infoBlue = Color(0xFF007AFF);
  
  /// Warning yellow - used for caution indicators
  static const Color warningYellow = Color(0xFFFFCC00);

  // MARK: Dark Theme Colors
  /// Main dark background - primary screen background
  static const Color darkBackground = Color(0xFF1A1A2E);
  
  /// Dark surface - card and container backgrounds
  static const Color darkSurface = Color(0xFF16213E);
  
  /// Dark surface variant - elevated surfaces
  static const Color darkSurfaceVariant = Color(0xFF1F2B47);
  
  /// Dark overlay - for modal backgrounds
  static const Color darkOverlay = Color(0xCC000000);

  // MARK: Light Theme Colors
  /// Light background - primary screen background
  static const Color lightBackground = Color(0xFFF5F5F7);
  
  /// Light surface - card and container backgrounds
  static const Color lightSurface = Color(0xFFFFFFFF);
  
  /// Light surface variant - elevated surfaces
  static const Color lightSurfaceVariant = Color(0xFFE5E5EA);
  
  /// Light overlay - for modal backgrounds
  static const Color lightOverlay = Color(0x99000000);

  // MARK: Text Colors (Dark Theme)
  /// Primary text color - main content text
  static const Color lightText = Color(0xFFFFFFFF);
  
  /// Secondary text color - descriptions and labels
  static const Color secondaryText = Color(0xFFB0B0B0);
  
  /// Tertiary text color - captions and hints
  static const Color tertiaryText = Color(0xFF8E8E93);
  
  /// Inverse text - for use on colored backgrounds
  static const Color inverseText = Color(0xFF1A1A2E);

  // MARK: Semantic Colors
  /// Primary color for branding and key elements
  static const Color primary = emergencyRed;

  /// Danger/error color
  static const Color danger = emergencyRed;
  
  /// Warning color
  static const Color warning = emergencyOrange;
  
  /// Success/confirmed color
  static const Color success = successGreen;
  
  /// Info/neutral color
  static const Color info = infoBlue;

  // MARK: Gradient Colors
  /// Primary gradient - red to orange for primary actions
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [emergencyRed, emergencyOrange],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  /// Emergency gradient - deep red to bright red
  static const LinearGradient emergencyGradient = LinearGradient(
    colors: [Color(0xFFC62828), emergencyRed],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // MARK: Color Scheme Extensions
  /// Dark color scheme for Material 3
  static ColorScheme darkColorScheme = const ColorScheme.dark(
    primary: emergencyRed,
    secondary: emergencyOrange,
    surface: darkSurface,
    surfaceContainerHighest: darkSurfaceVariant,
    onPrimary: lightText,
    onSecondary: darkBackground,
    onSurface: lightText,
    onError: lightText,
  );
  
  /// Light color scheme for Material 3
  static ColorScheme lightColorScheme = const ColorScheme.light(
    primary: emergencyRed,
    secondary: emergencyOrange,
    surface: lightSurface,
    surfaceContainerHighest: lightSurfaceVariant,
    onPrimary: inverseText,
    onSecondary: inverseText,
    onSurface: Color(0xFF1A1A2E),
    onError: lightText,
  );
}