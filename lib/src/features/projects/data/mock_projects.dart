import '../domain/project.dart';

const List<Project> featuredProjects = [
  Project(
    id: 'homeless_architect',
    title: 'Homeless Architect Portfolio',
    description:
        'A Flutter Web ecosystem featuring a granular UI Lab and dynamic Device Preview integration.',
    imageUrl: 'assets/images/placeholder_portfolio.png',
    tags: ['Flutter Web', 'Riverpod', 'Device Preview'],
  ),
  Project(
    id: 'eco_tracker',
    title: 'EcoTracker Mobile',
    description:
        'Carbon footprint tracking app with complex data visualization and gamification.',
    imageUrl: 'assets/images/placeholder_eco.png',
    tags: ['Flutter Mobile', 'Charts', 'Gamification'],
  ),
  Project(
    id: 'crypto_dash',
    title: 'CryptoDash',
    description:
        'Real-time cryptocurrency dashboard with WebSocket integration and grim dark mode UI.',
    imageUrl: 'assets/images/placeholder_crypto.png',
    tags: ['WebSockets', 'Real-time', 'Dark Mode'],
  ),
];
