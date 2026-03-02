import 'package:flutter/material.dart';

class LabGroup {
  final String id;
  final String title;
  final IconData icon;
  final List<LabFeature> features;

  const LabGroup({
    required this.id,
    required this.title,
    required this.icon,
    required this.features,
  });
}

class LabFeature {
  final String id;
  final String title;
  final String description;
  final WidgetBuilder builder;

  const LabFeature({
    required this.id,
    required this.title,
    required this.description,
    required this.builder,
  });
}
