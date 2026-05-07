import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

/// SAFECORE Theme Configuration
/// Complete theme data with light/dark mode support, Material 3
class AppTheme {
  AppTheme._();

  // MARK: Dark Theme

  /// Primary dark theme configuration
  /// High contrast, emergency colors (red, orange), dark background
  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.darkBackground,
        colorScheme: AppColors.darkColorScheme,

        // AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkBackground,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: AppTypography.primaryFont,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.lightText,
          ),
          iconTheme: IconThemeData(color: AppColors.lightText),
          toolbarTextStyle: AppTypography.body,
        ),

        // Card
        cardTheme: CardThemeData(
          color: AppColors.darkSurface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Elevated Button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.emergencyRed,
            foregroundColor: AppColors.lightText,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: AppTypography.buttonLarge,
          ),
        ),

        // Text Button
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.lightText,
            textStyle: const TextStyle(
              fontFamily: AppTypography.primaryFont,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Outlined Button
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.emergencyRed,
            side: const BorderSide(color: AppColors.emergencyRed, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: AppTypography.buttonLarge,
          ),
        ),

        // Icon
        iconTheme: const IconThemeData(
          color: AppColors.lightText,
          size: 24,
        ),
        primaryIconTheme: const IconThemeData(
          color: AppColors.emergencyRed,
        ),

        // Text Theme (Dark)
        textTheme: AppTypography.darkTextTheme,

        // Divider
        dividerTheme: const DividerThemeData(
          color: AppColors.secondaryText,
          thickness: 1,
          space: 32,
        ),

        // Bottom Navigation Bar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.darkSurface,
          selectedItemColor: AppColors.emergencyRed,
          unselectedItemColor: AppColors.secondaryText,
          type: BottomNavigationBarType.fixed,
        ),

        // Floating Action Button
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.emergencyRed,
          foregroundColor: AppColors.lightText,
          elevation: 4,
        ),

        // Dialog
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.darkSurface,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // Bottom Sheet
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.darkSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),

        // Drawer
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.darkSurface,
        ),

        // Input Decoration (TextField)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkSurfaceVariant,
          hintStyle: const TextStyle(
            fontFamily: AppTypography.primaryFont,
            color: AppColors.secondaryText,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.secondaryText, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.secondaryText, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.emergencyRed, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),

        // Checkbox
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.emergencyRed;
            }
            return AppColors.secondaryText;
          }),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        // Radio
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.emergencyRed;
            }
            return AppColors.secondaryText;
          }),
        ),

        // Switch
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.emergencyRed;
            }
            return AppColors.secondaryText;
          }),
          trackOutlineColor: WidgetStateProperty.resolveWith((states) {
            return AppColors.secondaryText.withValues(alpha: 0.5);
          }),
        ),

        // Snackbar
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.darkSurface,
          contentTextStyle: const TextStyle(
            fontFamily: AppTypography.primaryFont,
            color: AppColors.lightText,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Popup Menu
        popupMenuTheme: const PopupMenuThemeData(
          color: AppColors.darkSurface,
          elevation: 8,
        ),

        // Tooltip
        tooltipTheme: TooltipThemeData(
          textStyle: const TextStyle(
            fontFamily: AppTypography.primaryFont,
            fontSize: 14,
            color: AppColors.lightText,
          ),
        ),
      );

      // MARK: Light Theme

  /// Primary light theme configuration
  /// Clean, modern design with emergency accent colors
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.lightBackground,
        colorScheme: AppColors.lightColorScheme,

        // AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.lightSurface,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: AppTypography.primaryFont,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.inverseText,
          ),
          iconTheme: IconThemeData(color: AppColors.inverseText),
          toolbarTextStyle: AppTypography.bodyLight,
        ),

        // Card
        cardTheme: CardThemeData(
          color: AppColors.lightSurface,
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),

        // Elevated Button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.emergencyRed,
            foregroundColor: AppColors.inverseText,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: AppTypography.buttonLarge,
          ),
        ),

        // Text Button
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.inverseText,
            textStyle: const TextStyle(
              fontFamily: AppTypography.primaryFont,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Outlined Button
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.emergencyRed,
            side: const BorderSide(color: AppColors.emergencyRed, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: AppTypography.buttonLarge,
          ),
        ),

        // Icon
        iconTheme: const IconThemeData(
          color: AppColors.inverseText,
          size: 24,
        ),
        primaryIconTheme: const IconThemeData(
          color: AppColors.emergencyRed,
        ),

        // Text Theme (Light)
        textTheme: AppTypography.lightTextTheme,

        // Divider
        dividerTheme: const DividerThemeData(
          color: AppColors.secondaryText,
          thickness: 1,
          space: 32,
        ),

        // Bottom Navigation Bar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.lightSurface,
          selectedItemColor: AppColors.emergencyRed,
          unselectedItemColor: AppColors.secondaryText,
          type: BottomNavigationBarType.fixed,
        ),

        // Floating Action Button
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.emergencyRed,
          foregroundColor: AppColors.inverseText,
          elevation: 4,
        ),

        // Dialog
        dialogTheme: DialogThemeData(
          backgroundColor: AppColors.lightSurface,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),

        // Bottom Sheet
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: AppColors.lightSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
        ),

        // Drawer
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.lightSurface,
        ),

        // Input Decoration (TextField)
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.lightSurfaceVariant,
          hintStyle: const TextStyle(
            fontFamily: AppTypography.primaryFont,
            color: AppColors.secondaryText,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.secondaryText, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.secondaryText, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.emergencyRed, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),

        // Checkbox
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.emergencyRed;
            }
            return AppColors.secondaryText;
          }),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        // Radio
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.emergencyRed;
            }
            return AppColors.secondaryText;
          }),
        ),

        // Switch
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.emergencyRed;
            }
            return AppColors.secondaryText;
          }),
          trackOutlineColor: WidgetStateProperty.resolveWith((states) {
            return AppColors.secondaryText.withValues(alpha: 0.5);
          }),
        ),

        // Snackbar
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.lightSurface,
          contentTextStyle: const TextStyle(
            fontFamily: AppTypography.primaryFont,
            color: AppColors.inverseText,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),

        // Popup Menu
        popupMenuTheme: const PopupMenuThemeData(
          color: AppColors.lightSurface,
          elevation: 8,
        ),

        // Tooltip
        tooltipTheme: TooltipThemeData(
          textStyle: const TextStyle(
            fontFamily: AppTypography.primaryFont,
            fontSize: 14,
            color: AppColors.inverseText,
          ),
        ),
      );

  // MARK: Utility Methods

  /// Get theme based on brightness
  static ThemeData getTheme(Brightness brightness) {
    return brightness == Brightness.dark ? darkTheme : lightTheme;
  }

  /// Toggle between light and dark themes
  static Brightness toggleBrightness(Brightness current) {
    return current == Brightness.dark ? Brightness.light : Brightness.dark;
  }
}

/// Custom button themes for AppButton widget
class AppButtonTheme {
  static final ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.emergencyRed,
    foregroundColor: AppColors.lightText,
    elevation: 2,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}