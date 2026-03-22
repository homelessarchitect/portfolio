import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../domain/project.dart';
import 'project_miniature.dart';

class ProjectPresentationSection extends StatefulWidget {
  final Project project;

  const ProjectPresentationSection({super.key, required this.project});

  @override
  State<ProjectPresentationSection> createState() =>
      _ProjectPresentationSectionState();
}

class _ProjectPresentationSectionState
    extends State<ProjectPresentationSection> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    if (widget.project.isBackgroundVideo &&
        widget.project.backgroundUrl != null) {
      _controller = VideoPlayerController.asset(widget.project.backgroundUrl!)
        ..initialize().then((_) {
          if (mounted) {
            setState(() {
              _isInitialized = true;
            });
            _controller?.setLooping(true);
            _controller?.setVolume(0); // Muted per requirements
            _controller?.play();
          }
        });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.sizeOf(context);
    final viewportHeight = screenSize.height;
    final double videoHeight = viewportHeight * 0.45; // Stick to 45% for cinematic feel
    final double miniatureHeight = viewportHeight * 0.75; // Proportional to screen

    return Container(
      width: double.infinity,
      height: viewportHeight, // Full Screen
      color: theme.colorScheme.surface,
      child: Stack(
        children: [
          // 1. Top Section (Video/Title)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: videoHeight,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: widget.project.isBackgroundVideo && _controller != null
                        ? _buildVideoBackground()
                        : _buildImageBackground(theme),
                  ),
                  Positioned.fill(
                    child: Container(color: Colors.black.withValues(alpha: 0.7)),
                  ),
                  // Title centered in video area
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: Text(
                        widget.project.title.split(' ').join('\n').toUpperCase(),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.95),
                          fontWeight: FontWeight.w900,
                          fontSize: 100, // Balanced for full screen
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

          // 2. Focused Miniature (Centered on overlap)
          Positioned(
            top: videoHeight - (miniatureHeight * 0.45),
            left: 0,
            right: 0,
            child: Center(
              child: Hero(
                tag: 'project_miniature_${widget.project.id}',
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: miniatureHeight,
                    maxWidth: screenSize.width * 0.9,
                  ),
                  child: ProjectMiniature(
                    project: widget.project,
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
                    widget.project.category.toUpperCase(),
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
                      widget.project.tagline,
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
        ],
      ),
    );
  }

  Widget _buildVideoBackground() {
    if (!_isInitialized || _controller == null) {
      return Container(color: Colors.black);
    }
    return SizedBox.expand(
      child: Container(
        color: Colors.black,
        child: FittedBox(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          clipBehavior: Clip.hardEdge,
          child: SizedBox(
            width: _controller!.value.size.width,
            height: _controller!.value.size.height,
            child: VideoPlayer(_controller!),
          ),
        ),
      ),
    );
  }

  Widget _buildImageBackground(ThemeData theme) {
    if (widget.project.backgroundUrl != null) {
      return Image.asset(
        widget.project.backgroundUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            _buildFallbackGradient(theme),
      );
    }
    return _buildFallbackGradient(theme);
  }

  Widget _buildFallbackGradient(ThemeData theme) {
    return Container(
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
