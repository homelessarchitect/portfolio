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
    concept:
        'Un portafolio vivo que actúa como un laboratorio de diseño y desarrollo, demostrando capacidades técnicas a través de simulaciones interactivas.',
    problem:
        'Los portafolios estáticos no logran transmitir la complejidad y el feeling de las aplicaciones reales.',
    solution:
        'Una plataforma que combina narrativa visual con exploradores de diseño y simuladores funcionales.',
    storytelling:
        'Este proyecto nace de la necesidad de mostrar no solo el resultado final, sino el proceso y la arquitectura detrás de cada decisión de diseño.',
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
    concept:
        'Una herramienta educativa y operativa para medir y reducir la huella de carbono individual a través de retos y visualización de datos.',
    problem:
        'La dificultad de cuantificar el impacto ambiental de las acciones cotidianas de manera sencilla.',
    solution:
        'Algoritmos de cálculo precisos integrados con una experiencia de usuario gamificada y visualmente atractiva.',
    storytelling:
        'EcoTracker fue desarrollado como un puente entre la conciencia ambiental y la acción directa, utilizando tecnología para motivar el cambio.',
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
    concept:
        'Monitorización de mercados cripto en tiempo real con un enfoque en el análisis técnico y la estética de alto contraste.',
    problem:
        'La sobrecarga de información y el lag en las plataformas de trading convencionales.',
    solution:
        'Optimización de WebSockets y renderizado eficiente para una experiencia de usuario sin fricciones.',
    storytelling:
        'CryptoDash fue un experimento de rendimiento y diseño "grim dark", buscando la máxima eficiencia en entornos de alta volatilidad.',
  ),
];

final List<Project> featuredProjects = [sandManagerProject, ..._oldProjects];
