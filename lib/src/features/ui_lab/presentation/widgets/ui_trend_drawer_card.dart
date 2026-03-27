import 'dart:ui';
import 'package:flutter/material.dart';
import '../../domain/ui_trend.dart';

/// Compact preview card used in the drawer's horizontal scroll for UI Trends.
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 280,
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          gradient: trend.backgroundGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: trend.accentColor.withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Background glow decoration
              if (trend.id == 'tokyo_night') ...[
                Positioned(
                  top: -20,
                  right: -20,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: trend.accentColor.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: trend.accentColor.withValues(alpha: 0.5),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  left: -20,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: trend.secondaryAccent.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: trend.secondaryAccent.withValues(alpha: 0.5),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mini phone mockup
                    _MiniPhoneMockup(trend: trend),

                    const Spacer(),

                    // Bottom info
                    Text(
                      trend.name.toUpperCase(),
                      style: TextStyle(
                        color: trend.textColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      trend.tagline,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: trend.subtleTextColor,
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ...trend.palette
                            .take(4)
                            .map(
                              (c) => Container(
                                width: 12,
                                height: 12,
                                margin: const EdgeInsets.only(right: 4),
                                decoration: BoxDecoration(
                                  color: c,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: trend.textColor.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: trend.textColor.withValues(alpha: 0.6),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniPhoneMockup extends StatelessWidget {
  final UITrend trend;

  const _MiniPhoneMockup({required this.trend});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 70,
        height: 130,
        child: Stack(
          children: [
            // Phone body
            Container(
              decoration: BoxDecoration(
                color: trend.id == 'glassmorphism'
                    ? Colors.white.withValues(alpha: 0.3)
                    : const Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: trend.id == 'glassmorphism'
                      ? Colors.white.withValues(alpha: 0.6)
                      : trend.accentColor.withValues(alpha: 0.6),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: trend.accentColor.withValues(alpha: 0.3),
                    blurRadius: 15,
                  ),
                ],
              ),
              // Screen content
              child: ClipRRect(
                borderRadius: BorderRadius.circular(13),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: _buildMockupScreen(),
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
                  width: 22,
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

  Widget _buildMockupScreen() {
    if (trend.id == 'glassmorphism') {
      return Container(
        color: const Color(0xFFD4AEFF),
        child: Stack(
          children: [
            // Purple blob
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
            // Glass card
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
    } else {
      // Neo clean
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
    }
  }
}
