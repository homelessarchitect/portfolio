import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../../domain/project.dart';
import 'device_mockup.dart';

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
    scaffoldBackgroundColor: isDark
        ? const Color(0xFF050505)
        : const Color(0xFFF5F5F7),
    fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
  );
}

// ─── Layout constants ────────────────────────────────────────────────────────
const double _kPanelWidth = 300;
const double _kCarouselThumbWidth = 112;
const double _kCarouselThumbHeight = 80;
const double _kMainPreviewHeight = 560;

class ProjectDesignExplorer extends StatefulWidget {
  final Project project;

  const ProjectDesignExplorer({super.key, required this.project});

  @override
  State<ProjectDesignExplorer> createState() => _ProjectDesignExplorerState();
}

class _ProjectDesignExplorerState extends State<ProjectDesignExplorer> {
  int _selectedScreenIndex = 0;
  bool _isDarkMode = true;
  late bool _viewingMobile;

  List<SimulationScreen> get _screens =>
      widget.project.designScreens.where((s) {
        if (s.platform == null) {
          return true; // Show in both if not explicitly tagged
        }
        if (_viewingMobile) return s.platform == ProjectPlatform.mobile;
        return s.platform == ProjectPlatform.web ||
            s.platform == ProjectPlatform.desktop;
      }).toList();

  @override
  void initState() {
    super.initState();
    _viewingMobile =
        widget.project.platforms.contains(ProjectPlatform.mobile) ||
        widget.project.platforms.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasMobile = widget.project.platforms.contains(ProjectPlatform.mobile);
    final hasWeb =
        widget.project.platforms.contains(ProjectPlatform.web) ||
        widget.project.platforms.contains(ProjectPlatform.desktop);
    final showPlatformSelector = hasMobile && hasWeb;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      color: _isDarkMode
          ? const Color(0xFF050505)
          : theme.colorScheme.surfaceContainerLowest.withValues(alpha: 0.5),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Fallback to a fixed height if the parent (like a SliverToBoxAdapter) 
          // provides infinite height constraints.
          final previewHeight = constraints.hasBoundedHeight 
              ? constraints.maxHeight * 0.6 
              : _kMainPreviewHeight;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Heading ──────────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth < 800 ? 20 : 80,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EXPLORACIÓN DE DISEÑO',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Excepcional por dentro y por fuera.',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // ── Configurator row: preview + panel ─────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth < 800 ? 20 : 80,
                ),
                child: constraints.maxWidth < 1000
                    ? Column(
                        children: [
                          SizedBox(
                            height: previewHeight,
                            child: _MainPreview(
                              project: widget.project,
                              screens: _screens,
                              selectedIndex: _selectedScreenIndex,
                              isDarkMode: _isDarkMode,
                              isMobile: _viewingMobile,
                              onDarkModeToggle: (v) =>
                                  setState(() => _isDarkMode = v),
                              onDotTap: (i) =>
                                  setState(() => _selectedScreenIndex = i),
                            ),
                          ),
                          const SizedBox(height: 32),
                          _ConfiguratorPanel(
                            isDarkMode: _isDarkMode,
                            styleDescription: widget.project.styleDescription,
                            onThemeChanged: (v) =>
                                setState(() => _isDarkMode = v),
                            showPlatformSelector: showPlatformSelector,
                            isMobileApp: _viewingMobile,
                            onPlatformChanged: (v) {
                              setState(() {
                                _viewingMobile = v;
                                _selectedScreenIndex = 0;
                              });
                            },
                          ),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ── Left: main preview ──────────────────────────────────
                          Expanded(
                            child: SizedBox(
                              height: previewHeight,
                              child: _MainPreview(
                                project: widget.project,
                                screens: _screens,
                                selectedIndex: _selectedScreenIndex,
                                isDarkMode: _isDarkMode,
                                isMobile: _viewingMobile,
                                onDarkModeToggle: (v) =>
                                    setState(() => _isDarkMode = v),
                                onDotTap: (i) =>
                                    setState(() => _selectedScreenIndex = i),
                              ),
                            ),
                          ),

                          const SizedBox(width: 48),

                          // ── Right: configurator panel ─────────────────────────
                          SizedBox(
                            width: _kPanelWidth + 40,
                            child: _ConfiguratorPanel(
                              isDarkMode: _isDarkMode,
                              styleDescription:
                                  widget.project.styleDescription,
                              onThemeChanged: (v) =>
                                  setState(() => _isDarkMode = v),
                              showPlatformSelector: showPlatformSelector,
                              isMobileApp: _viewingMobile,
                              onPlatformChanged: (v) {
                                setState(() {
                                  _viewingMobile = v;
                                  _selectedScreenIndex = 0;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
              ),

              const SizedBox(height: 48),

              // ── Bottom thumbnail carousel ──────────────────────────────────
              if (_screens.isNotEmpty)
                _BottomCarousel(
                  project: widget.project,
                  screens: _screens,
                  selectedIndex: _selectedScreenIndex,
                  isDarkMode: _isDarkMode,
                  isMobile: _viewingMobile,
                  onSelect: (i) => setState(() => _selectedScreenIndex = i),
                ),
            ],
          );
        },
      ),
    );
  }
}

// ─── Main Preview ────────────────────────────────────────────────────────────
class _MainPreview extends StatelessWidget {
  final Project project;
  final List<SimulationScreen> screens;
  final int selectedIndex;
  final bool isDarkMode;
  final bool isMobile;
  final ValueChanged<bool> onDarkModeToggle;
  final ValueChanged<int> onDotTap;

  const _MainPreview({
    required this.project,
    required this.screens,
    required this.selectedIndex,
    required this.isDarkMode,
    required this.isMobile,
    required this.onDarkModeToggle,
    required this.onDotTap,
  });

  void _showFullScreen(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, anim1, anim2) {
        return _FullScreenPreview(
          project: project,
          screens: screens,
          initialIndex: selectedIndex,
          isDarkMode: isDarkMode,
          isMobile: isMobile,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentScreen = screens.isNotEmpty ? screens[selectedIndex] : null;

    return Container(
      height: _kMainPreviewHeight,
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(0xFF0F0F0F)
            : theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.25,
              ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Centered device mockup
          Center(
            child: GestureDetector(
              onTap: () => _showFullScreen(context),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 450),
                  transitionBuilder: (child, anim) => FadeTransition(
                    opacity: anim,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.95, end: 1.0).animate(anim),
                      child: child,
                    ),
                  ),
                  child: Theme(
                    key: ValueKey('screen_$selectedIndex'),
                    data: _buildMockTheme(context, isDarkMode, project),
                    child: DeviceMockup(
                      type: isMobile ? DeviceType.phone : DeviceType.monitor,
                      width: isMobile ? 280 : 580,
                      height: 540,
                      child: _ScaledPreviewContent(
                        isMobile: isMobile,
                        allowScroll: true,
                        child: currentScreen?.builder() ?? const SizedBox(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom-left: Dark/Light toggle badge
          Positioned(
            left: 16,
            bottom: 48,
            child: _ThemeBadge(
              isDarkMode: isDarkMode,
              onToggle: onDarkModeToggle,
            ),
          ),

          // Bottom: Pagination dots
          if (screens.length > 1)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(screens.length, (i) {
                  final isActive = i == selectedIndex;
                  return GestureDetector(
                    onTap: () => onDotTap(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isActive ? 20 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isActive
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Theme badge (moon icon, like Porsche's bottom-left button) ──────────────
class _ThemeBadge extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onToggle;

  const _ThemeBadge({required this.isDarkMode, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(!isDarkMode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black87 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDarkMode
                ? Colors.white.withValues(alpha: 0.15)
                : Colors.black.withValues(alpha: 0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8,
            ),
          ],
        ),
        child: Icon(
          isDarkMode ? Icons.dark_mode : Icons.light_mode,
          size: 18,
          color: isDarkMode ? Colors.white70 : Colors.black54,
        ),
      ),
    );
  }
}

// ─── Bottom carousel ─────────────────────────────────────────────────────────
class _BottomCarousel extends StatelessWidget {
  final Project project;
  final List<SimulationScreen> screens;
  final int selectedIndex;
  final bool isDarkMode;
  final ValueChanged<int> onSelect;

  final bool isMobile;

  const _BottomCarousel({
    required this.project,
    required this.screens,
    required this.selectedIndex,
    required this.isDarkMode,
    required this.isMobile,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: _kCarouselThumbHeight + 8,
      child: Row(
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width < 800 ? 20 : 80,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: screens.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                return GestureDetector(
                  onTap: () => onSelect(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: _kCarouselThumbWidth,
                    height: _kCarouselThumbHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outline.withValues(alpha: 0.25),
                        width: isSelected ? 2.5 : 1,
                      ),
                      color: isDarkMode
                          ? const Color(0xFF1A1A1A)
                          : theme.colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.3),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Opacity(
                            opacity: isSelected ? 1.0 : 0.55,
                            child: IgnorePointer(
                              child: Theme(
                                data: _buildMockTheme(
                                  context,
                                  isDarkMode,
                                  project,
                                ),
                                child: _ScaledPreviewContent(
                                  isMobile: isMobile,
                                  allowScroll: false,
                                  child: screens[index].builder(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Label overlay at bottom
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            color: Colors.black54,
                            child: Text(
                              screens[index].label,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
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
          // Scroll hint arrow
          Padding(
            padding: const EdgeInsets.only(right: 80),
            child: Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Right configurator panel ──────────────────────────────────────────────
class _ConfiguratorPanel extends StatelessWidget {
  final bool isDarkMode;
  final String styleDescription;
  final ValueChanged<bool> onThemeChanged;
  final bool showPlatformSelector;
  final bool isMobileApp;
  final ValueChanged<bool> onPlatformChanged;

  const _ConfiguratorPanel({
    required this.isDarkMode,
    required this.styleDescription,
    required this.onThemeChanged,
    required this.showPlatformSelector,
    required this.isMobileApp,
    required this.onPlatformChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(0xFF121212)
            : Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        children: [
          // Divider line on top right (like Porsche panel scrollbar)
          if (showPlatformSelector)
            _ConfiguratorSection(
              title: 'Plataforma',
              initiallyExpanded: true,
              child: _PlatformPalette(
                isMobileApp: isMobileApp,
                onChanged: onPlatformChanged,
              ),
            ),
          _ConfiguratorSection(
            title: 'Modo de Tema',
            initiallyExpanded: showPlatformSelector ? false : true,
            child: _ThemePalette(
              isDarkMode: isDarkMode,
              onChanged: onThemeChanged,
            ),
          ),
          _ConfiguratorSection(
            title: 'Pantallas',
            initiallyExpanded: true,
            child: _ScreensInfo(isDarkMode: isDarkMode),
          ),
          _ConfiguratorSection(
            title: 'Estilos & Widgets',
            child: _StyleDescription(description: styleDescription),
          ),
        ],
      ),
    );
  }
}

class _ConfiguratorSection extends StatefulWidget {
  final String title;
  final Widget child;
  final bool initiallyExpanded;

  const _ConfiguratorSection({
    required this.title,
    required this.child,
    this.initiallyExpanded = false,
  });

  @override
  State<_ConfiguratorSection> createState() => _ConfiguratorSectionState();
}

class _ConfiguratorSectionState extends State<_ConfiguratorSection> {
  late bool _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        InkWell(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  _expanded ? Icons.remove : Icons.add,
                  size: 18,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(width: double.infinity),
          secondChild: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: widget.child,
          ),
          crossFadeState: _expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
        Divider(
          height: 1,
          color: theme.colorScheme.outline.withValues(alpha: 0.12),
        ),
      ],
    );
  }
}

/// Tema swatches: dark & light pill options (like Porsche "Contrastes")
class _ThemePalette extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  const _ThemePalette({required this.isDarkMode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget swatch({
      required Color color,
      required String label,
      required bool selected,
    }) {
      return Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline.withValues(alpha: 0.2),
                width: selected ? 2.5 : 1,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modo de visualización',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            GestureDetector(
              onTap: () => onChanged(true),
              child: swatch(
                color: const Color(0xFF050505),
                label: 'Dark',
                selected: isDarkMode,
              ),
            ),
            const SizedBox(width: 24),
            GestureDetector(
              onTap: () => onChanged(false),
              child: swatch(
                color: const Color(0xFFF5F5F7),
                label: 'Light',
                selected: !isDarkMode,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Platform swatches: mobile & web pill options
class _PlatformPalette extends StatelessWidget {
  final bool isMobileApp;
  final ValueChanged<bool> onChanged;

  const _PlatformPalette({required this.isMobileApp, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget swatch({
      required IconData icon,
      required String label,
      required bool selected,
    }) {
      return Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: selected
                  ? theme.colorScheme.primary.withValues(alpha: 0.1)
                  : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline.withValues(alpha: 0.2),
                width: selected ? 2.5 : 1,
              ),
            ),
            child: Icon(
              icon,
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.6),
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Formato de visualización',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            GestureDetector(
              onTap: () => onChanged(true),
              child: swatch(
                icon: Icons.smartphone,
                label: 'Mobile',
                selected: isMobileApp,
              ),
            ),
            const SizedBox(width: 24),
            GestureDetector(
              onTap: () => onChanged(false),
              child: swatch(
                icon: Icons.desktop_mac,
                label: 'Web',
                selected: !isMobileApp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// ScreensInfo shows a small list of screen names (like Porsche "Rines")
class _ScreensInfo extends StatelessWidget {
  final bool isDarkMode;

  const _ScreensInfo({required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pantallas en esta demo',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          isDarkMode
              ? 'Tema oscuro activo. Toca el ícono 🌙 en la preview para cambiar.'
              : 'Tema claro activo. Toca el ícono ☀️ en la preview para cambiar.',
          style: theme.textTheme.bodySmall?.copyWith(height: 1.5),
        ),
      ],
    );
  }
}

/// Freeform style description text
class _StyleDescription extends StatelessWidget {
  final String description;

  const _StyleDescription({required this.description});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      description,
      style: theme.textTheme.bodySmall?.copyWith(
        height: 1.6,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
      ),
    );
  }
}

class _ScaledPreviewContent extends StatelessWidget {
  final Widget child;
  final bool isMobile;
  final bool allowScroll;

  const _ScaledPreviewContent({
    required this.child,
    required this.isMobile,
    this.allowScroll = true,
  });

  @override
  Widget build(BuildContext context) {
    // Exact sizing to match the new DeviceMockup frame geometry
    final double designWidth = isMobile ? 390 : 1440;
    final double designHeight = isMobile ? 844 : 900;

    Widget content = SizedBox(
      width: designWidth,
      height: designHeight,
      child: isMobile
          ? MediaQuery(
              data: MediaQuery.of(context).copyWith(
                size: Size(designWidth, designHeight),
                padding: const EdgeInsets.only(
                  top: 59,
                  bottom: 34,
                ), // iPhone safe area
              ),
              child: child,
            )
          : child,
    );

    if (allowScroll) {
      content = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: AbsorbPointer(child: content),
      );
    } else {
      content = AbsorbPointer(child: content);
    }

    return FittedBox(
      fit: BoxFit.contain,
      alignment: Alignment.topCenter,
      child: content,
    );
  }
}

class _FullScreenPreview extends StatefulWidget {
  final Project project;
  final List<SimulationScreen> screens;
  final int initialIndex;
  final bool isDarkMode;
  final bool isMobile;

  const _FullScreenPreview({
    required this.project,
    required this.screens,
    required this.initialIndex,
    required this.isDarkMode,
    required this.isMobile,
  });

  @override
  State<_FullScreenPreview> createState() => _FullScreenPreviewState();
}

class _FullScreenPreviewState extends State<_FullScreenPreview> {
  late int _currentIndex;
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _isDarkMode = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = widget.isMobile;
    final currentScreen = widget.screens.isNotEmpty
        ? widget.screens[_currentIndex]
        : null;

    return Theme(
      data: _buildMockTheme(context, _isDarkMode, widget.project),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // 1. Glassmorphic Background
            Positioned.fill(
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  color: Colors.black.withValues(alpha: 0.4),
                  child: GlassmorphicContainer(
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: 0,
                    blur: 30,
                    alignment: Alignment.center,
                    border: 0,
                    linearGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.black12, Colors.black26],
                    ),
                    borderGradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.white10, Colors.white10],
                    ),
                    child: SizedBox.expand(),
                  ),
                ),
              ),
            ),

            // 2. Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Device Mockup
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: DeviceMockup(
                        type: isMobile ? DeviceType.phone : DeviceType.monitor,
                        width: isMobile ? 340 : 1000,
                        height: isMobile ? 680 : 600,
                        child: _ScaledPreviewContent(
                          isMobile: isMobile,
                          child: currentScreen?.builder() ?? const SizedBox(),
                        ),
                      ),
                    ),
                  ),

                  // Label & Pagination
                  if (widget.screens.length > 1)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        currentScreen?.label.toUpperCase() ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),

                  // Simple navigation
                  if (widget.screens.length > 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _NavButton(
                          icon: Icons.chevron_left,
                          onPressed: _currentIndex > 0
                              ? () => setState(() => _currentIndex--)
                              : null,
                        ),
                        const SizedBox(width: 40),
                        _NavButton(
                          icon: Icons.chevron_right,
                          onPressed: _currentIndex < widget.screens.length - 1
                              ? () => setState(() => _currentIndex++)
                              : null,
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // 3. Top Controls
            Positioned(
              top: 40,
              right: 40,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 32),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            // Theme Toggle
            Positioned(
              top: 40,
              left: 40,
              child: _ThemeBadge(
                isDarkMode: _isDarkMode,
                onToggle: (v) => setState(() => _isDarkMode = v),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _NavButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: onPressed != null ? Colors.white : Colors.white24,
        size: 36,
      ),
    );
  }
}
