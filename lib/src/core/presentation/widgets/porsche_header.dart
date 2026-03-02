import 'package:flutter/material.dart';

class PorscheHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  final bool isMenuOpen;

  const PorscheHeader({
    super.key,
    required this.onMenuPressed,
    this.isMenuOpen = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      leadingWidth: 100,
      leading: TextButton.icon(
        onPressed: onMenuPressed,
        icon: Icon(
          isMenuOpen ? Icons.close : Icons.menu,
          color: Colors.white,
          size: 20,
        ),
        label: Text(
          isMenuOpen ? "Cerrar" : "Menú",
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        "HOMELESS ARCHITECT",
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w900,
          letterSpacing: 4.0,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {}, // Language or other actions
          icon: const Icon(Icons.language, size: 20, color: Colors.white),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
