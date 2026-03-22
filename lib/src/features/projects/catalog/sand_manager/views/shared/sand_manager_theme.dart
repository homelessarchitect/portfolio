import 'package:flutter/material.dart';

/// Minimalist Contemporary Corporate Design System Tokens from Sand Manager
class AppDesignSystem {
  AppDesignSystem._();

  // Color Palette - Impact Brutalist
  static const Color impactOrange = Color(0xFFE84C1C);
  static const Color impactGreen = Color(0xFF00C853);
  static const Color impactBlue = Color(0xFF0D6EFD);
  static const Color impactPurple = Color(0xFF8A2BE2);
  static const Color deepBlack = Color(0xFF000000);
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color metallicSilver = Color(0xFFB0B0B0);

  // Semantic Colors
  static const Color primaryAction = impactOrange;
  static const Color background = pureWhite;
  static const Color backgroundVariant = Color(0xFFE8E8E8);
  static const Color subtleBackground = Color(0xFFDEDEE0);
  static const Color surface = pureWhite;
  static const Color surfaceVariant = Color(0xFFF5F5F5);
  static const Color textPrimary = deepBlack;
  static const Color textSecondary = Color(0xFF4B4B4B);
  static const Color borderStrong = deepBlack;
  static const Color borderLight = Color(0xFFE0E0E0);

  // Status Colors (Maintain high visibility)
  static const Color success = Color(0xFF00C853);
  static const Color warning = Color(0xFFFFD600);
  static const Color error = Color(0xFFD50000);
  static const Color statusSuccess = success;
  static const Color statusWarning = warning;
  static const Color statusError = error;

  // Spacing
  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 16.0;
  static const double spaceL = 24.0;
  static const double spaceXL = 32.0;

  // Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;

  // Shadows - Neobrutalist Offset
  static List<BoxShadow> get softShadow => [
        const BoxShadow(
          color: deepBlack,
          offset: Offset(4, 4),
          blurRadius: 0,
        ),
      ];

  static List<BoxShadow> get impactShadow => [
        const BoxShadow(
          color: deepBlack,
          offset: Offset(6, 6),
          blurRadius: 0,
        ),
      ];
}

class ImpactCard extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final bool hasBorder;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  const ImpactCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.hasBorder = true,
    this.width,
    this.height,
    this.padding = const EdgeInsets.all(AppDesignSystem.spaceM),
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext childContext) {
    Widget content = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppDesignSystem.pureWhite,
        border: hasBorder
            ? Border.all(color: AppDesignSystem.deepBlack, width: 2)
            : null,
        boxShadow: hasBorder ? AppDesignSystem.softShadow : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        child: content,
      );
    }

    return content;
  }
}
