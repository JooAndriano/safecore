import 'package:flutter/material.dart';
import 'colors.dart';

/// SAFECORE Typography System
/// Bold, large text optimized for emergency situations
class AppTypography {
  AppTypography._();

  // MARK: Font Families
  /// Primary font family - Roboto (system default)
  static const String primaryFont = 'Roboto';
  
  /// Monospace font for codes and technical data
  static const String monospaceFont = 'Courier New';

  // MARK: Heading Styles
  /// H1: 32sp bold - Main page titles
  static const TextStyle h1 = TextStyle(
    fontFamily: primaryFont,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.lightText,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  /// H2: 24sp bold - Screen titles, section headers
  static const TextStyle h2 = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.lightText,
    height: 1.3,
    letterSpacing: 0.25,
  );
  
  /// H3: 20sp semi-bold - Card titles, subsection headers
  static const TextStyle h3 = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.lightText,
    height: 1.3,
    letterSpacing: 0.15,
  );

  // MARK: Body Styles
  /// Body Large: 18sp regular - Primary content text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.lightText,
    height: 1.5,
    letterSpacing: 0.2,
  );
  
  /// Body: 16sp regular - Standard body text
  static const TextStyle body = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.lightText,
    height: 1.5,
    letterSpacing: 0.25,
  );
  
  /// Body Small: 14sp regular - Secondary content
  static const TextStyle bodySmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    height: 1.4,
    letterSpacing: 0.25,
  );

  // MARK: Caption & Label Styles
  /// Caption: 14sp regular - Captions and labels
  static const TextStyle caption = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    height: 1.4,
    letterSpacing: 0.25,
  );
  
  /// Label: 12sp medium - Button labels, form labels
  static const TextStyle label = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryText,
    height: 1.4,
    letterSpacing: 0.4,
  );

  // MARK: Button Styles
  /// Button Large: 24sp bold - Emergency action buttons
  static const TextStyle buttonLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.lightText,
    height: 1.2,
    letterSpacing: 0.5,
  );
  
  /// Button: 16sp medium - Standard button text
  static const TextStyle button = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.lightText,
    height: 1.25,
    letterSpacing: 0.5,
  );
  
  /// Button Small: 14sp medium - Small button text
  static const TextStyle buttonSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.lightText,
    height: 1.25,
    letterSpacing: 0.4,
  );

  // MARK: Overline Style
  /// Overline: 12sp medium - Section dividers, overlines
  static const TextStyle overline = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.secondaryText,
    height: 1.4,
    letterSpacing: 1.0,
  );

  // MARK: Light Theme Typography
  /// H1 for light theme
  static const TextStyle h1Light = TextStyle(
    fontFamily: primaryFont,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.inverseText,
    height: 1.2,
    letterSpacing: -0.5,
  );
  
  /// H2 for light theme
  static const TextStyle h2Light = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.inverseText,
    height: 1.3,
    letterSpacing: 0.25,
  );
  
  /// Body for light theme
  static const TextStyle bodyLight = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.inverseText,
    height: 1.5,
    letterSpacing: 0.25,
  );

  // MARK: Text Theme (Material)
  /// Complete text theme for dark mode
  static const TextTheme darkTextTheme = TextTheme(
    displayLarge: h1,
    displayMedium: h2,
    displaySmall: h3,
    headlineLarge: h2,
    headlineMedium: h3,
    headlineSmall: bodyLarge,
    titleLarge: body,
    titleMedium: bodySmall,
    titleSmall: caption,
    bodyLarge: bodyLarge,
    bodyMedium: body,
    bodySmall: bodySmall,
    labelLarge: button,
    labelMedium: label,
    labelSmall: overline,
  );
  
  /// Complete text theme for light mode
  static const TextTheme lightTextTheme = TextTheme(
    displayLarge: h1Light,
    displayMedium: h2Light,
    displaySmall: h3,
    headlineLarge: h2Light,
    headlineMedium: h3,
    headlineSmall: bodyLarge,
    titleLarge: bodyLight,
    titleMedium: bodySmall,
    titleSmall: caption,
    bodyLarge: bodyLarge,
    bodyMedium: bodyLight,
    bodySmall: bodySmall,
    labelLarge: button,
    labelMedium: label,
    labelSmall: overline,
  );
}