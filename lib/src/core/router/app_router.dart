import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/ui_lab/presentation/gallery_screen.dart';
import '../../features/ui_lab/presentation/workbench_screen.dart';
import '../../features/ui_lab/data/lab_catalog.dart';
import '../../features/ui_lab/data/ui_trends_catalog.dart';
import '../../features/ui_lab/presentation/ui_trend_detail_screen.dart';
import '../../features/projects/presentation/project_gallery_screen.dart';
import '../../features/ui_lab/presentation/packages_screen.dart';
import '../presentation/widgets/main_navigation_wrapper.dart';
import '../../features/projects/presentation/project_detail_view.dart';
import '../../features/projects/data/mock_projects.dart';

// Remove the placeholder ProjectDetailScreen if it exists below or above

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainNavigationWrapper(child: child);
        },
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
          GoRoute(
            path: '/projects',
            builder: (context, state) => const ProjectGalleryScreen(),
            routes: [
              GoRoute(
                path: ':id',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  final project = featuredProjects.firstWhere(
                    (p) => p.id == id,
                  );
                  return ProjectDetailView(project: project);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/lab',
            builder: (context, state) => const UiLabGalleryScreen(),
          ),
          GoRoute(
            path: '/packages',
            builder: (context, state) => const PackagesScreen(),
          ),
          GoRoute(
            path: '/ui-trends/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final trend = uiTrendsCatalog.firstWhere(
                (t) => t.id == id,
                orElse: () => uiTrendsCatalog.first,
              );
              return UITrendDetailScreen(trend: trend);
            },
          ),
          GoRoute(
            path: '/workbench/:type/:id',
            builder: (context, state) {
              final id = state.pathParameters['id']!;
              final feature = labFeatures
                  .expand((g) => g.features)
                  .firstWhere(
                    (f) => f.id == id,
                    orElse: () => throw Exception('Feature not found'),
                  );

              return WorkbenchScreen(
                title: feature.title,
                child: feature.builder(context),
              );
            },
          ),
        ],
      ),
    ],
  );
});
