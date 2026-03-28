import 'package:flutter/material.dart';
import '../../domain/project.dart';

// ------------------------------------------------------------------ //
//  Project Drawer Thumbnail                                            //
//  Tap-able card with a scaled device mockup + project info.          //
//  Inspired by the Porsche models sub-menu.                            //
// ------------------------------------------------------------------ //

ThemeData _buildMockTheme(BuildContext context, bool isDark, Project project) {
  if (project.primaryColor == null) {
    return isDark ? ThemeData.dark() : ThemeData.light();
  }

  final seed = project.primaryColor!;
  final onPrimary =
      project.onPrimaryColor ?? (isDark ? Colors.black : Colors.white);

  return ThemeData(
    brightness: isDark ? Brightness.dark : Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: seed,
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: seed,
      onPrimary: onPrimary,
    ),
    useMaterial3: true,
    scaffoldBackgroundColor: isDark ? const Color(0xFF050505) : const Color(0xFFF5F5F7),
    fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
  );
}

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
        child: FittedBox(
          fit: BoxFit.contain,
          child: Container(
            width: 414, // iPhone 11/XR width
            height: 896,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(55),
              boxShadow: const [
                BoxShadow(color: Colors.black45, blurRadius: 20, offset: Offset(0, 10)),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(44),
              child: Theme(
                data: _buildMockTheme(context, true, project),
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    size: const Size(390, 844),
                    padding: const EdgeInsets.only(top: 44, bottom: 34),
                  ),
                  child: Material(
                    color: project.primaryColor ?? const Color(0xFF0F0F0F),
                    child: mobileView ?? const Placeholder(),
                  ),
                ),
              ),
            ),
          ),
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
        child: FittedBox(
          fit: BoxFit.contain,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Screen
              Container(
                width: 1440 + 32,
                height: 900 + 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1E1C),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  border: Border.all(color: const Color(0xFF333333), width: 3),
                ),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 16),
                child: ClipRRect(
                  child: Theme(
                    data: _buildMockTheme(context, true, project),
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(size: const Size(1440, 900)),
                      child: Material(
                        color: Colors.white,
                        child: webView ?? const Placeholder(),
                      ),
                    ),
                  ),
                ),
              ),
              // Base
              Container(
                width: 1440 + 32 + 80,
                height: 16,
                decoration: const BoxDecoration(
                  color: Color(0xFF333333),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                ),
              ),
            ],
          ),
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
