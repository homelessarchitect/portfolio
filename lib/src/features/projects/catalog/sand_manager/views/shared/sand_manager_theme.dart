import 'package:flutter/material.dart';

/// Minimalist Contemporary Corporate Design System Tokens from Sand Manager
class AppDesignSystem {
  AppDesignSystem._();

  // Core Brand Colors (Fixed)
  static const Color impactOrange = Color(0xFFE84C1C);
  static const Color impactGreen = Color(0xFF00C853);
  static const Color impactBlue = Color(0xFF0D6EFD);
  static const Color impactPurple = Color(0xFF8A2BE2);
  static const Color metallicSilver = Color(0xFFB0B0B0);

  // Dynamic Theme Colors
  static bool _isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  static Color deepBlack(BuildContext context) =>
      _isDark(context) ? const Color(0xFFF0F0F0) : const Color(0xFF000000);

  static Color pureWhite(BuildContext context) =>
      _isDark(context) ? const Color(0xFF0A0A0A) : const Color(0xFFFFFFFF);

  static Color background(BuildContext context) =>
      _isDark(context) ? const Color(0xFF050505) : const Color(0xFFFFFFFF);

  static Color backgroundVariant(BuildContext context) =>
      _isDark(context) ? const Color(0xFF0F0F0F) : const Color(0xFFE8E8E8);

  static Color surface(BuildContext context) =>
      _isDark(context) ? const Color(0xFF151515) : const Color(0xFFFFFFFF);

  static Color textPrimary(BuildContext context) =>
      _isDark(context) ? const Color(0xFFFFFFFF) : const Color(0xFF000000);

  static Color textSecondary(BuildContext context) =>
      _isDark(context) ? const Color(0xFFA0A0A0) : const Color(0xFF4B4B4B);

  static Color borderStrong(BuildContext context) =>
      _isDark(context) ? const Color(0xFF333333) : const Color(0xFF000000);

  // Status Colors (Always vibrant)
  static const Color success = impactGreen;
  static const Color warning = Color(0xFFFFD600);
  static const Color error = Color(0xFFD50000);

  static const Color statusSuccess = success;
  static const Color statusError = error;

  // Spacing & Radius constants remain the same
  static const double spaceXS = 4.0;
  static const double spaceS = 8.0;
  static const double spaceM = 16.0;
  static const double spaceL = 24.0;
  static const double spaceXL = 32.0;

  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;

  // Dynamic Shadows
  static List<BoxShadow> softShadow(BuildContext context) => [
    BoxShadow(
      color: borderStrong(context),
      offset: const Offset(4, 4),
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
  Widget build(BuildContext context) {
    Widget content = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppDesignSystem.surface(context),
        border: hasBorder
            ? Border.all(color: AppDesignSystem.borderStrong(context), width: 2)
            : null,
        boxShadow: hasBorder ? AppDesignSystem.softShadow(context) : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(onTap: onTap, child: content);
    }

    return content;
  }
}
