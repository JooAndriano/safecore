import 'package:flutter/material.dart';
import '../colors.dart';
import '../typography.dart';

/// SAFECORE Reusable Button Widget
/// Supports primary, secondary, outline, and ghost variants
class AppButton extends StatelessWidget {
  /// Button text content
  final String text;

  /// Tap callback
  final VoidCallback? onPressed;

  /// Button variant: primary, secondary, outline, ghost
  final ButtonVariant variant;

  /// Button size: small, medium, large
  final ButtonSize size;

  /// Whether button is disabled
  final bool disabled;

  /// Optional leading icon
  final Widget? leadingIcon;

  /// Optional trailing icon
  final Widget? trailingIcon;

  /// Custom width (overrides size-based width)
  final double? width;

  /// Full width button
  final bool fullWidth;

  /// Loading state
  final bool loading;

  /// Custom height (overrides size-based height)
  final double? height;

  /// Custom padding
  final EdgeInsets? padding;

  /// Custom background color
  final Color? backgroundColor;

  /// Custom text color
  final Color? textColor;

  /// Custom outline color
  final Color? outlineColor;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.disabled = false,
    this.leadingIcon,
    this.trailingIcon,
    this.width,
    this.fullWidth = false,
    this.loading = false,
    this.height,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.outlineColor,
  });

  // MARK: Computed Properties

  /// Effective state (disabled takes precedence)
  bool get _isDisabled => disabled || loading || onPressed == null;

  /// Button height based on size
  double get _height => height ?? switch (size) {
        ButtonSize.small => 36,
        ButtonSize.medium => 48,
        ButtonSize.large => 56,
      };

  /// Button padding based on size
  EdgeInsets get _effectivePadding =>
      padding ?? switch (size) {
            ButtonSize.small => const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ButtonSize.medium => const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ButtonSize.large => const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          };

  /// Font size based on size
  double get _fontSize => switch (size) {
        ButtonSize.small => 14,
        ButtonSize.medium => 16,
        ButtonSize.large => 20,
      };

  /// Build button style based on variant and state
  ButtonStyle? buildStyle() {
    final isDisabled = _isDisabled;

    Color bgColor;
    Color fgColor;
    Color? borderColor;
    double elevation = 0;

    switch (variant) {
      case ButtonVariant.primary:
        if (isDisabled) {
          bgColor = (backgroundColor ?? AppColors.emergencyRed).withValues(alpha: 0.4);
          fgColor = (textColor ?? AppColors.lightText).withValues(alpha: 0.6);
        } else {
          bgColor = backgroundColor ?? AppColors.emergencyRed;
          fgColor = textColor ?? AppColors.lightText;
        }
        break;

      case ButtonVariant.secondary:
        if (isDisabled) {
          bgColor = (backgroundColor ?? AppColors.emergencyOrange).withValues(alpha: 0.4);
          fgColor = (textColor ?? AppColors.inverseText).withValues(alpha: 0.6);
        } else {
          bgColor = backgroundColor ?? AppColors.emergencyOrange;
          fgColor = textColor ?? AppColors.inverseText;
        }
        break;

      case ButtonVariant.outline:
        bgColor = backgroundColor ?? Colors.transparent;
        fgColor = textColor ?? AppColors.emergencyRed;
        borderColor = outlineColor ?? AppColors.emergencyRed;
        break;

      case ButtonVariant.ghost:
        bgColor = backgroundColor ?? Colors.transparent;
        fgColor = textColor ?? AppColors.lightText;
        break;

      case ButtonVariant.danger:
        if (isDisabled) {
          bgColor = (backgroundColor ?? AppColors.danger).withValues(alpha: 0.4);
          fgColor = (textColor ?? AppColors.lightText).withValues(alpha: 0.6);
        } else {
          bgColor = backgroundColor ?? AppColors.danger;
          fgColor = textColor ?? AppColors.lightText;
        }
        break;

      case ButtonVariant.success:
        if (isDisabled) {
          bgColor = (backgroundColor ?? AppColors.success).withValues(alpha: 0.4);
          fgColor = (textColor ?? AppColors.lightText).withValues(alpha: 0.6);
        } else {
          bgColor = backgroundColor ?? AppColors.success;
          fgColor = textColor ?? AppColors.lightText;
        }
        break;
    }

    return ButtonStyle(
      backgroundColor: WidgetStateProperty.all(bgColor),
      foregroundColor: WidgetStateProperty.all(fgColor),
      elevation: WidgetStateProperty.all(elevation),
      side: borderColor != null
          ? WidgetStateProperty.all(
              BorderSide(color: borderColor, width: variant == ButtonVariant.outline ? 2 : 0))
          : null,
      padding: WidgetStateProperty.all(_effectivePadding),
      minimumSize: WidgetStateProperty.all(Size(_fullWidth ? double.infinity : width ?? 0, _height)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size == ButtonSize.small ? 8 : 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = buildStyle();
    final effectiveWidth = _fullWidth ? double.infinity : width;
    final fgColor = fgColorForVariant(variant, _isDisabled);

    Widget child = SizedBox(
      width: effectiveWidth,
      height: _height,
      child: ElevatedButton(
        style: style,
        onPressed: _isDisabled ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (loading)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(fgColor),
                ),
              )
            else if (leadingIcon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: leadingIcon!,
              ),
            Text(
              text,
              style: AppTypography.button.copyWith(
                fontSize: _fontSize,
                color: fgColor,
              ),
              textAlign: TextAlign.center,
            ),
            if (trailingIcon != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: trailingIcon!,
              ),
          ],
        ),
      ),
    );

    if (fullWidth) {
      child = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: child,
      );
    }

    return child;
  }

  /// Get foreground color for variant
  Color fgColorForVariant(ButtonVariant variant, bool isDisabled) {
    if (textColor != null) {
      return isDisabled ? textColor!.withValues(alpha: 0.6) : textColor!;
    }
    switch (variant) {
      case ButtonVariant.primary:
      case ButtonVariant.danger:
      case ButtonVariant.success:
        return isDisabled ? AppColors.lightText.withValues(alpha: 0.6) : AppColors.lightText;
      case ButtonVariant.secondary:
        return isDisabled ? AppColors.inverseText.withValues(alpha: 0.6) : AppColors.inverseText;
      default:
        return isDisabled ? AppColors.secondaryText.withValues(alpha: 0.6) : AppColors.lightText;
    }
  }

  // MARK: Factory Methods

  /// Primary red button
  factory AppButton.primary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool fullWidth = false,
    bool loading = false,
    double? width,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.primary,
      size: size,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      fullWidth: fullWidth,
      loading: loading,
      width: width,
    );
  }

  /// Secondary orange button
  factory AppButton.secondary({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool fullWidth = false,
    bool loading = false,
    double? width,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.secondary,
      size: size,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      fullWidth: fullWidth,
      loading: loading,
      width: width,
    );
  }

  /// Outline button with border
  factory AppButton.outline({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool fullWidth = false,
    double? width,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.outline,
      size: size,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      fullWidth: fullWidth,
      width: width,
    );
  }

  /// Ghost button without background
  factory AppButton.ghost({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    Widget? leadingIcon,
    Widget? trailingIcon,
    bool fullWidth = false,
    double? width,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.ghost,
      size: size,
      leadingIcon: leadingIcon,
      trailingIcon: trailingIcon,
      fullWidth: fullWidth,
      width: width,
    );
  }

  /// Danger button (red)
  factory AppButton.danger({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    Widget? leadingIcon,
    bool fullWidth = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.danger,
      size: size,
      leadingIcon: leadingIcon,
      fullWidth: fullWidth,
    );
  }

  /// Success button (green)
  factory AppButton.success({
    Key? key,
    required String text,
    VoidCallback? onPressed,
    ButtonSize size = ButtonSize.medium,
    Widget? leadingIcon,
    bool fullWidth = false,
  }) {
    return AppButton(
      key: key,
      text: text,
      onPressed: onPressed,
      variant: ButtonVariant.success,
      size: size,
      leadingIcon: leadingIcon,
      fullWidth: fullWidth,
    );
  }

  bool get _fullWidth => fullWidth && width == null;
}

/// Button variants
enum ButtonVariant {
  primary,
  secondary,
  outline,
  ghost,
  danger,
  success,
}

/// Button sizes
enum ButtonSize {
  small,
  medium,
  large,
}