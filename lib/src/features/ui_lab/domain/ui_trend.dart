import 'package:flutter/material.dart';

class UITrend {
  final String id;
  final String name;
  final String tagline;
  final String description;
  final Color accentColor;
  final Color secondaryAccent;
  final Color bgColor;
  final Color surfaceColor;
  final Color textColor;
  final Color subtleTextColor;
  final List<Color> palette;
  final List<String> keywords;
  final Gradient backgroundGradient;

  const UITrend({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.accentColor,
    required this.secondaryAccent,
    required this.bgColor,
    required this.surfaceColor,
    required this.textColor,
    required this.subtleTextColor,
    required this.palette,
    required this.keywords,
    required this.backgroundGradient,
  });
}
