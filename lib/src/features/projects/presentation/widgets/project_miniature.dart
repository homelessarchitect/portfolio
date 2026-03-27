import 'package:flutter/material.dart';
import '../../domain/project.dart';

class ProjectMiniature extends StatelessWidget {
  final Project project;
  final double height;

  const ProjectMiniature({super.key, required this.project, this.height = 160});

  @override
  Widget build(BuildContext context) {
    final hasMobile = project.platforms.contains(ProjectPlatform.mobile);
    final hasWeb =
        project.platforms.contains(ProjectPlatform.web) ||
        project.platforms.contains(ProjectPlatform.desktop);

    return SizedBox(
      height: height,
      child: _DeviceMockupStack(
        project: project,
        hasMobile: hasMobile,
        hasWeb: hasWeb,
      ),
    );
  }
}

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
        width: 150, // Increased from 100
        height: 300, // Increased from 200
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: mobileView != null
                      ? Stack(
                          children: [
                            Positioned.fill(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  width: 390,
                                  height: 844,
                                  child: MediaQuery(
                                    data: MediaQuery.of(context).copyWith(
                                      size: const Size(390, 844),
                                      padding: const EdgeInsets.only(
                                        top: 47,
                                        bottom: 34,
                                      ),
                                    ),
                                    child: mobileView,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Container(color: Colors.grey.shade800),
                ),
              ),
            ),
            Positioned(
              top: 6,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 30,
                  height: 6,
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
        width: 480, // Doubled from 240
        height: 320, // Doubled from 160
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1C1C1E),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  border: Border.all(color: const Color(0xFF323232), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
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
                        ? FittedBox(
                            fit: BoxFit.contain,
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: 1440,
                              height: 900,
                              child: webView,
                            ),
                          )
                        : Container(color: Colors.grey.shade900),
                  ),
                ),
              ),
            ),
            Container(
              height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFFB0B0B0),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
                border: Border.all(color: const Color(0xFF888888), width: 1),
              ),
              child: Center(
                child: Container(
                  width: 50,
                  height: 6,
                  decoration: BoxDecoration(
                    color: const Color(0xFF888888),
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

class _PhoneAndMacbookMockup extends StatelessWidget {
  final Project project;

  const _PhoneAndMacbookMockup({required this.project});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: 700, // Doubled and adjusted from 320
          height: 400, // Doubled and adjusted from 180
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 10,
                top: 50,
                child: _MacbookMockup(project: project, scale: 1.0),
              ),
              Positioned(
                left: 60,
                top: 20,
                child: _PhoneMockup(project: project, scale: 0.9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
