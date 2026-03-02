import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../ui_lab/data/lab_catalog.dart';

class FeaturedLabWidget extends StatelessWidget {
  const FeaturedLabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Pick a cool feature to show, e.g., 'kanban_board' or 'interactive_cards'
    final feature = labFeatures
        .expand((g) => g.features)
        .firstWhere(
          (f) => f.id == 'interactive_cards',
          orElse: () => labFeatures.first.features.first,
        );

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 40),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.science,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "UI Lab Highlight",
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  feature.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  feature.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSecondaryContainer.withValues(alpha: 0.8),
                  ),
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => context.go('/workbench/lab/${feature.id}'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.onSecondaryContainer,
                    foregroundColor: Theme.of(
                      context,
                    ).colorScheme.secondaryContainer,
                  ),
                  child: const Text("Open in Workbench"),
                ),
              ],
            ),
          ),
          if (MediaQuery.of(context).size.width > 800) ...[
            const SizedBox(width: 40),
            Expanded(
              flex: 3,
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                // We could render the actual widget here, but scaled down or just a placeholder image
                // For now, let's render the widget itself!
                clipBehavior: Clip.antiAlias,
                child: feature.builder(context),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
