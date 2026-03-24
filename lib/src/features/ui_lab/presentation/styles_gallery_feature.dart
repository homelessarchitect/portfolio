import 'dart:ui';
import 'package:flutter/material.dart';
import '../../projects/presentation/widgets/device_mockup.dart';
import '../data/ui_trends_catalog.dart';
import '../domain/ui_trend.dart';
import 'widgets/ui_trend_mockup_content.dart';

enum UIStyle {
  glassmorphism,
  tokyoNight,
  minimal,
}

class StylesGalleryFeature extends StatefulWidget {
  const StylesGalleryFeature({super.key});

  @override
  State<StylesGalleryFeature> createState() => _StylesGalleryFeatureState();
}

class _StylesGalleryFeatureState extends State<StylesGalleryFeature> {
  UIStyle _currentStyle = UIStyle.tokyoNight;

  /// Map each UIStyle to the corresponding UITrend from the catalog.
  String get _currentTrendId {
    switch (_currentStyle) {
      case UIStyle.glassmorphism:
        return 'glassmorphism';
      case UIStyle.tokyoNight:
        return 'tokyo_night';
      case UIStyle.minimal:
        return 'neo_clean';
    }
  }

  @override
  Widget build(BuildContext context) {
    final trend = uiTrendsCatalog.firstWhere((t) => t.id == _currentTrendId);

    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 800),
            child: _buildBackground(key: ValueKey(_currentStyle), trend: trend),
          ),

          // Content
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // Header
                  _buildHeader(trend),

                  const Spacer(),

                  // Center Mockup — reuses UITrendMockupContent
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    child: DeviceMockup(
                      key: ValueKey(_currentStyle),
                      type: DeviceType.phone,
                      width: 340,
                      height: 700,
                      child: UITrendMockupContent(trend: trend),
                    ),
                  ),

                  const Spacer(),
                  // Style Selector
                  _buildStyleSelector(),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground({required Key key, required UITrend trend}) {
    switch (_currentStyle) {
      case UIStyle.glassmorphism:
        return Container(
          key: key,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 100,
                left: 100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                right: 100,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.4),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                child: Container(color: Colors.transparent),
              ),
            ],
          ),
        );
      case UIStyle.tokyoNight:
        return Container(
          key: key,
          color: const Color(0xFF1a1b26),
          child: Stack(
            children: [
              // Neon subtle glows
              Positioned(
                top: -50,
                left: -50,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    color: const Color(0xFFff007c).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFff007c).withValues(alpha: 0.3),
                        blurRadius: 100,
                        spreadRadius: 50,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: -50,
                right: -50,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00e5ff).withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00e5ff).withValues(alpha: 0.3),
                        blurRadius: 100,
                        spreadRadius: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case UIStyle.minimal:
        return Container(
          key: key,
          color: const Color(0xFFF4F4F5),
        );
    }
  }

  Widget _buildHeader(UITrend trend) {
    Color textColor;
    switch (_currentStyle) {
      case UIStyle.glassmorphism:
      case UIStyle.tokyoNight:
        textColor = Colors.white;
        break;
      case UIStyle.minimal:
        textColor = Colors.black87;
        break;
    }

    return Column(
      children: [
        Text(
          'ESTÉTICAS UI',
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _styleTitle(_currentStyle),
          style: TextStyle(
            color: textColor,
            fontSize: 48,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
            shadows: _currentStyle == UIStyle.tokyoNight
                ? const [
                    Shadow(
                      color: Color(0xFF00e5ff),
                      blurRadius: 20,
                    ),
                  ]
                : null,
          ),
        ),
      ],
    );
  }

  String _styleTitle(UIStyle style) {
    switch (style) {
      case UIStyle.glassmorphism:
        return 'Glassmorphism';
      case UIStyle.tokyoNight:
        return 'Tokyo Night';
      case UIStyle.minimal:
        return 'Neo Clean';
    }
  }

  Widget _buildStyleSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: UIStyle.values.map((style) {
              final isSelected = style == _currentStyle;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentStyle = style;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    _styleTitle(style),
                    style: TextStyle(
                      color: isSelected ? Colors.black : Colors.white70,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
