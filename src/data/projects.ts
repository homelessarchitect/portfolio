import { Project } from '@/types/project';

export const projects: Project[] = [
  {
    id: 'sand-manager',
    title: 'Sand Manager',
    tagline: 'Material supply chain for construction.',
    category: 'CONSTRUCTION LOGISTICS',
    platforms: ['web', 'mobile'],
    services: ['Flutter', 'Firebase', 'Riverpod'],
    year: '2024',
    status: 'live',
    primaryColor: '#f97316',
    logoUrl: '/projects/sand_manager/sand_manager_logo.png',
    coverImage: '/projects/sand_manager/sand_manager_bg.png',
    backgroundVideo: '/projects/sand_manager/sand_manager_bg.mp4',
    conceptImageUrl: '/projects/sand_manager/concept.png',
    historyImageUrl: '/projects/sand_manager/history.png',
    problemSolutionImageUrl: '/projects/sand_manager/problem_solution.png',
    problem:
      'Tracking sand and gravel inventory across multiple construction sites was done on paper, causing supply gaps and delivery delays.',
    solution:
      'A unified platform for inventory management, order tracking, and logistics coordination across all sites.',
    storytelling:
      'Sand Manager digitizes one of the most analog sectors in construction — raw material supply chains — bringing real-time visibility to field operations.',
    styleDescription:
      'Industrial aesthetic with high contrast, optimized for field use under direct sunlight.',
  },
  {
    id: 'eco-tracker',
    title: 'EcoTracker',
    tagline: 'Carbon footprint tracking with gamification.',
    category: 'SUSTAINABILITY',
    platforms: ['mobile'],
    services: ['Flutter', 'Dart', 'Charts'],
    year: '2023',
    status: 'archived',
    primaryColor: '#22c55e',
    problem:
      'Quantifying personal environmental impact in a way that motivates behavioral change.',
    solution:
      'Gamified carbon tracking with visual data and daily challenges.',
    storytelling:
      'EcoTracker bridges environmental awareness and direct action through technology.',
  },
  {
    id: 'crypto-dash',
    title: 'CryptoDash',
    tagline: 'Real-time crypto dashboard with WebSockets.',
    category: 'FINTECH',
    platforms: ['web', 'desktop'],
    services: ['WebSockets', 'Flutter Web', 'Charts'],
    year: '2022',
    status: 'archived',
    primaryColor: '#8b5cf6',
    problem:
      'Information overload and lag in conventional trading platforms.',
    solution:
      'Optimized WebSocket rendering for a low-latency trading experience.',
    storytelling:
      'CryptoDash was an experiment in performance and dark aesthetic UI design.',
  },
];

export function getProject(id: string): Project | undefined {
  return projects.find((p) => p.id === id);
}
