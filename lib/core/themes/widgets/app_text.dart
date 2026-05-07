import 'package:flutter/material.dart';
import '../colors.dart';
import '../typography.dart';

/// SAFECORE Reusable Text Widget
/// Consistent text styling with semantic variants for emergency context
class AppText extends StatelessWidget {
  /// Text content
  final String data;

  /// Text style override
  final TextStyle? style;

  /// Text alignment
  final TextAlign? textAlign;

  /// Text overflow behavior
  final TextOverflow? overflow;

  /// Maximum number of lines (null for unlimited)
  final int? maxLines;

  /// Whether text should be emphasized (bold)
  final bool emphasized;

  /// Whether text is a heading
  final bool heading;

  /// Whether text is body content
  final bool body;

  /// Whether text is caption/label
  final bool caption;

  const AppText({
    super.key,
    required this.data,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.emphasized = false,
    this.heading = false,
    this.body = false,
    this.caption = false,
  });

  // MARK: Computed Properties

  /// Effective text style
  TextStyle get _effectiveStyle {
    if (style != null) return style!;

    TextStyle baseStyle;
    if (heading) {
      baseStyle = AppTypography.h2;
    } else if (body) {
      baseStyle = AppTypography.body;
    } else if (caption) {
      baseStyle = AppTypography.caption;
    } else {
      baseStyle = AppTypography.body;
    }

    if (emphasized) {
      return baseStyle.copyWith(fontWeight: FontWeight.bold);
    }

    return baseStyle;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: _effectiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  // MARK: Factory Methods

  /// Heading text (H2 style)
  factory AppText.heading(
    String data, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool emphasized = false,
    Color? color,
  }) {
    return AppText(
      key: key,
      data: data,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      emphasized: emphasized,
      heading: true,
      style: color != null ? TextStyle(color: color) : null,
    );
  }

  /// Body text (Body style)
  factory AppText.body(
    String data, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    bool emphasized = false,
    Color? color,
  }) {
    return AppText(
      key: key,
      data: data,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      emphasized: emphasized,
      body: true,
      style: color != null ? TextStyle(color: color) : null,
    );
  }

  /// Caption text (Caption style)
  factory AppText.caption(
    String data, {
    Key? key,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? color,
  }) {
    return AppText(
      key: key,
      data: data,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      caption: true,
      style: color != null ? TextStyle(color: color) : null,
    );
  }

  /// Label text (Label style)
  factory AppText.label(
    String data, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.label.copyWith(color: color),
      textAlign: textAlign,
    );
  }

  /// Button text (Button style)
  factory AppText.button(
    String data, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.button.copyWith(color: color),
      textAlign: textAlign,
    );
  }

  /// Emergency red text
  factory AppText.emergency(
    String data, {
    Key? key,
    double fontSize = 16,
    TextAlign? textAlign,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.body.copyWith(
        color: AppColors.emergencyRed,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
    );
  }

  /// Warning orange text
  factory AppText.warning(
    String data, {
    Key? key,
    double fontSize = 16,
    TextAlign? textAlign,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.body.copyWith(
        color: AppColors.emergencyOrange,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
    );
  }

  /// Success green text
  factory AppText.success(
    String data, {
    Key? key,
    double fontSize = 16,
    TextAlign? textAlign,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.body.copyWith(
        color: AppColors.successGreen,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
    );
  }

  /// Secondary/tertiary text (gray)
  factory AppText.secondary(
    String data, {
    Key? key,
    double fontSize = 16,
    TextAlign? textAlign,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.body.copyWith(
        color: AppColors.secondaryText,
        fontSize: fontSize,
      ),
      textAlign: textAlign,
    );
  }

  /// Large title text (H1 style)
  factory AppText.title(
    String data, {
    Key? key,
    TextAlign? textAlign,
    Color? color,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.h1.copyWith(color: color),
      textAlign: textAlign,
    );
  }

  /// Section header text (H3 style)
  factory AppText.section(
    String data, {
    Key? key,
    TextAlign? textAlign,
    Color? color,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.h3.copyWith(color: color),
      textAlign: textAlign,
    );
  }

  /// H1 style
  factory AppText.h1(
    String data, {
    Key? key,
    TextAlign? textAlign,
    Color? color,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.h1.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// H2 style
  factory AppText.h2(
    String data, {
    Key? key,
    TextAlign? textAlign,
    Color? color,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.h2.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// H3 style
  factory AppText.h3(
    String data, {
    Key? key,
    TextAlign? textAlign,
    Color? color,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.h3.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// H4 style (using H3 as base)
  factory AppText.h4(
    String data, {
    Key? key,
    TextAlign? textAlign,
    Color? color,
    int? maxLines,
    TextOverflow? overflow,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.h3.copyWith(color: color, fontSize: 18),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// Body1 style (Body Large)
  factory AppText.body1(
    String data, {
    Key? key,
    TextAlign? textAlign,
    Color? color,
    int? maxLines,
    TextOverflow? overflow,
    bool emphasized = false,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.bodyLarge.copyWith(
        color: color,
        fontWeight: emphasized ? FontWeight.bold : null,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// Body2 style (Standard Body)
  factory AppText.body2(
    String data, {
    Key? key,
    TextAlign? textAlign,
    Color? color,
    int? maxLines,
    TextOverflow? overflow,
    bool emphasized = false,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.body.copyWith(
        color: color,
        fontWeight: emphasized ? FontWeight.bold : null,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// Body3 style (Body Small)
  factory AppText.body3(
    String data, {
    Key? key,
    TextAlign? textAlign,
    Color? color,
    int? maxLines,
    TextOverflow? overflow,
    bool emphasized = false,
  }) {
    return AppText(
      key: key,
      data: data,
      style: AppTypography.bodySmall.copyWith(
        color: color,
        fontWeight: emphasized ? FontWeight.bold : null,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// Text semantic types for quick reference
class AppTextSemantics {
  AppTextSemantics._();

  static const String heading = 'heading';
  static const String body = 'body';
  static const String caption = 'caption';
  static const String label = 'label';
  static const String button = 'button';
}

/// Text font weights for emergency context
class AppTextWeights {
  AppTextWeights._();

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.bold;
}