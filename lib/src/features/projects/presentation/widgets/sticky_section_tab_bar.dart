import 'package:flutter/material.dart';
import 'dart:ui';

class StickySectionTabBar extends StatelessWidget {
  final List<String> tabs;
  final Function(int) onTabSelected;
  final int currentIndex;
  final Color? backgroundColor;

  const StickySectionTabBar({
    super.key,
    required this.tabs,
    required this.onTabSelected,
    this.currentIndex = 0,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.paddingOf(context).top;

    return SliverPersistentHeader(
      pinned: true,
      delegate: _StickyTabBarDelegate(
        tabs: tabs,
        onTabSelected: onTabSelected,
        currentIndex: currentIndex,
        paddingTop: paddingTop,
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final List<String> tabs;
  final Function(int) onTabSelected;
  final int currentIndex;
  final double paddingTop;

  _StickyTabBarDelegate({
    required this.tabs,
    required this.onTabSelected,
    required this.currentIndex,
    required this.paddingTop,
  });

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final progress = (shrinkOffset / maxExtent).clamp(0.0, 1.0);
    final surfaceColor = Theme.of(context).colorScheme.surface;
    const toolbarHeight = kToolbarHeight;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10 * progress, sigmaY: 10 * progress),
        child: Container(
          padding: EdgeInsets.only(top: paddingTop + toolbarHeight),
          color: surfaceColor.withValues(alpha: 0.8 * progress),
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1 * progress),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(tabs.length, (index) {
                final isSelected = index == currentIndex;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextButton(
                    onPressed: () => onTabSelected(index),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          tabs[index].toUpperCase(),
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Colors.white.withValues(
                                    alpha: 0.6 + (0.4 * progress),
                                  ),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 13,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 2,
                          width: isSelected ? 24 : 0,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => paddingTop + kToolbarHeight + 64.0;

  @override
  double get minExtent => paddingTop + kToolbarHeight + 64.0;

  @override
  bool shouldRebuild(covariant _StickyTabBarDelegate oldDelegate) {
    return currentIndex != oldDelegate.currentIndex ||
        tabs != oldDelegate.tabs ||
        paddingTop != oldDelegate.paddingTop;
  }
}
