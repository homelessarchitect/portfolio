import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../state/drawer_state.dart';

class NestedDrawer extends ConsumerWidget {
  const NestedDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawerState = ref.watch(drawerStateProvider);
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: drawerState.level == DrawerLevel.closed
          ? 0
          : MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: theme.colorScheme.surface.withOpacity(0.98),
      child: Stack(
        children: [
          // Main Menu Level
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: drawerState.level == DrawerLevel.main ? 0 : -300,
            top: 100,
            bottom: 0,
            width: 300,
            child: _MainMenu(
              onSelect: (category) => ref
                  .read(drawerStateProvider.notifier)
                  .openSubDrawer(category),
            ),
          ),

          // Sub Menu Level
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: drawerState.level == DrawerLevel.sub ? 300 : 800,
            top: 0,
            bottom: 0,
            right: 0,
            child: _SubMenu(
              category: drawerState.selectedCategory ?? "",
              onBack: () => ref.read(drawerStateProvider.notifier).backToMain(),
              onClose: () => ref.read(drawerStateProvider.notifier).close(),
            ),
          ),

          // Overlay to close when clicking outside (on desktop)
          if (drawerState.level != DrawerLevel.closed)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => ref.read(drawerStateProvider.notifier).close(),
                behavior: HitTestBehavior.translucent,
                child: const SizedBox.shrink(),
              ),
            ),
        ],
      ),
    );
  }
}

class _MainMenu extends StatelessWidget {
  final Function(String) onSelect;

  const _MainMenu({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final options = ["Proyectos", "Laboratorio", "Tested Packages"];
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: options
            .map(
              (opt) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: InkWell(
                  onTap: () => onSelect(opt),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        opt,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const Icon(Icons.chevron_right, size: 20),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

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
    final theme = Theme.of(context);

    // Navigation map
    final List<Map<String, String>> items;
    if (category == 'Proyectos') {
      items = [
        {'title': 'Todos los Proyectos', 'path': '/projects'},
        {'title': 'Arquitectura de Software', 'path': '/projects'},
        {'title': 'Diseño de Sistemas', 'path': '/projects'},
      ];
    } else if (category == 'Laboratorio') {
      items = [
        {'title': 'Ver Galería Lab', 'path': '/lab'},
        {'title': 'Animaciones', 'path': '/lab'},
        {'title': 'Patrones UI', 'path': '/lab'},
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

    return Container(
      color: theme.colorScheme.surfaceVariant.withOpacity(0.5),
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(onPressed: onBack, icon: const Icon(Icons.arrow_back)),
              const Spacer(),
              IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
            ],
          ),
          const SizedBox(height: 40),
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
                  title: Text(
                    item['title']!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w300,
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
