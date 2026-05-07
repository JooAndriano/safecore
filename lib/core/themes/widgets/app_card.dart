import 'package:flutter/material.dart';
import '../colors.dart';

/// SAFECORE Reusable Card Widget
/// Elevated card with customizable styling for emergency context
class AppCard extends StatelessWidget {
  /// Card content
  final Widget child;

  /// Card padding
  final EdgeInsets? padding;

  /// Card margin
  final EdgeInsets? margin;

  /// Card border radius
  final double borderRadius;

  /// Card elevation
  final double elevation;

  /// Card background color
  final Color? backgroundColor;

  /// Card border
  final Border? border;

  /// Whether card has gradient background
  final bool useGradient;

  /// Gradient colors (used when useGradient is true)
  final List<Color>? gradientColors;

  /// Tap callback
  final VoidCallback? onTap;

  /// Whether card shows pressed state on tap
  final bool interactive;

  /// Custom width
  final double? width;

  /// Full width card
  final bool fullWidth;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 12,
    this.elevation = 0,
    this.backgroundColor,
    this.border,
    this.useGradient = false,
    this.gradientColors,
    this.onTap,
    this.interactive = true,
    this.width,
    this.fullWidth = false,
  });

  // MARK: Computed Properties

  /// Effective padding
  EdgeInsets get _effectivePadding => padding ?? const EdgeInsets.all(16);

  /// Effective margin
  EdgeInsets get _effectiveMargin => margin ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 8);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = backgroundColor ?? (isDark ? AppColors.darkSurface : AppColors.lightSurface);

    Widget card = Container(
      width: fullWidth ? double.infinity : width,
      decoration: BoxDecoration(
        color: useGradient && gradientColors != null
            ? null
            : cardBg,
        gradient: useGradient
            ? LinearGradient(
                colors: gradientColors ?? [AppColors.darkSurface, AppColors.darkSurfaceVariant],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: _effectivePadding,
        child: child,
      ),
    );

    if (interactive) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: card,
        ),
      );
    }

    if (fullWidth) {
      card = Padding(
        padding: _effectiveMargin,
        child: card,
      );
    }

    return card;
  }

  // MARK: Factory Methods

  /// Standard dark theme card
  factory AppCard.dark({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    VoidCallback? onTap,
    bool fullWidth = false,
    double? width,
  }) {
    return AppCard(
      key: key,
      child: child,
      padding: padding,
      backgroundColor: AppColors.darkSurface,
      onTap: onTap,
      fullWidth: fullWidth,
      width: width,
    );
  }

  /// Light theme card
  factory AppCard.light({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    VoidCallback? onTap,
    bool fullWidth = false,
    double? width,
  }) {
    return AppCard(
      key: key,
      child: child,
      padding: padding,
      backgroundColor: AppColors.lightSurface,
      onTap: onTap,
      fullWidth: fullWidth,
      width: width,
    );
  }

  /// Elevated card with shadow
  factory AppCard.elevated({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    double elevation = 4,
    VoidCallback? onTap,
    bool fullWidth = false,
  }) {
    return AppCard(
      key: key,
      child: child,
      padding: padding,
      elevation: elevation,
      onTap: onTap,
      fullWidth: fullWidth,
    );
  }

  /// Gradient card with emergency red-orange gradient
  factory AppCard.gradient({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    List<Color>? gradientColors,
    VoidCallback? onTap,
    bool fullWidth = false,
  }) {
    return AppCard(
      key: key,
      child: child,
      padding: padding,
      useGradient: true,
      gradientColors: gradientColors ?? [AppColors.emergencyRed, AppColors.emergencyOrange],
      onTap: onTap,
      fullWidth: fullWidth,
    );
  }

  /// Outlined card with border
  factory AppCard.outlined({
    Key? key,
    required Widget child,
    EdgeInsets? padding,
    Color borderColor = AppColors.secondaryText,
    VoidCallback? onTap,
    bool fullWidth = false,
  }) {
    return AppCard(
      key: key,
      child: child,
      padding: padding,
      border: Border.all(color: borderColor, width: 1),
      onTap: onTap,
      fullWidth: fullWidth,
    );
  }
}

/// Card variant types for quick selection
enum AppCardVariant {
  standard,
  elevated,
  outlined,
  gradient,
}