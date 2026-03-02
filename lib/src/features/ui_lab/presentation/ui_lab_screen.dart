import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../domain/lab_feature.dart';
import '../data/lab_catalog.dart';

final selectedFeatureProvider =
    NotifierProvider<SelectedFeatureNotifier, LabFeature?>(
      SelectedFeatureNotifier.new,
    );

class SelectedFeatureNotifier extends Notifier<LabFeature?> {
  @override
  LabFeature? build() => null;

  void select(LabFeature feature) => state = feature;
}

class UiLabScreen extends ConsumerWidget {
  const UiLabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFeature = ref.watch(selectedFeatureProvider);
    final isLargeScreen = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: AppBar(
        title: const Text("UI Lab Dashboard"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
          tooltip: 'Back to Portfolio',
        ),
        actions: [
          if (!isLargeScreen && selectedFeature == null)
            // Hint to open drawer if needed, though drawer icon usually appears automatically
            // But here we are handling body differently
            const SizedBox.shrink(),
        ],
      ),
      drawer: !isLargeScreen
          ? Drawer(
              child: LabSidebar(
                selectedId: selectedFeature?.id,
                onFeatureSelected: (feature) {
                  ref.read(selectedFeatureProvider.notifier).select(feature);
                  Navigator.pop(context); // Close drawer
                },
              ),
            )
          : null,
      body: Row(
        children: [
          if (isLargeScreen)
            SizedBox(
              width: 300,
              child: LabSidebar(
                selectedId: selectedFeature?.id,
                onFeatureSelected: (feature) {
                  ref.read(selectedFeatureProvider.notifier).select(feature);
                },
              ),
            ),
          if (isLargeScreen) const VerticalDivider(width: 1),
          Expanded(
            child: selectedFeature != null
                ? Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.black12,
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedFeature.title,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(
                              selectedFeature.description,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          // Center the demo
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            padding: const EdgeInsets.all(16),
                            child: KeyedSubtree(
                              key: ValueKey(selectedFeature.id),
                              child: selectedFeature.builder(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.touch_app,
                          size: 64,
                          color: Colors.white24,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Select a feature to preview.",
                          style: TextStyle(color: Colors.white54, fontSize: 18),
                        ),
                        if (!isLargeScreen)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Builder(
                              builder: (context) {
                                return ElevatedButton(
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                  child: const Text("Open Menu"),
                                );
                              },
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

class LabSidebar extends StatelessWidget {
  final ValueChanged<LabFeature> onFeatureSelected;
  final String? selectedId;

  const LabSidebar({
    super.key,
    required this.onFeatureSelected,
    this.selectedId,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.black26),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.science, size: 48, color: Colors.blueAccent),
                SizedBox(height: 10),
                Text(
                  "Granular Catalog",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: labFeatures
                .map(
                  (group) => ExpansionTile(
                    initiallyExpanded: true,
                    leading: Icon(group.icon, size: 20),
                    title: Text(
                      group.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: group.features.map((feature) {
                      final isSelected = feature.id == selectedId;
                      return ListTile(
                        selected: isSelected,
                        selectedTileColor: Colors.blueAccent.withValues(
                          alpha: 0.1,
                        ),
                        title: Text(
                          feature.title,
                          style: const TextStyle(fontSize: 13),
                        ),
                        subtitle: Text(
                          feature.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white38,
                          ),
                        ),
                        onTap: () => onFeatureSelected(feature),
                        dense: true,
                      );
                    }).toList(),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
