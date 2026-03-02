import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../projects/data/mock_projects.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final starProject = featuredProjects.first;

    return Scaffold(
      backgroundColor: Colors.black, // Dark background for the hero
      body: Stack(
        children: [
          // Full Screen Content
          SingleChildScrollView(
            child: Column(
              children: [
                // Star Project Preview (Hero Section)
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(starProject.imageUrl),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          starProject.title,
                          style: theme.textTheme.displayLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          starProject.description,
                          maxLines: 2,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            color: Colors.white.withOpacity(0.8),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 32),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 20,
                            ),
                          ),
                          child: const Text(
                            "Descubra más",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Secondary Content (Coming soon)
                Container(
                  height: 400,
                  color: theme.colorScheme.surface,
                  child: Center(
                    child: Text(
                      "Explorar más proyectos...",
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Static overlay elements (like a scroll indicator)
          Positioned(
            bottom: 40,
            right: 40,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.5)),
              ),
              child: const Icon(Icons.pause, color: Colors.white, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
