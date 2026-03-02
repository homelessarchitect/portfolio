import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LandingHero extends StatelessWidget {
  const LandingHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Homeless Architect",
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Building digital shelters with code.",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              FilledButton.icon(
                onPressed: () => context.go('/lab'),
                icon: const Icon(Icons.science),
                label: const Text("Enter UI Lab"),
              ),
              OutlinedButton.icon(
                onPressed: () => context.go('/projects'),
                icon: const Icon(Icons.grid_view),
                label: const Text("View Projects"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
