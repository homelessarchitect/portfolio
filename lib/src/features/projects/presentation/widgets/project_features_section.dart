import 'package:flutter/material.dart';
import '../../domain/project.dart';
import '../feature_simulation_view.dart';

class ProjectFeaturesSection extends StatelessWidget {
  final Project project;

  const ProjectFeaturesSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    if (project.features.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Text(
            "KEY FEATURES",
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 48),
        SizedBox(
          height: 600,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 900;
              
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                scrollDirection: Axis.horizontal,
                itemCount: project.features.length,
                separatorBuilder: (context, index) => const SizedBox(width: 32),
                itemBuilder: (context, index) {
                  final feature = project.features[index];
                  final cardWidth = isWide 
                      ? (constraints.maxWidth - 120 - 32) / 2 
                      : (constraints.maxWidth - 120).clamp(300.0, 500.0);
                  
                  return _FeatureCard(
                    feature: feature,
                    project: project,
                    width: cardWidth,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final ProjectFeature feature;
  final Project project;
  final double width;

  const _FeatureCard({
    required this.feature,
    required this.project,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FeatureSimulationView(
              project: project,
              feature: feature,
            ),
          ),
        );
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background Animation / Simulation Preview
            Positioned.fill(
              child: Opacity(
                opacity: 0.6,
                child: IgnorePointer(
                  child: feature.simulationScreens.isNotEmpty 
                    ? feature.simulationScreens.first.builder()
                    : const Center(child: Icon(Icons.apps, color: Colors.white24, size: 80)),
                ),
              ),
            ),
            
            // Bottom Info Gradient
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black87,
                      Colors.black,
                    ],
                    stops: [0, 0.4, 0.8, 1],
                  ),
                ),
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    feature.title.toUpperCase(),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    feature.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.7),
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 24),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
