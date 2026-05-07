import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../colors.dart';

/// SAFECORE Reusable Icon Widget
/// Consistent icon sizing and coloring for emergency context
class AppIcon extends StatelessWidget {
  /// Icon data (from IconData or FaIconData)
  final dynamic iconData;

  /// Asset path for image icons
  final String? assetPath;

  /// Icon size
  final double? size;

  /// Icon color
  final Color? color;

  /// Icon alignment
  final AlignmentGeometry? alignment;

  const AppIcon({
    super.key,
    dynamic icon,
    dynamic iconData,
    this.assetPath,
    this.size,
    this.color,
    this.alignment,
  }) : iconData = iconData ?? icon;

  // MARK: Computed Properties

  /// Effective icon size
  double get _size => size ?? 24;

  /// Effective icon color
  Color get _color => color ?? AppColors.lightText;

  @override
  Widget build(BuildContext context) {
    if (assetPath != null) {
      return Image.asset(
        assetPath!,
        width: _size,
        height: _size,
        color: _color,
        alignment: alignment ?? Alignment.center,
      );
    }

    if (iconData is FaIconData) {
      return FaIcon(
        iconData as FaIconData,
        size: _size,
        color: _color,
      );
    }

    return Icon(
      iconData,
      size: _size,
      color: _color,
    );
  }

  // MARK: Factory Methods

  /// Small icon (16sp)
  factory AppIcon.small({
    Key? key,
    dynamic icon,
    dynamic iconData,
    String? assetPath,
    Color? color,
  }) {
    return AppIcon(
      key: key,
      iconData: iconData ?? icon,
      assetPath: assetPath,
      size: 16,
      color: color,
    );
  }

  /// Medium icon (24sp) - default
  factory AppIcon.medium({
    Key? key,
    dynamic icon,
    dynamic iconData,
    String? assetPath,
    Color? color,
  }) {
    return AppIcon(
      key: key,
      iconData: iconData ?? icon,
      assetPath: assetPath,
      size: 24,
      color: color,
    );
  }

  /// Large icon (32sp)
  factory AppIcon.large({
    Key? key,
    dynamic icon,
    dynamic iconData,
    String? assetPath,
    Color? color,
  }) {
    return AppIcon(
      key: key,
      iconData: iconData ?? icon,
      assetPath: assetPath,
      size: 32,
      color: color,
    );
  }

  /// Extra large icon (48sp)
  factory AppIcon.xLarge({
    Key? key,
    dynamic icon,
    dynamic iconData,
    String? assetPath,
    Color? color,
  }) {
    return AppIcon(
      key: key,
      iconData: iconData ?? icon,
      assetPath: assetPath,
      size: 48,
      color: color,
    );
  }

  /// Emergency red icon
  factory AppIcon.emergency({
    Key? key,
    dynamic icon,
    dynamic iconData,
    String? assetPath,
    double? size,
  }) {
    return AppIcon(
      key: key,
      iconData: iconData ?? icon,
      assetPath: assetPath,
      size: size,
      color: AppColors.emergencyRed,
    );
  }

  /// Warning orange icon
  factory AppIcon.warning({
    Key? key,
    dynamic icon,
    dynamic iconData,
    String? assetPath,
    double? size,
  }) {
    return AppIcon(
      key: key,
      iconData: iconData ?? icon,
      assetPath: assetPath,
      size: size,
      color: AppColors.emergencyOrange,
    );
  }

  /// Success green icon
  factory AppIcon.success({
    Key? key,
    dynamic icon,
    dynamic iconData,
    String? assetPath,
    double? size,
  }) {
    return AppIcon(
      key: key,
      iconData: iconData ?? icon,
      assetPath: assetPath,
      size: size,
      color: AppColors.successGreen,
    );
  }
}

/// Standard icon sizes for quick reference
class AppIconSizes {
  AppIconSizes._();

  static const double small = 16;
  static const double medium = 24;
  static const double large = 32;
  static const double xLarge = 48;
}

/// Standard icon colors for quick reference
class AppIconColors {
  AppIconColors._();

  static const Color emergency = AppColors.emergencyRed;
  static const Color warning = AppColors.emergencyOrange;
  static const Color success = AppColors.successGreen;
  static const Color info = AppColors.infoBlue;
}