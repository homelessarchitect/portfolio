import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/project.dart';
import '../../data/mock_projects.dart';
import '../../providers/video_controller_provider.dart';
import 'project_miniature.dart';
import '../project_detail_view.dart';

class RelatedProjectsSection extends ConsumerWidget {
  final String currentProjectId;

  const RelatedProjectsSection({super.key, required this.currentProjectId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final viewportHeight = MediaQuery.sizeOf(context).height;
    final related = featuredProjects
        .where((p) => p.id != currentProjectId)
        .toList();

    if (related.isEmpty) return const SizedBox();

    return Container(
      height: viewportHeight,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: Text(
                      'OTROS PROYECTOS',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    height: 550,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      scrollDirection: Axis.horizontal,
                      itemCount: related.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 48),
                      itemBuilder: (context, index) {
                        return _ProjectCard(
                          project: related[index],
                          onPreWarm: () {
                            // Pre-warm the video controller before navigation
                            // so the detail screen starts with video ready.
                            final p = related[index];
                            if (p.isBackgroundVideo &&
                                p.backgroundUrl != null) {
                              ref.read(
                                videoControllerProvider(
                                  p.backgroundUrl!,
                                ).future,
                              );
                            }
                          },
                        );
                      },
                    ),
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

class _ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onPreWarm;

  const _ProjectCard({required this.project, required this.onPreWarm});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        // Kick off video initialisation before the new route is built.
        onPreWarm();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProjectDetailView(project: project),
          ),
        );
      },
      child: Container(
        width: 450,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest.withValues(
            alpha: 0.3,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: theme.colorScheme.outline.withValues(alpha: 0.1),
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Device Preview Area
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.surface,
                      theme.colorScheme.surfaceContainerHighest,
                    ],
                  ),
                ),
                child: ProjectMiniature(project: project, height: 250),
              ),
            ),
            // Info Area
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.category.isNotEmpty
                        ? project.category
                        : 'PORTFOLIO',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    project.title.toUpperCase(),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    project.tagline,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
