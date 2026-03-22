import 'package:flutter/material.dart';
import '../../domain/project.dart';
import 'device_mockup.dart';

class ProjectNarrativeSection extends StatelessWidget {
  final Project project;

  const ProjectNarrativeSection({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final viewportHeight = MediaQuery.sizeOf(context).height;

    return Container(
      height: viewportHeight,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Storytelling Heading
                  Text(
                    "LA HISTORIA",
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    project.storytelling,
                    style: theme.textTheme.displaySmall?.copyWith(
                      height: 1.4,
                      fontWeight: FontWeight.w300,
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Problem + Solution + Image Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left column: Problem & Solution
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _NarrativeBlock(
                              title: "EL PROBLEMA",
                              content: project.problem,
                              icon: Icons.error_outline_rounded,
                              color: Colors.redAccent,
                            ),
                            const SizedBox(height: 48),
                            _NarrativeBlock(
                              title: "LA SOLUCIÓN",
                              content: project.solution,
                              icon: Icons.check_circle_outline_rounded,
                              color: Colors.greenAccent,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 80),
                      // Right column: Reference Image (Device Mockup)
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Transform.rotate(
                            angle: -0.05,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: constraints.maxHeight * 0.6,
                              ),
                              child: DeviceMockup(
                                type: project.platforms.contains(ProjectPlatform.mobile)
                                    ? DeviceType.phone
                                    : DeviceType.laptop,
                                width: project.platforms.contains(ProjectPlatform.mobile)
                                    ? 300
                                    : 600,
                                height: constraints.maxHeight * 0.6,
                                child: project.homeViews[ProjectPlatform.mobile] ??
                                    project.homeViews[ProjectPlatform.web] ??
                                    const SizedBox(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _NarrativeBlock extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color color;

  const _NarrativeBlock({
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          content,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.6,
            fontSize: 18,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }
}
