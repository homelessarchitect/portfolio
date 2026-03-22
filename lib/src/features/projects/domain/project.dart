import 'package:flutter/widgets.dart';

enum ProjectPlatform { web, mobile, desktop }
enum ProjectStatus { live, inDevelopment, archived }
enum FeatureTargetPlatform { mobile, web }

class SimulationScreen {
  final String label;
  final Widget Function() builder;

  const SimulationScreen({
    required this.label,
    required this.builder,
  });
}

class HelpStep {
  final int stepNumber;
  final String title;
  final String? description;
  /// Relative position (0.0 to 1.0) from top
  final double top;
  /// Relative position (0.0 to 1.0) from left
  final double left;

  const HelpStep({
    required this.stepNumber,
    required this.title,
    this.description,
    required this.top,
    required this.left,
  });
}

class ProjectFeature {
  final String id;
  final String title;
  final String description;
  final FeatureTargetPlatform targetPlatform;
  final List<SimulationScreen> simulationScreens;
  final List<HelpStep> helpSteps;
  final String? guide;

  const ProjectFeature({
    required this.id,
    required this.title,
    required this.description,
    this.targetPlatform = FeatureTargetPlatform.mobile,
    this.simulationScreens = const [],
    this.helpSteps = const [],
    this.guide,
  });
}

class Project {
  final String id;
  final String title;
  final String tagline;
  final List<ProjectPlatform> platforms;
  final List<String> services;
  final String year;
  final ProjectStatus status;
  final Map<ProjectPlatform, Widget> homeViews;
  final List<ProjectFeature> features;
  
  final String description;
  final String imageUrl;
  final String? logoUrl;
  final List<String> tags;
  final String? demoUrl;

  // New fields for restructured detail view
  final String problem;
  final String solution;
  final String storytelling;
  final String styleDescription;
  final String category;
  final String? backgroundUrl;
  final bool isBackgroundVideo;
  final List<SimulationScreen> designScreens;

  const Project({
    required this.id,
    required this.title,
    required this.tagline,
    required this.platforms,
    required this.services,
    required this.year,
    required this.status,
    required this.homeViews,
    required this.features,
    
    this.description = '',
    this.imageUrl = '',
    this.logoUrl,
    this.tags = const [],
    this.demoUrl,

    // New fields initializers
    this.problem = '',
    this.solution = '',
    this.storytelling = '',
    this.styleDescription = '',
    this.category = '',
    this.backgroundUrl,
    this.isBackgroundVideo = false,
    this.designScreens = const [],
  });
}
