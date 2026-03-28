import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../state/drawer_state.dart';
import '../../../features/projects/data/mock_projects.dart';
import '../../../features/projects/presentation/widgets/project_drawer_thumbnail.dart';
import '../../../features/ui_lab/data/ui_trends_catalog.dart';
import '../../../features/ui_lab/presentation/widgets/ui_trend_drawer_card.dart';

class NestedDrawer extends ConsumerWidget {
  const NestedDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawerState = ref.watch(drawerStateProvider);
    final theme = Theme.of(context);

    final width = MediaQuery.of(context).size.width;
    final menuWidth = width * 0.25;

    return Stack(
      children: [
        // Dark overlay
        if (drawerState.level != DrawerLevel.closed)
          Positioned.fill(
            child: GestureDetector(
              onTap: () => ref.read(drawerStateProvider.notifier).close(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: Colors.black.withValues(alpha: 0.4),
              ),
            ),
          ),

        // Main Menu Level
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: drawerState.level == DrawerLevel.closed ? -menuWidth : 0,
          top: 0,
          bottom: 0,
          width: menuWidth,
          child: SafeArea(
            bottom: false,
            child: Container(
              color: theme.colorScheme.surface,
              padding: const EdgeInsets.only(top: 20),
              child: _MainMenu(
                onSelect: (category) => ref
                    .read(drawerStateProvider.notifier)
                    .openSubDrawer(category),
              ),
            ),
          ),
        ),

        // Sub Menu Level — wider for Proyectos
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: drawerState.level == DrawerLevel.sub
              ? menuWidth
              : -menuWidth * 2,
          top: 0,
          bottom: 0,
          width:
              (drawerState.selectedCategory == 'Proyectos' ||
                  drawerState.selectedCategory == 'UI Trends')
              ? menuWidth * 1.4
              : menuWidth,
          child: SafeArea(
            bottom: false,
            child: Container(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.97,
              ),
              padding: const EdgeInsets.only(top: 20),
              child: _SubMenu(
                category: drawerState.selectedCategory ?? "",
                onBack: () => ref.read(drawerStateProvider.notifier).backToMain(),
                onClose: () => ref.read(drawerStateProvider.notifier).close(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---- Main first-level menu ----
class _MainMenu extends StatelessWidget {
  final Function(String) onSelect;
  const _MainMenu({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final activeOptions = ["Proyectos", "UI Trends"];
    final comingSoonOptions = ["Laboratorio", "Tested Packages"];
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...activeOptions.map(
            (opt) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: InkWell(
                onTap: () => onSelect(opt),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            opt,
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right, size: 20),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'PRÓXIMAMENTE',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
          const SizedBox(height: 16),
          ...comingSoonOptions.map(
            (opt) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      opt,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.5,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
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
}

// ---- Second-level sub-menu dispatcher ----
class _SubMenu extends ConsumerWidget {
  final String category;
  final VoidCallback onBack;
  final VoidCallback onClose;

  const _SubMenu({
    required this.category,
    required this.onBack,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row (back + close)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              const Spacer(),
              // Removed onClose IconButton to avoid overlap with PorscheHeader actions
            ],
          ),
        ),

        // Content
        if (category == 'Proyectos')
          Expanded(child: _ProjectsThumbnailScroll(onClose: onClose))
        else if (category == 'UI Trends')
          Expanded(child: _UITrendsHorizontalScroll(onClose: onClose))
        else
          Expanded(
            child: _GenericSubMenu(category: category, onClose: onClose),
          ),
      ],
    );
  }
}

// ------------------------------------------------------------------ //
//  Proyectos: scrollable device thumbnail list (Porsche style)        //
// ------------------------------------------------------------------ //
class _ProjectsThumbnailScroll extends StatelessWidget {
  final VoidCallback onClose;
  const _ProjectsThumbnailScroll({required this.onClose});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final projects = featuredProjects;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Text(
            'PROYECTOS',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 3.0,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return ProjectDrawerThumbnail(
                project: project,
                onTap: () {
                  context.go('/projects/${project.id}');
                  onClose();
                },
              );
            },
          ),
        ),
        // Footer link
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: GestureDetector(
            onTap: () {
              context.go('/projects');
              onClose();
            },
            child: Row(
              children: [
                Text(
                  'Ver todos los proyectos',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ---- Fallback for Laboratorio / Tested Packages ----
class _GenericSubMenu extends StatelessWidget {
  final String category;
  final VoidCallback onClose;
  const _GenericSubMenu({required this.category, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Map<String, String>> items;
    if (category == 'Laboratorio') {
      items = [
        {'title': 'Ver Galería Lab', 'path': '/lab'},
        {'title': 'Animaciones', 'path': '/lab'},
      ];
    } else if (category == 'Tested Packages') {
      items = [
        {'title': 'Ver Paquetes', 'path': '/packages'},
        {'title': 'State Management', 'path': '/packages'},
        {'title': 'Routing', 'path': '/packages'},
      ];
    } else {
      items = [];
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            category.toUpperCase(),
            style: theme.textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  title: Expanded( // Wrapped title in Expanded
                    child: Text(
                      item['title']!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  onTap: () {
                    context.go(item['path']!);
                    onClose();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  UI Trends: horizontal scrollable preview (like Proyectos but for styles)
// ─────────────────────────────────────────────────────────────────────────────
class _UITrendsHorizontalScroll extends StatelessWidget {
  final VoidCallback onClose;
  const _UITrendsHorizontalScroll({required this.onClose});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Text(
            'UI TRENDS',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 3.0,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.45),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: uiTrendsCatalog.length,
            itemBuilder: (context, index) {
              final trend = uiTrendsCatalog[index];
              return UITrendDrawerCard(
                trend: trend,
                onTap: () {
                  context.go('/ui-trends/${trend.id}');
                  onClose();
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: GestureDetector(
            onTap: () {
              context.go('/lab');
              onClose();
            },
            child: Row(
              children: [
                Text(
                  'Ver laboratorio completo',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
