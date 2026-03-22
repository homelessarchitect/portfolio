import '../domain/project.dart';

import '../catalog/sand_manager/sand_manager_project.dart';

const List<Project> _oldProjects = [
  Project(
    id: 'homeless_architect',
    title: 'Homeless Architect Portfolio',
    tagline: 'Ecosystem',
    platforms: [ProjectPlatform.web],
    services: [],
    year: '2024',
    status: ProjectStatus.live,
    logoUrl: 'https://cdn-icons-png.flaticon.com/512/10044/10044877.png',
    homeViews: {},
    features: [],
    description:
        'A Flutter Web ecosystem featuring a granular UI Lab and dynamic Device Preview integration.',
    imageUrl: 'assets/images/placeholder_portfolio.png',
    tags: ['Flutter Web', 'Riverpod', 'Device Preview'],
  ),
  Project(
    id: 'eco_tracker',
    title: 'EcoTracker Mobile',
    tagline: 'Tracker',
    platforms: [ProjectPlatform.mobile],
    services: [],
    year: '2023',
    status: ProjectStatus.archived,
    logoUrl: 'https://cdn-icons-png.flaticon.com/512/2732/2732657.png',
    homeViews: {},
    features: [],
    description:
        'Carbon footprint tracking app with complex data visualization and gamification.',
    imageUrl: 'assets/images/placeholder_eco.png',
    tags: ['Flutter Mobile', 'Charts', 'Gamification'],
  ),
  Project(
    id: 'crypto_dash',
    title: 'CryptoDash',
    tagline: 'Crypto',
    platforms: [ProjectPlatform.web, ProjectPlatform.desktop],
    services: [],
    year: '2022',
    status: ProjectStatus.archived,
    logoUrl: 'https://cdn-icons-png.flaticon.com/512/6001/6001332.png',
    homeViews: {},
    features: [],
    description:
        'Real-time cryptocurrency dashboard with WebSocket integration and grim dark mode UI.',
    imageUrl: 'assets/images/placeholder_crypto.png',
    tags: ['WebSockets', 'Real-time', 'Dark Mode'],
  ),
];

final List<Project> featuredProjects = [
  sandManagerProject,
  ..._oldProjects,
];
