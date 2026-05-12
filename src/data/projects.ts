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
    id: 'arcinus',
    title: 'Arcinus',
    tagline: 'Club management platform for sports organizations.',
    category: 'SPORTS SAAS',
    platforms: ['mobile', 'web'],
    services: ['Flutter', 'Firebase', 'Clean Architecture'],
    year: '2024',
    status: 'inDevelopment',
    primaryColor: '#6366f1',
    problem:
      'Sports clubs manage memberships, payments, and schedules across disconnected tools — spreadsheets, WhatsApp groups, and manual cash registers.',
    solution:
      'A unified SaaS covering member management, fee collection, attendance, and team coordination from a single Flutter codebase.',
    storytelling:
      'Arcinus brings the operational rigor of enterprise software to the world of local sports clubs.',
  },
  {
    id: 'asos',
    title: 'ASOS',
    tagline: 'AI-powered sales operating system for SMEs.',
    category: 'AI · SAAS',
    platforms: ['web'],
    services: ['Claude', 'FastAPI', 'Next.js', 'PostgreSQL'],
    year: '2025',
    status: 'inDevelopment',
    primaryColor: '#0ea5e9',
    problem:
      'Small sales teams waste hours on manual follow-ups, status updates, and pipeline reporting that AI can handle automatically.',
    solution:
      'An autonomous CRM where Claude acts as an MCP agent — qualifying leads, scheduling outreach, and writing follow-up emails without human intervention.',
    storytelling:
      'ASOS turns a two-person sales team into an always-on revenue engine.',
  },
  {
    id: 'jardin',
    title: 'Jardín',
    tagline: 'Digital platform for Colombian preschools and schools.',
    category: 'EDTECH',
    platforms: ['web'],
    services: ['Astro', 'Tailwind CSS', 'GSAP', 'Cloudflare'],
    year: '2025',
    status: 'inDevelopment',
    primaryColor: '#10b981',
    problem:
      'Jardines infantiles and small schools in Colombia operate without a digital presence — no way for parents to find them, evaluate them, or enroll online.',
    solution:
      'A conversion-focused landing page and SaaS platform that helps schools build credibility and streamline parent communication.',
    storytelling:
      'Jardín connects Colombian families with the educational institutions shaping their children\'s first years.',
  },
  {
    id: 'no-preguntes',
    title: 'No Preguntes',
    tagline: 'Order management for restaurants, no paper menus.',
    category: 'HOSPITALITY',
    platforms: ['web', 'mobile'],
    services: ['Flutter', 'Melos', 'Firebase'],
    year: '2024',
    status: 'live',
    primaryColor: '#ef4444',
    problem:
      'Restaurant staff spend time answering repetitive questions about menus, availability, and prices — slowing service during peak hours.',
    solution:
      'A QR-based digital menu and order management system with a Flutter monorepo (mobile POS + web dashboard).',
    storytelling:
      'No Preguntes eliminates the paper menu and the back-and-forth — customers order, kitchen prepares, staff serves.',
  },
];

export function getProject(id: string): Project | undefined {
  return projects.find((p) => p.id === id);
}
