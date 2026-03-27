import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../projects/data/mock_projects.dart';
import '../../projects/providers/video_controller_provider.dart';
import '../../projects/presentation/widgets/hero_device_mockup.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final starProject = featuredProjects.first;

    // Watch the shared video provider — initialises in parallel with build.
    // keepAlive keeps the controller alive across navigations.
    final videoAsync =
        (starProject.isBackgroundVideo && starProject.backgroundUrl != null)
        ? ref.watch(videoControllerProvider(starProject.backgroundUrl!))
        : const AsyncValue<VideoPlayerController>.loading();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // ── Hero Section ──────────────────────────────────────────
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  color: Colors.black,
                  child: Stack(
                    children: [
                      // ── Background: gradient → first frame → playing video ──
                      Positioned.fill(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 600),
                          child: videoAsync.when(
                            data: (controller) => _VideoBackground(
                              key: const ValueKey('video'),
                              controller: controller,
                            ),
                            loading: () => _FallbackGradient(
                              key: const ValueKey('gradient'),
                            ),
                            error: (_, _) => _FallbackGradient(
                              key: const ValueKey('gradient-error'),
                            ),
                          ),
                        ),
                      ),

                      // Semi-transparent overlay for legibility
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.50),
                        ),
                      ),

                      // Animated device mockups
                      Positioned.fill(
                        child: HeroDeviceMockup(
                          project: starProject,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),

                      // Bottom gradient + project info text
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(60.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.92),
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                starProject.title,
                                style: theme.textTheme.displayLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -2,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                starProject.description,
                                maxLines: 2,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 32),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                    vertical: 20,
                                  ),
                                ),
                                child: const Text(
                                  'Descubra más',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Secondary Content ─────────────────────────────────────
                Container(
                  height: 400,
                  color: theme.colorScheme.surface,
                  child: Center(
                    child: Text(
                      'Explorar más proyectos...',
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Pause indicator overlay
          Positioned(
            bottom: 40,
            right: 40,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
              ),
              child: const Icon(Icons.pause, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Private widgets ───────────────────────────────────────────────────────

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

class _FallbackGradient extends StatelessWidget {
  const _FallbackGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A0A0A), Color(0xFF111128), Color(0xFF0D0D0D)],
        ),
      ),
    );
  }
}
