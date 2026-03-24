import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../domain/ui_trend.dart';
import '../../projects/presentation/widgets/device_mockup.dart';
import 'widgets/ui_trend_mockup_content.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  Top-level screen (preserves _HeroSection, adds UITrendDesignExplorer)
// ─────────────────────────────────────────────────────────────────────────────
class UITrendDetailScreen extends StatelessWidget {
  final UITrend trend;

  const UITrendDetailScreen({super.key, required this.trend});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: trend.bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _HeroSection(trend: trend),
            UITrendDesignExplorer(trend: trend),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SECTION 1 — Hero (preserved as-is)
// ─────────────────────────────────────────────────────────────────────────────
class _HeroSection extends StatelessWidget {
  final UITrend trend;
  const _HeroSection({required this.trend});

  @override
  Widget build(BuildContext context) {
    final screenH = MediaQuery.sizeOf(context).height;
    final isNight = trend.id == 'tokyo_night';
    final isGlass = trend.id == 'glassmorphism';

    return SizedBox(
      height: screenH * 0.55,
      child: Stack(
        children: [
          // Background gradient fill
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(gradient: trend.backgroundGradient),
            ),
          ),

          // Decorative glows / blobs
          if (isNight) ...[
            Positioned(
              top: -60,
              left: -60,
              child: _NeonOrb(color: trend.accentColor, size: 320),
            ),
            Positioned(
              bottom: -80,
              right: -80,
              child: _NeonOrb(color: trend.secondaryAccent, size: 400),
            ),
          ] else if (isGlass) ...[
            Positioned(
              top: 40,
              left: -40,
              child: _GlassOrb(color: Colors.purple, size: 280),
            ),
            Positioned(
              bottom: 20,
              right: -40,
              child: _GlassOrb(color: Colors.blue, size: 360),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: const SizedBox.shrink(),
              ),
            ),
          ],

          if (!isGlass)
            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.25)),
            ),

          // Back button
          Positioned(
            top: MediaQuery.paddingOf(context).top + 16,
            left: 16,
            child: _GlassPill(
              trend: trend,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_new,
                    size: 18, color: trend.textColor),
                onPressed: () => context.pop(),
              ),
            ),
          ),

          // Label + title centered
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'UI AESTHETICS',
                  style: TextStyle(
                    color: trend.textColor.withValues(
                      alpha: isNight ? 1.0 : 0.65,
                    ),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  trend.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: trend.textColor,
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 6,
                    height: 0.9,
                    shadows: isNight
                        ? [
                            Shadow(color: trend.accentColor, blurRadius: 30),
                            Shadow(color: trend.secondaryAccent, blurRadius: 60),
                          ]
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                _GlassPill(
                  trend: trend,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    trend.tagline,
                    style: TextStyle(
                      color: isNight
                          ? trend.secondaryAccent
                          : trend.textColor.withValues(alpha: 0.8),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  SECTION 2 — Design Explorer (replaces old statics)
// ─────────────────────────────────────────────────────────────────────────────
class UITrendDesignExplorer extends StatefulWidget {
  final UITrend trend;
  const UITrendDesignExplorer({super.key, required this.trend});

  @override
  State<UITrendDesignExplorer> createState() => _UITrendDesignExplorerState();
}

class _UITrendDesignExplorerState extends State<UITrendDesignExplorer> {
  int _selectedView = 0;
  int _selectedSwatch = -1; // -1 = no override

  static const _views = [
    (label: 'Login', type: UITrendViewType.login, icon: Icons.login_outlined),
    (label: 'Form', type: UITrendViewType.form, icon: Icons.edit_note_outlined),
    (label: 'Cards', type: UITrendViewType.cards, icon: Icons.credit_card_outlined),
    (label: 'Carousel', type: UITrendViewType.carousel, icon: Icons.view_carousel_outlined),
  ];

  UITrend get trend => widget.trend;

  Color? get _accentOverride {
    if (_selectedSwatch >= 0 && _selectedSwatch < trend.palette.length) {
      return trend.palette[_selectedSwatch];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final viewportH = MediaQuery.sizeOf(context).height;

    return Container(
      color: trend.bgColor,
      padding: const EdgeInsets.symmetric(vertical: 56),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Heading ────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 3,
                      height: 18,
                      color: trend.accentColor,
                      margin: const EdgeInsets.only(right: 12),
                    ),
                    Text(
                      'EXPLORACIÓN DE DISEÑO',
                      style: TextStyle(
                        color: trend.accentColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Interactúa con el aesthetic.',
                  style: TextStyle(
                    color: trend.textColor,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                    shadows: trend.id == 'tokyo_night'
                        ? [Shadow(color: trend.accentColor, blurRadius: 12)]
                        : null,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 48),

          // ── Main row: preview + panel ─────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Left: Device Preview ─────────────────────────────
                Expanded(
                  child: _DevicePreviewArea(
                    trend: trend,
                    viewType: _views[_selectedView].type,
                    accentOverride: _accentOverride,
                    height: viewportH * 0.65,
                  ),
                ),

                const SizedBox(width: 40),

                // ── Right: Configurator panel ─────────────────────────
                SizedBox(
                  width: 300,
                  child: _ConfiguratorPanel(
                    trend: trend,
                    selectedView: _selectedView,
                    selectedSwatch: _selectedSwatch,
                    views: _views
                        .map((v) => (label: v.label, icon: v.icon))
                        .toList(),
                    onViewChanged: (i) => setState(() => _selectedView = i),
                    onSwatchChanged: (i) => setState(() =>
                        _selectedSwatch = (_selectedSwatch == i) ? -1 : i),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 48),

          // ── Bottom view carousel ──────────────────────────────────────
          _ViewCarousel(
            trend: trend,
            views: _views
                .map((v) => (label: v.label, type: v.type))
                .toList(),
            selectedIndex: _selectedView,
            accentOverride: _accentOverride,
            onSelect: (i) => setState(() => _selectedView = i),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Device Preview Area (left side)
// ─────────────────────────────────────────────────────────────────────────────
class _DevicePreviewArea extends StatelessWidget {
  final UITrend trend;
  final UITrendViewType viewType;
  final Color? accentOverride;
  final double height;

  const _DevicePreviewArea({
    required this.trend,
    required this.viewType,
    required this.accentOverride,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: trend.surfaceColor.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: trend.accentColor.withValues(alpha: 0.15),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 450),
          transitionBuilder: (child, anim) => FadeTransition(
            opacity: anim,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(anim),
              child: child,
            ),
          ),
          child: DeviceMockup(
            key: ValueKey('${viewType.name}_${accentOverride?.toARGB32()}'),
            type: DeviceType.phone,
            width: 290,
            height: height * 0.9,
            child: _ScaledPreviewContent(
              child: UITrendMockupContent(
                trend: trend,
                viewType: viewType,
                accentOverride: accentOverride,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Scales content to fit inside the device mockup
class _ScaledPreviewContent extends StatelessWidget {
  final Widget child;
  const _ScaledPreviewContent({required this.child});

  @override
  Widget build(BuildContext context) {
    const double designWidth = 390.0;
    const double designHeight = 844.0;
    return FittedBox(
      fit: BoxFit.contain,
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: designWidth,
        height: designHeight,
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            size: const Size(designWidth, designHeight),
            padding: const EdgeInsets.only(top: 50, bottom: 34),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Configurator Panel (right side)
// ─────────────────────────────────────────────────────────────────────────────
class _ConfiguratorPanel extends StatelessWidget {
  final UITrend trend;
  final int selectedView;
  final int selectedSwatch;
  final List<({String label, IconData icon})> views;
  final ValueChanged<int> onViewChanged;
  final ValueChanged<int> onSwatchChanged;

  const _ConfiguratorPanel({
    required this.trend,
    required this.selectedView,
    required this.selectedSwatch,
    required this.views,
    required this.onViewChanged,
    required this.onSwatchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Color Palette section
        _PanelSection(
          trend: trend,
          title: 'Paleta de color',
          initiallyExpanded: true,
          child: _ColorSwatchGrid(
            trend: trend,
            selectedSwatch: selectedSwatch,
            onSwatchChanged: onSwatchChanged,
          ),
        ),
        const SizedBox(height: 12),
        // View selector section
        _PanelSection(
          trend: trend,
          title: 'Vista del componente',
          initiallyExpanded: true,
          child: _ViewSelector(
            trend: trend,
            views: views,
            selectedView: selectedView,
            onViewChanged: onViewChanged,
          ),
        ),
        const SizedBox(height: 12),
        // About section
        _PanelSection(
          trend: trend,
          title: 'Sobre el estilo',
          child: Text(
            trend.description,
            style: TextStyle(
              color: trend.subtleTextColor,
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}

class _PanelSection extends StatefulWidget {
  final UITrend trend;
  final String title;
  final Widget child;
  final bool initiallyExpanded;

  const _PanelSection({
    required this.trend,
    required this.title,
    required this.child,
    this.initiallyExpanded = false,
  });

  @override
  State<_PanelSection> createState() => _PanelSectionState();
}

class _PanelSectionState extends State<_PanelSection> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final isNight = widget.trend.id == 'tokyo_night';
    final isGlass = widget.trend.id == 'glassmorphism';

    Widget container({required Widget child}) {
      if (isGlass) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: Colors.white.withValues(alpha: 0.3)),
              ),
              child: child,
            ),
          ),
        );
      }
      return Container(
        decoration: BoxDecoration(
          color: widget.trend.surfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isNight
                ? widget.trend.accentColor.withValues(alpha: 0.2)
                : Colors.black,
            width: isNight ? 1 : 2,
          ),
          boxShadow: isNight
              ? [
                  BoxShadow(
                    color: widget.trend.accentColor.withValues(alpha: 0.08),
                    blurRadius: 12,
                  )
                ]
              : const [BoxShadow(color: Colors.black, offset: Offset(3, 3))],
        ),
        child: child,
      );
    }

    return container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: widget.trend.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.0 : 0.5,
                    duration: const Duration(milliseconds: 250),
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      size: 18,
                      color: widget.trend.subtleTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 16),
              child: widget.child,
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Color Swatch Grid
// ─────────────────────────────────────────────────────────────────────────────
class _ColorSwatchGrid extends StatelessWidget {
  final UITrend trend;
  final int selectedSwatch;
  final ValueChanged<int> onSwatchChanged;

  const _ColorSwatchGrid({
    required this.trend,
    required this.selectedSwatch,
    required this.onSwatchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Toca para sobreescribir el acento',
          style: TextStyle(
              color: trend.subtleTextColor, fontSize: 11, height: 1.4),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: List.generate(trend.palette.length, (i) {
            final isSelected = selectedSwatch == i;
            final color = trend.palette[i];
            return GestureDetector(
              onTap: () => onSwatchChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(
                      trend.id == 'neo_clean' ? 0 : 10),
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.transparent,
                    width: 3,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.6),
                            blurRadius: 16,
                            spreadRadius: 2,
                          )
                        ]
                      : trend.id == 'neo_clean'
                          ? const [
                              BoxShadow(
                                  color: Colors.black, offset: Offset(2, 2))
                            ]
                          : null,
                ),
                child: isSelected
                    ? const Icon(Icons.check,
                        color: Colors.white, size: 20)
                    : null,
              ),
            );
          }),
        ),
        if (selectedSwatch >= 0) ...[
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => onSwatchChanged(-1),
            child: Row(
              children: [
                Icon(Icons.refresh, color: trend.accentColor, size: 14),
                const SizedBox(width: 6),
                Text(
                  'Restablecer original',
                  style: TextStyle(
                    color: trend.accentColor,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  View Selector
// ─────────────────────────────────────────────────────────────────────────────
class _ViewSelector extends StatelessWidget {
  final UITrend trend;
  final List<({String label, IconData icon})> views;
  final int selectedView;
  final ValueChanged<int> onViewChanged;

  const _ViewSelector({
    required this.trend,
    required this.views,
    required this.selectedView,
    required this.onViewChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(views.length, (i) {
        final isSelected = i == selectedView;
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GestureDetector(
            onTap: () => onViewChanged(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected
                    ? trend.accentColor.withValues(alpha: 0.15)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(
                    trend.id == 'neo_clean' ? 0 : 10),
                border: Border.all(
                  color: isSelected
                      ? trend.accentColor
                      : trend.textColor.withValues(alpha: 0.1),
                  width: isSelected ? 1.5 : 1,
                ),
                boxShadow: isSelected && trend.id == 'tokyo_night'
                    ? [
                        BoxShadow(
                          color: trend.accentColor.withValues(alpha: 0.2),
                          blurRadius: 10,
                        )
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  Icon(
                    views[i].icon,
                    size: 18,
                    color: isSelected
                        ? trend.accentColor
                        : trend.subtleTextColor,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    views[i].label,
                    style: TextStyle(
                      color: isSelected ? trend.textColor : trend.subtleTextColor,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  if (isSelected)
                    Icon(Icons.chevron_right,
                        color: trend.accentColor, size: 16),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Bottom View Carousel (thumbnail strip like ProjectDesignExplorer)
// ─────────────────────────────────────────────────────────────────────────────
class _ViewCarousel extends StatelessWidget {
  final UITrend trend;
  final List<({String label, UITrendViewType type})> views;
  final int selectedIndex;
  final Color? accentOverride;
  final ValueChanged<int> onSelect;

  const _ViewCarousel({
    required this.trend,
    required this.views,
    required this.selectedIndex,
    required this.accentOverride,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 60),
              itemCount: views.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final isSelected = i == selectedIndex;
                return GestureDetector(
                  onTap: () => onSelect(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 128,
                    height: 88,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          trend.id == 'neo_clean' ? 0 : 12),
                      border: Border.all(
                        color: isSelected
                            ? trend.accentColor
                            : trend.textColor.withValues(alpha: 0.15),
                        width: isSelected ? 2 : 1,
                      ),
                      color: trend.surfaceColor.withValues(
                          alpha: isSelected ? 0.5 : 0.2),
                      boxShadow: isSelected && trend.id == 'tokyo_night'
                          ? [
                              BoxShadow(
                                color:
                                    trend.accentColor.withValues(alpha: 0.3),
                                blurRadius: 12,
                              )
                            ]
                          : null,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        // Mini preview
                        Positioned.fill(
                          child: Opacity(
                            opacity: isSelected ? 1.0 : 0.45,
                            child: IgnorePointer(
                              child: _ScaledPreviewContent(
                                child: UITrendMockupContent(
                                  trend: trend,
                                  viewType: views[i].type,
                                  accentOverride: accentOverride,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Label at bottom
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            color: Colors.black.withValues(alpha: 0.55),
                            child: Text(
                              views[i].label.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isSelected
                                    ? trend.accentColor
                                    : Colors.white70,
                                fontSize: 9,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 60),
            child: Icon(
              Icons.chevron_right,
              color: trend.textColor.withValues(alpha: 0.2),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Reusable decorative helpers (kept from original)
// ─────────────────────────────────────────────────────────────────────────────
class _NeonOrb extends StatelessWidget {
  final Color color;
  final double size;
  const _NeonOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 80,
              spreadRadius: 20),
        ],
      ),
    );
  }
}

class _GlassOrb extends StatelessWidget {
  final Color color;
  final double size;
  const _GlassOrb({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.45),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _GlassPill extends StatelessWidget {
  final UITrend trend;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const _GlassPill({
    required this.trend,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
                color: trend.textColor.withValues(alpha: 0.15), width: 1),
          ),
          child: child,
        ),
      ),
    );
  }
}
