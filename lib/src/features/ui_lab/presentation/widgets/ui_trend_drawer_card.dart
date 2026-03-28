import 'dart:ui';
import 'package:flutter/material.dart';
import '../../domain/ui_trend.dart';

/// Refactored drawer card for UI Trends.
/// Matches the style of ProjectDrawerThumbnail for UI consistency.
class UITrendDrawerCard extends StatelessWidget {
  final UITrend trend;
  final VoidCallback onTap;

  const UITrendDrawerCard({
    super.key,
    required this.trend,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mockup Area (matches height of ProjectDrawerThumbnail)
            SizedBox(
              height: 160,
              width: double.infinity,
              child: _TrendMockup(trend: trend),
            ),

            const SizedBox(height: 16),

            // Title + Info row
            Row(
              children: [
                // Palette Accent Square
                Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: trend.accentColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: trend.accentColor.withValues(alpha: 0.3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.palette_outlined,
                      size: 16,
                      color: trend.textColor.withValues(alpha: 0.9),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trend.name,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          ...trend.palette.take(3).map(
                                (c) => Container(
                                  width: 10,
                                  height: 10,
                                  margin: const EdgeInsets.only(right: 6),
                                  decoration: BoxDecoration(
                                    color: c,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: theme.colorScheme.onSurface
                                          .withValues(alpha: 0.1),
                                    ),
                                  ),
                                ),
                              ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              trend.tagline,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Divider matching the style in ProjectDrawerThumbnail
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

class _TrendMockup extends StatelessWidget {
  final UITrend trend;
  const _TrendMockup({required this.trend});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 80,
        height: 160,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(4),
        child: Container(
          decoration: BoxDecoration(
            color: trend.bgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _TrendScreenPreview(trend: trend),
          ),
        ),
      ),
    );
  }
}

class _TrendScreenPreview extends StatelessWidget {
  final UITrend trend;
  const _TrendScreenPreview({required this.trend});

  @override
  Widget build(BuildContext context) {
    if (trend.id == 'glassmorphism') {
      return Container(
        color: const Color(0xFFD4AEFF),
        child: Stack(
          children: [
            Positioned(
              top: -10,
              right: -10,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: 8,
              top: 30,
              right: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 8,
              top: 64,
              right: 8,
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (trend.id == 'tokyo_night') {
      return Container(
        color: const Color(0xFF16161e),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0xFFff007c),
                  borderRadius: BorderRadius.circular(3),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFff007c).withValues(alpha: 0.8),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                height: 22,
                decoration: BoxDecoration(
                  color: const Color(0xFF24283b),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color(0xFF00e5ff).withValues(alpha: 0.4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00e5ff).withValues(alpha: 0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                height: 22,
                decoration: BoxDecoration(
                  color: const Color(0xFF24283b),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color(0xFF7aa2f7).withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (trend.id == 'tactile_industrial') {
      return Container(
        color: const Color(0xFF1A1A1A),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                height: 32,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFF242424),
                  border: Border.all(color: const Color(0xFF404040), width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B00),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Container(
                        height: 4,
                        color: const Color(0xFF404040),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF6B00),
                  borderRadius: BorderRadius.circular(2),
                  border: const Border(
                    bottom: BorderSide(color: Color(0xFF913D00), width: 2),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (trend.id == 'holo_glass') {
      return Container(
        color: const Color(0xFF0F172A),
        child: Stack(
          children: [
            // Holographic background light
            Positioned(
              left: -20,
              top: -20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF00F2FF).withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Iridescent Glass Card
            Positioned(
              left: 8,
              top: 30,
              right: 8,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      // Chromatic edge highlight
                      Positioned(
                        left: 0,
                        top: 0,
                        right: 0,
                        height: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFFF00E5),
                                Color(0xFF00F2FF),
                                Color(0xFFFF00E5),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 30,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFF00F2FF).withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 20,
                              height: 4,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF00E5).withValues(alpha: 0.4),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Small floating holo element
            Positioned(
              right: 12,
              bottom: 30,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF00F2FF), width: 0.5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00F2FF).withValues(alpha: 0.4),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else if (trend.id == 'mono_archive') {
      return Container(
        color: const Color(0xFFD1D1D1),
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            // Header bar
            Container(
              height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFF808080),
                border: Border(bottom: BorderSide(color: Colors.black, width: 1)),
              ),
            ),
            const SizedBox(height: 8),
            // Folder/Dossier Card
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                border: Border.all(color: Colors.black, width: 1),
                boxShadow: const [
                  BoxShadow(color: Color(0xFF808080), offset: Offset(2, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: const Color(0xFFE0E0E0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(width: 20, height: 1, color: Colors.black, margin: const EdgeInsets.only(left: 4)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 30, height: 2, color: Colors.black),
                        const SizedBox(height: 4),
                        Container(width: 45, height: 2, color: Colors.black.withValues(alpha: 0.4)),
                        const SizedBox(height: 2),
                        Container(width: 40, height: 2, color: Colors.black.withValues(alpha: 0.4)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Small data strip
            Row(
              children: [
                Container(width: 4, height: 4, color: Colors.black),
                const SizedBox(width: 4),
                Expanded(child: Container(height: 1, color: Colors.black)),
              ],
            ),
          ],
        ),
      );
    } else if (trend.id == 'lumine_glow') {
      return Container(
        color: const Color(0xFF1A1412),
        child: Stack(
          children: [
            // Background radiant glow
            Positioned(
              bottom: -30,
              right: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFFFB347).withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Glowing content card
            Positioned(
              left: 10,
              top: 35,
              right: 10,
              child: Column(
                children: [
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2420),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFB347).withValues(alpha: 0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 25,
                        height: 2,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFB347),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFFFB347).withValues(alpha: 0.6),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Secondary glow button
                  Container(
                    width: 30,
                    height: 6,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB347).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFD194).withValues(alpha: 0.4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (trend.id == 'neumorphism') {
      return Container(
        color: const Color(0xFFE0E5EC),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Concave central element
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E5EC),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.7),
                      offset: const Offset(-4, -4),
                      blurRadius: 8,
                    ),
                    BoxShadow(
                      color: const Color(0xFFA3B1C6).withValues(alpha: 0.4),
                      offset: const Offset(4, 4),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Center(
                  // Inner pressed element
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E5EC),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                         BoxShadow(
                          color: const Color(0xFFA3B1C6).withValues(alpha: 0.2),
                          offset: const Offset(1, 1),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Pill element
              Container(
                width: 45,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E5EC),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.7),
                      offset: const Offset(-2, -2),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: const Color(0xFFA3B1C6).withValues(alpha: 0.3),
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else if (trend.id == 'neo_clean') {
      return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(2, 2)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1.5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black, offset: Offset(2, 2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Default: Generic fallback for any other trends
      return Container(
        color: trend.bgColor,
        child: Center(
          child: Icon(Icons.palette, color: trend.accentColor.withValues(alpha: 0.5), size: 30),
        ),
      );
    }
  }
}
