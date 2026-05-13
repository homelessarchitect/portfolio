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
    thumbnailSimulationId: 'sand-manager',
    problem:
      'Tracking sand and gravel inventory across multiple construction sites was done on paper, causing supply gaps and delivery delays.',
    solution:
      'A unified platform for inventory management, order tracking, and logistics coordination across all sites.',
    storytelling:
      'Sand Manager digitizes one of the most analog sectors in construction — raw material supply chains — bringing real-time visibility to field operations.',
    styleDescription:
      'Industrial aesthetic with high contrast, optimized for field use under direct sunlight.',
    apps: [
      {
        id: 'mobile',
        label: 'App Móvil',
        type: 'mobile',
        status: 'live',
        simulationId: 'sand-manager',
        mockupType: 'phone',
        screens: [
          { id: 'ventas',   label: 'Ventas',   icon: '◧' },
          { id: 'clientes', label: 'Clientes', icon: '◉' },
          { id: 'caja',     label: 'Caja',     icon: '◈' },
          { id: 'menu',     label: 'Menú',     icon: '≡' },
        ],
      },
    ],
    processSteps: [
      {
        id: 'discovery',
        phase: 'Investigación',
        title: 'Field Research',
        description: 'Entrevistas con operadores y conductores de obra para mapear el flujo real de pedidos de arena y áridos.',
      },
      {
        id: 'design',
        phase: 'Diseño',
        title: 'UI Industrial',
        description: 'Alta legibilidad bajo luz solar directa. Tap targets mínimos de 48px y paleta de alto contraste.',
      },
      {
        id: 'architecture',
        phase: 'Arquitectura',
        title: 'Clean Architecture',
        description: 'Separación estricta de capas — dominio, datos y presentación — con Riverpod como único motor de estado.',
      },
      {
        id: 'deploy',
        phase: 'Deploy',
        title: 'Firebase + CI/CD',
        description: 'Pipeline automatizado con entornos de staging y producción independientes. Rollouts sin downtime.',
      },
    ],
  },
  {
    id: 'arcinus',
    title: 'Arcinus',
    tagline: 'Club management platform for sports organizations.',
    category: 'SPORTS SAAS',
    platforms: ['mobile', 'web'],
    services: ['Flutter', 'Supabase', 'Riverpod', 'Clean Architecture'],
    year: '2024',
    status: 'inDevelopment',
    primaryColor: '#6366f1',
    thumbnailSimulationId: 'arcinus',
    problem:
      'Sports clubs manage memberships, payments, and schedules across disconnected tools — spreadsheets, WhatsApp groups, and manual cash registers.',
    solution:
      'A unified SaaS covering member management, fee collection, attendance, and team coordination from a single Flutter codebase.',
    storytelling:
      'Arcinus brings the operational rigor of enterprise software to the world of local sports clubs.',
    apps: [
      {
        id: 'club-manager',
        label: 'Club Manager',
        type: 'mobile',
        status: 'inDevelopment',
        simulationId: 'arcinus',
        mockupType: 'phone',
        screens: [
          { id: 'inicio',    label: 'Inicio',    icon: '⌂' },
          { id: 'miembros',  label: 'Miembros',  icon: '◉' },
          { id: 'caja',      label: 'Caja',      icon: '◈' },
          { id: 'productos', label: 'Productos', icon: '⊞' },
        ],
      },
    ],
    processSteps: [
      {
        id: 'discovery',
        phase: 'Investigación',
        title: 'Club Research',
        description: 'Entrevistas con directivos de clubes deportivos para mapear flujos de cobro, asistencia y comunicaciones.',
      },
      {
        id: 'design',
        phase: 'Diseño',
        title: 'UX Multi-rol',
        description: 'Tres perfiles en un codebase: admin del club, miembro y staff. Cada rol ve exactamente lo que necesita.',
      },
      {
        id: 'architecture',
        phase: 'Arquitectura',
        title: 'Supabase + Hexagonal',
        description: 'Multi-tenant desde el diseño inicial. Arquitectura hexagonal con repositorios intercambiables por entorno.',
      },
      {
        id: 'deploy',
        phase: 'Deploy',
        title: 'SaaS Subscription',
        description: 'Gestión de planes por club, facturación automática y onboarding guiado sin intervención manual.',
      },
    ],
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
    thumbnailSimulationId: 'asos',
    problem:
      'Small sales teams waste hours on manual follow-ups, status updates, and pipeline reporting that AI can handle automatically.',
    solution:
      'An autonomous CRM where Claude acts as an MCP agent — qualifying leads, scheduling outreach, and writing follow-up emails without human intervention.',
    storytelling:
      'ASOS turns a two-person sales team into an always-on revenue engine.',
    apps: [
      {
        id: 'web',
        label: 'Web App',
        type: 'web',
        status: 'inDevelopment',
        simulationId: 'asos',
        mockupType: 'browser',
        urlLabel: 'app.asos.co',
        screens: [
          { id: 'overview',  label: 'Overview',  icon: '⊞' },
          { id: 'leads',     label: 'Leads',     icon: '👥' },
          { id: 'approvals', label: 'Approvals', icon: '✓', badge: '2' },
          { id: 'tasks',     label: 'Tasks',     icon: '☑' },
        ],
      },
    ],
  },
  {
    id: 'jardin',
    title: 'Jardín',
    tagline: 'Digital platform for Colombian preschools and schools.',
    category: 'EDTECH',
    platforms: ['web', 'mobile'],
    services: ['Astro', 'Tailwind CSS', 'GSAP', 'Cloudflare'],
    year: '2025',
    status: 'inDevelopment',
    primaryColor: '#10b981',
    thumbnailSimulationId: 'jardin-landing',
    problem:
      'Jardines infantiles and small schools in Colombia operate without a digital presence — no way for parents to find them, evaluate them, or enroll online.',
    solution:
      'A conversion-focused landing page and SaaS platform that helps schools build credibility and streamline parent communication.',
    storytelling:
      'Jardín connects Colombian families with the educational institutions shaping their children\'s first years.',
    apps: [
      {
        id: 'landing',
        label: 'Landing Page',
        type: 'landing',
        status: 'live',
        liveUrl: 'https://jardin-landing.pages.dev',
        simulationId: 'jardin-landing',
        mockupType: 'browser',
        urlLabel: 'jardin-landing.pages.dev',
        screens: [
          { id: 'hero',     label: 'Hero',             icon: '🏠' },
          { id: 'features', label: 'Módulos',           icon: '⚡' },
          { id: 'schools',  label: 'Tipos de escuela',  icon: '🏫' },
          { id: 'cta',      label: 'CTA Final',         icon: '🎯' },
        ],
      },
      {
        id: 'web',
        label: 'Web App',
        type: 'web',
        status: 'inDevelopment',
        simulationId: 'jardin-app',
        mockupType: 'browser',
        urlLabel: 'app.jardin.edu.co',
        screens: [
          { id: 'asistencia',      label: 'Asistencia',         icon: '📅', group: 'Docente' },
          { id: 'calificaciones',  label: 'Calificaciones',     icon: '📊', group: 'Docente' },
          { id: 'perfil',          label: 'Perfil Estudiante',  icon: '👤', group: 'Admin'   },
          { id: 'comunicaciones',  label: 'Comunicaciones',     icon: '📢', group: 'Admin'   },
          { id: 'cobros',          label: 'Cobros',             icon: '💳', group: 'Admin', badge: 'Solo privados' },
        ],
      },
      {
        id: 'mobile',
        label: 'App Móvil',
        type: 'mobile',
        status: 'inDevelopment',
        simulationId: 'jardin-mobile',
        mockupType: 'phone',
        screens: [
          { id: 'dashboard',  label: 'Dashboard',       icon: '🏠' },
          { id: 'attendance', label: 'Mi hijo hoy',     icon: '📅' },
          { id: 'grades',     label: 'Calificaciones',  icon: '📊' },
          { id: 'messages',   label: 'Mensajes',        icon: '💬' },
        ],
      },
    ],
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
    thumbnailSimulationId: 'no-preguntes',
    problem:
      'Restaurant staff spend time answering repetitive questions about menus, availability, and prices — slowing service during peak hours.',
    solution:
      'A QR-based digital menu and order management system with a Flutter monorepo (mobile POS + web dashboard).',
    storytelling:
      'No Preguntes eliminates the paper menu and the back-and-forth — customers order, kitchen prepares, staff serves.',
    apps: [
      {
        id: 'admin',
        label: 'Panel Admin',
        type: 'mobile',
        status: 'live',
        simulationId: 'no-preguntes',
        mockupType: 'phone',
        screens: [
          { id: 'dashboard', label: 'Overview',  icon: '◈' },
          { id: 'reservas',  label: 'Reservas',  icon: '📅' },
          { id: 'clientes',  label: 'Clientes',  icon: '◉' },
          { id: 'menu',      label: 'Menú',      icon: '☰' },
        ],
      },
    ],
  },
];

export function getProject(id: string): Project | undefined {
  return projects.find((p) => p.id === id);
}
