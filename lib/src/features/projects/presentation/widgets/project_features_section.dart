import 'package:flutter/material.dart';
import '../../domain/project.dart';
import '../feature_simulation_view.dart';
import 'device_mockup.dart';

class ProjectFeaturesSection extends StatelessWidget {
  final Project project;
  final String? heroPrefix;

  const ProjectFeaturesSection({
    super.key,
    required this.project,
    this.heroPrefix,
  });

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
              final isWide = constraints.maxWidth > 1000;

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                scrollDirection: Axis.horizontal,
                itemCount: project.features.length,
                separatorBuilder: (context, index) => const SizedBox(width: 40),
                itemBuilder: (context, index) {
                  final feature = project.features[index];
                  final cardWidth = isWide
                      ? (constraints.maxWidth - 120 - 40) / 2
                      : (constraints.maxWidth - 120).clamp(400.0, 800.0);

                  return _FeatureCard(
                    feature: feature,
                    project: project,
                    width: cardWidth,
                    heroPrefix: heroPrefix,
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
  final String? heroPrefix;

  const _FeatureCard({
    required this.feature,
    required this.project,
    required this.width,
    this.heroPrefix,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceType = feature.targetPlatform == FeatureTargetPlatform.web
        ? DeviceType.laptop
        : DeviceType.phone;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FeatureSimulationView(project: project, feature: feature),
          ),
        );
      },
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: width,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: const Color(0xFF141414),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            // Left: Device Mockup
            Expanded(
              flex: 5,
              child: Hero(
                tag: '${heroPrefix ?? ''}feature_${feature.id}_mockup',
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: DeviceMockup(
                      type: deviceType,
                      child: feature.simulationScreens.isNotEmpty
                          ? feature.simulationScreens.first.builder()
                          : Container(color: Colors.black26),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(width: 40),

            // Right: Content
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      feature.targetPlatform == FeatureTargetPlatform.web
                          ? "WEB APP"
                          : "MOBILE APP",
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    feature.title.toUpperCase(),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    feature.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Text(
                        "EXPLORAR",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
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
