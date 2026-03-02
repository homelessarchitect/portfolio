import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../state/drawer_state.dart';
import 'nested_drawer.dart';
import 'porsche_header.dart';

class MainNavigationWrapper extends ConsumerWidget {
  final Widget child;

  const MainNavigationWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawerState = ref.watch(drawerStateProvider);
    final notifier = ref.read(drawerStateProvider.notifier);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PorscheHeader(
        onMenuPressed: () => notifier.toggleDrawer(),
        isMenuOpen: drawerState.level != DrawerLevel.closed,
      ),
      body: Stack(
        children: [
          // Content
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: drawerState.level == DrawerLevel.closed ? 1.0 : 0.4,
            child: child,
          ),

          // Porsche Drawer
          const NestedDrawer(),
        ],
      ),
    );
  }
}
