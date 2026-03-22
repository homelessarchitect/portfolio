import 'package:flutter/material.dart';
import '../domain/project.dart';
import 'feature_simulation_view.dart';
import 'widgets/hero_device_mockup.dart';

class ProjectDetailView extends StatelessWidget {
  final Project project;

  const ProjectDetailView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Immersive Hero — animated device mockups
            Container(
              height: 600,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0D0D0D),
                    theme.colorScheme.surface.withValues(alpha: 0.95),
                    const Color(0xFF1A1A2E),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Device mockups
                  Positioned.fill(
                    child: HeroDeviceMockup(
                      project: project,
                      height: 600,
                    ),
                  ),
                  // Title overlay at bottom
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 32,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.85),
                          ],
                        ),
                      ),
                      child: Text(
                        project.title.toUpperCase(),
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Tech Specs Section (Porsche Style)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _SpecItem(
                    label: "TECNOLOGÍA",
                    value: project.tags.isNotEmpty
                        ? project.tags.first.toUpperCase()
                        : "FLUTTER",
                  ),
                  const _VerticalDivider(),
                  _SpecItem(label: "ESTADO", value: "COMPLETE"),
                  const _VerticalDivider(),
                  _SpecItem(label: "CÓDIGO", value: "OPEN SOURCE"),
                ],
              ),
            ),

            // Narrative Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "EL CONCEPTO",
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    project.description,
                    style: theme.textTheme.displaySmall?.copyWith(
                      height: 1.4,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Tech Stack
                  Text(
                    "TECNOLOGÍAS",
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: project.services.map((service) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: theme.colorScheme.outline.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        service.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),

            // Features Carousel Section
            if (project.features.isNotEmpty) ...[
              const SizedBox(height: 60),
              _FeaturesCarousel(project: project),
            ],

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _FeaturesCarousel extends StatefulWidget {
  final Project project;

  const _FeaturesCarousel({required this.project});

  @override
  State<_FeaturesCarousel> createState() => _FeaturesCarouselState();
}

class _FeaturesCarouselState extends State<_FeaturesCarousel> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.9);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                itemCount: widget.project.features.length,
                separatorBuilder: (context, index) => const SizedBox(width: 32),
                itemBuilder: (context, index) {
                  final feature = widget.project.features[index];
                  final cardWidth = isWide 
                      ? (constraints.maxWidth - 120 - 32) / 2 
                      : constraints.maxWidth - 120;
                  
                  return _FeatureCard(
                    feature: feature,
                    project: widget.project,
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

class _SpecItem extends StatelessWidget {
  final String label;
  final String value;

  const _SpecItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            letterSpacing: 1.5,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 60,
      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
    );
  }
}
