import 'package:flutter/material.dart';
import '../domain/project.dart'; // Verify this import

class ProjectDetailView extends StatelessWidget {
  final Project project;

  const ProjectDetailView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Immersive Hero
            Container(
              height: 600,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(project.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  color: Colors.black.withOpacity(0.5),
                  child: Text(
                    project.title.toUpperCase(),
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 8,
                    ),
                  ),
                ),
              ),
            ),

            // Tech Specs Section (Porsche Style)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _SpecItem(
                    label: "TECNOLOGÍA",
                    value: project.tags.first.toUpperCase(),
                  ),
                  const _VerticalDivider(),
                  _SpecItem(label: "ESTADO", value: "COMPLETE"),
                  const _VerticalDivider(),
                  _SpecItem(label: "CÓDIGO", value: "OPEN SOURCE"),
                ],
              ),
            ),

            // Narrative Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "EL CONCEPTO",
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    project.description,
                    style: theme.textTheme.displaySmall?.copyWith(
                      height: 1.4,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),

            // Large Image Sections
            Container(
              height: 400,
              margin: const EdgeInsets.symmetric(vertical: 40),
              color: theme.colorScheme.surfaceVariant,
              child: const Center(
                child: Text("Gallery / Technical Diagram Placeholder"),
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _SpecItem extends StatelessWidget {
  final String label;
  final String value;

  const _SpecItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            letterSpacing: 1.5,
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 60,
      color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
    );
  }
}
