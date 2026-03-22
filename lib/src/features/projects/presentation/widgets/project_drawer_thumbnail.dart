import 'package:flutter/material.dart';
import '../../domain/project.dart';

// ------------------------------------------------------------------ //
//  Project Drawer Thumbnail                                            //
//  Tap-able card with a scaled device mockup + project info.          //
//  Inspired by the Porsche models sub-menu.                            //
// ------------------------------------------------------------------ //

class ProjectDrawerThumbnail extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;

  const ProjectDrawerThumbnail({
    super.key,
    required this.project,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasMobile = project.platforms.contains(ProjectPlatform.mobile);
    final hasWeb =
        project.platforms.contains(ProjectPlatform.web) ||
        project.platforms.contains(ProjectPlatform.desktop);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Device mockup area
            SizedBox(
              height: 160,
              width: double.infinity,
              child: _DeviceMockupStack(
                project: project,
                hasMobile: hasMobile,
                hasWeb: hasWeb,
              ),
            ),

            const SizedBox(height: 16),

            // Title + logo + tagline
            Row(
              children: [
                if (project.logoUrl != null)
                  Container(
                    width: 32,
                    height: 32,
                    margin: const EdgeInsets.only(right: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.05,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: project.logoUrl!.startsWith('http')
                            ? NetworkImage(project.logoUrl!)
                            : AssetImage(project.logoUrl!) as ImageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            project.year,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _PlatformChip(hasMobile: hasMobile, hasWeb: hasWeb),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Divider
            Divider(
              height: 1,
              thickness: 1,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
            ),
          ],
        ),
      ),
    );
  }
}

// ---- Platform label chip ----
class _PlatformChip extends StatelessWidget {
  final bool hasMobile;
  final bool hasWeb;

  const _PlatformChip({required this.hasMobile, required this.hasWeb});

  @override
  Widget build(BuildContext context) {
    final String label;
    if (hasMobile && hasWeb) {
      label = 'Mobile + Web';
    } else if (hasMobile) {
      label = 'Mobile';
    } else {
      label = 'Web';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

// ---- Device Mockup Stack ----
class _DeviceMockupStack extends StatelessWidget {
  final Project project;
  final bool hasMobile;
  final bool hasWeb;

  const _DeviceMockupStack({
    required this.project,
    required this.hasMobile,
    required this.hasWeb,
  });

  @override
  Widget build(BuildContext context) {
    if (hasMobile && hasWeb) {
      return _PhoneAndMacbookMockup(project: project);
    } else if (hasMobile) {
      return Center(child: _PhoneMockup(project: project));
    } else {
      return Center(child: _MacbookMockup(project: project));
    }
  }
}

// ------------------------------------------------------------------ //
//  Phone Mockup                                                        //
// ------------------------------------------------------------------ //
class _PhoneMockup extends StatelessWidget {
  final Project project;
  final double scale;

  const _PhoneMockup({required this.project, this.scale = 1.0});

  @override
  Widget build(BuildContext context) {
    final mobileView = project.homeViews[ProjectPlatform.mobile];

    return Transform.scale(
      scale: scale,
      alignment: Alignment.center,
      child: SizedBox(
        width: 90,
        height: 180,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Phone body
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: mobileView != null
                      ? OverflowBox(
                          alignment: Alignment.topCenter,
                          maxWidth: 400,
                          maxHeight: 800,
                          child: Transform.scale(
                            scale: 0.21,
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: 400,
                              height: 860,
                              child: mobileView,
                            ),
                          ),
                        )
                      : Container(color: Colors.grey.shade800),
                ),
              ),
            ),
            // Notch
            Positioned(
              top: 6,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 24,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------ //
//  Macbook Mockup                                                       //
// ------------------------------------------------------------------ //
class _MacbookMockup extends StatelessWidget {
  final Project project;
  final double scale;

  const _MacbookMockup({required this.project, this.scale = 1.0});

  @override
  Widget build(BuildContext context) {
    final webView = project.homeViews[ProjectPlatform.web];

    return Transform.scale(
      scale: scale,
      alignment: Alignment.center,
      child: SizedBox(
        width: 220,
        height: 146,
        child: Column(
          children: [
            // Screen
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  border: Border.all(color: const Color(0xFF323232), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ),
                    child: webView != null
                        ? OverflowBox(
                            alignment: Alignment.topCenter,
                            maxWidth: 1440,
                            maxHeight: 900,
                            child: Transform.scale(
                              scale: 0.149,
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: 1440,
                                height: 860,
                                child: webView,
                              ),
                            ),
                          )
                        : Container(color: Colors.grey.shade900),
                  ),
                ),
              ),
            ),
            // Base / trackpad bar
            Container(
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFFB0B0B0),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(3),
                ),
                border: Border.all(color: const Color(0xFF888888), width: 1),
              ),
              child: Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF888888),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ------------------------------------------------------------------ //
//  Phone + Macbook combined (for web+mobile projects)                  //
// ------------------------------------------------------------------ //
class _PhoneAndMacbookMockup extends StatelessWidget {
  final Project project;

  const _PhoneAndMacbookMockup({required this.project});

  @override
  Widget build(BuildContext context) {
    // Reference canvas: 300x160.
    // FittedBox makes this responsive within the double.infinity parent width.
    return Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: 300,
          height: 160,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // MacBook — behind, right side
              Positioned(
                right: 5,
                top: 22,
                child: _MacbookMockup(project: project, scale: 0.95),
              ),
              // Phone — in front, left-leaning, overlapping base
              Positioned(
                left: 35,
                top: 8,
                child: _PhoneMockup(project: project, scale: 0.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
