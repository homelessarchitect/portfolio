import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../domain/project.dart';
import '../../providers/video_controller_provider.dart';
import 'project_miniature.dart';

class ProjectPresentationSection extends ConsumerWidget {
  final Project project;

  const ProjectPresentationSection({super.key, required this.project});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.sizeOf(context);
    final viewportHeight = screenSize.height;
    final double videoHeight = viewportHeight * 0.45;
    final double miniatureHeight = viewportHeight * 0.75;

    // Watch the shared provider — no local lifecycle management needed.
    final videoAsync = (project.isBackgroundVideo && project.backgroundUrl != null)
        ? ref.watch(videoControllerProvider(project.backgroundUrl!))
        : const AsyncValue<VideoPlayerController>.loading();

    return Container(
      width: double.infinity,
      height: viewportHeight,
      color: theme.colorScheme.surface,
      child: Stack(
        children: [
          // 1. Top Section (Video / Image / Gradient)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: videoHeight,
              child: Stack(
                children: [
                  // Background layer: animates from fallback → video
                  Positioned.fill(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: videoAsync.when(
                        data: (controller) => _VideoBackground(
                          key: const ValueKey('video'),
                          controller: controller,
                        ),
                        loading: () => _buildImageOrGradient(theme),
                        error: (_, _) => _buildImageOrGradient(theme),
                      ),
                    ),
                  ),
                  // Dark overlay (always present)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.70),
                    ),
                  ),
                  // Title centred in video area
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Text(
                        project.title.split(' ').join('\n').toUpperCase(),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.95),
                          fontWeight: FontWeight.w900,
                          fontSize: 100,
                          letterSpacing: 20,
                          height: 0.75,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Focused Miniature (Centred on overlap)
          Positioned(
            top: videoHeight - (miniatureHeight * 0.45),
            left: 0,
            right: 0,
            child: Center(
              child: Hero(
                tag: 'project_miniature_${project.id}',
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: miniatureHeight,
                    maxWidth: screenSize.width * 0.9,
                  ),
                  child: ProjectMiniature(
                    project: project,
                    height: miniatureHeight,
                  ),
                ),
              ),
            ),
          ),

          // 3. Info Area (Bottom)
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80),
              child: Column(
                children: [
                  Text(
                    project.category.toUpperCase(),
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Text(
                      project.tagline,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Tech Details CTA (Top Right)
          if (project.technicalModules.isNotEmpty)
            Positioned(
              top: MediaQuery.paddingOf(context).top + 24,
              right: 24,
              child: Builder(
                builder: (context) => Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Scaffold.of(context).openEndDrawer(),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface
                            .withValues(alpha: 0.15),
                        border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2)),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.terminal_rounded,
                              size: 16, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'TECH DETAILS',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageOrGradient(ThemeData theme) {
    if (project.backgroundUrl != null && !project.isBackgroundVideo) {
      return Image.asset(
        project.backgroundUrl!,
        key: const ValueKey('image'),
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _buildGradient(theme),
      );
    }
    return _buildGradient(theme);
  }

  Widget _buildGradient(ThemeData theme) {
    return Container(
      key: const ValueKey('gradient'),
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
    );
  }
}

// ── Private Video Widget ──────────────────────────────────────────────────

class _VideoBackground extends StatelessWidget {
  final VideoPlayerController controller;

  const _VideoBackground({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.black,
        child: FittedBox(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: controller.value.size.width,
            height: controller.value.size.height,
            child: VideoPlayer(controller),
          ),
        ),
      ),
    );
  }
}
