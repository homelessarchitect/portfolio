import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../domain/project.dart';

// ------------------------------------------------------------------ //
//  Hero Device Mockup                                                  //
//  Full-screen animated device preview for hero sections.              //
//  Renders the project's homeViews inside phone/macbook frames         //
//  with entrance animations + subtle floating motion.                  //
// ------------------------------------------------------------------ //

class HeroDeviceMockup extends StatefulWidget {
  final Project project;

  /// Height of the hero container.
  final double height;

  const HeroDeviceMockup({
    super.key,
    required this.project,
    this.height = 600,
  });

  @override
  State<HeroDeviceMockup> createState() => _HeroDeviceMockupState();
}

class _HeroDeviceMockupState extends State<HeroDeviceMockup>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _floatController;

  // Entrance animations
  late final Animation<double> _fadeIn;
  late final Animation<Offset> _macbookSlide;
  late final Animation<Offset> _phoneSlide;

  @override
  void initState() {
    super.initState();

    // Entrance: fade + slide-up, staggered
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeIn = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    );

    _macbookSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
    ));

    _phoneSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.15, 0.85, curve: Curves.easeOutCubic),
    ));

    // Continuous floating (gentle oscillation on the phone)
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _entranceController.forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasMobile =
        widget.project.platforms.contains(ProjectPlatform.mobile);
    final hasWeb = widget.project.platforms.contains(ProjectPlatform.web) ||
        widget.project.platforms.contains(ProjectPlatform.desktop);
    final hasViews = widget.project.homeViews.isNotEmpty;

    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: hasViews
          ? _buildDeviceMockups(hasMobile: hasMobile, hasWeb: hasWeb)
          : _buildFallback(context),
    );
  }

  Widget _buildDeviceMockups({
    required bool hasMobile,
    required bool hasWeb,
  }) {
    if (hasMobile && hasWeb) {
      return _buildPhoneAndMacbook();
    } else if (hasMobile) {
      return _buildPhoneOnly();
    } else {
      return _buildMacbookOnly();
    }
  }

  // ---- Phone + MacBook composition ----
  Widget _buildPhoneAndMacbook() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FadeTransition(
          opacity: _fadeIn,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // MacBook — behind, slightly right
              SlideTransition(
                position: _macbookSlide,
                child: Align(
                  alignment: const Alignment(0.15, 0.1),
                  child: _HeroMacbookMockup(
                    project: widget.project,
                    maxWidth: constraints.maxWidth * 0.55,
                  ),
                ),
              ),
              // Phone — in front, left
              SlideTransition(
                position: _phoneSlide,
                child: AnimatedBuilder(
                  animation: _floatController,
                  builder: (context, child) {
                    final float = math.sin(
                            _floatController.value * math.pi) *
                        6;
                    return Transform.translate(
                      offset: Offset(0, float),
                      child: child,
                    );
                  },
                  child: Align(
                    alignment: const Alignment(-0.35, 0.05),
                    child: _HeroPhoneMockup(
                      project: widget.project,
                      maxHeight: constraints.maxHeight * 0.85,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---- Phone only ----
  Widget _buildPhoneOnly() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _phoneSlide,
            child: AnimatedBuilder(
              animation: _floatController,
              builder: (context, child) {
                final float =
                    math.sin(_floatController.value * math.pi) * 6;
                return Transform.translate(
                  offset: Offset(0, float),
                  child: child,
                );
              },
              child: Center(
                child: _HeroPhoneMockup(
                  project: widget.project,
                  maxHeight: constraints.maxHeight * 0.9,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // ---- MacBook only ----
  Widget _buildMacbookOnly() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FadeTransition(
          opacity: _fadeIn,
          child: SlideTransition(
            position: _macbookSlide,
            child: Center(
              child: _HeroMacbookMockup(
                project: widget.project,
                maxWidth: constraints.maxWidth * 0.65,
              ),
            ),
          ),
        );
      },
    );
  }

  // ---- Fallback (no homeViews) ----
  Widget _buildFallback(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.surfaceContainerHighest,
            theme.colorScheme.surface,
          ],
        ),
      ),
      child: Center(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Text(
            widget.project.title.toUpperCase(),
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 6,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.15),
            ),
          ),
        ),
      ),
    );
  }
}

// ================================================================== //
//  Hero-sized Phone Mockup                                             //
// ================================================================== //
class _HeroPhoneMockup extends StatelessWidget {
  final Project project;
  final double maxHeight;

  const _HeroPhoneMockup({
    required this.project,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    final mobileView = project.homeViews[ProjectPlatform.mobile];

    // Aspect ratio ≈ 1:2 for a phone
    final phoneHeight = maxHeight.clamp(200.0, 500.0);
    final phoneWidth = phoneHeight * 0.5;

    return SizedBox(
      width: phoneWidth,
      height: phoneHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Phone body
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(phoneWidth * 0.14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(phoneWidth * 0.04),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(phoneWidth * 0.12),
                child: mobileView != null
                    ? OverflowBox(
                        alignment: Alignment.topCenter,
                        maxWidth: 400,
                        maxHeight: 860,
                        child: Transform.scale(
                          scale: phoneWidth * 0.92 / 400,
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
            top: phoneHeight * 0.025,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: phoneWidth * 0.28,
                height: phoneHeight * 0.018,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(phoneHeight * 0.01),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================== //
//  Hero-sized MacBook Mockup                                           //
// ================================================================== //
class _HeroMacbookMockup extends StatelessWidget {
  final Project project;
  final double maxWidth;

  const _HeroMacbookMockup({
    required this.project,
    required this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final webView = project.homeViews[ProjectPlatform.web];

    final macWidth = maxWidth.clamp(300.0, 700.0);
    // MacBook aspect ratio ≈ 16:10 for screen + base
    final macHeight = macWidth * 0.65;

    return SizedBox(
      width: macWidth,
      height: macHeight,
      child: Column(
        children: [
          // Screen
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1C1C1E),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                border: Border.all(
                  color: const Color(0xFF3A3A3C),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 12),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: webView != null
                      ? OverflowBox(
                          alignment: Alignment.topCenter,
                          maxWidth: 1440,
                          maxHeight: 900,
                          child: Transform.scale(
                            scale: (macWidth - 14) / 1440,
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              width: 1440,
                              height: 900,
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
            height: macHeight * 0.06,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFC0C0C0), Color(0xFF9E9E9E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
              border: Border.all(
                color: const Color(0xFF888888),
                width: 1,
              ),
            ),
            child: Center(
              child: Container(
                width: macWidth * 0.15,
                height: macHeight * 0.02,
                decoration: BoxDecoration(
                  color: const Color(0xFF888888),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
