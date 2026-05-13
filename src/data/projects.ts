import { Project } from '@/types/project';

export const projects: Project[] = [
  {
    id: 'sand-manager',
    title: 'Sand Manager',
    tagline: {
      es: 'Cadena de suministro de materiales para construcción.',
      en: 'Material supply chain for construction.',
    },
    category: {
      es: 'LOGÍSTICA DE CONSTRUCCIÓN',
      en: 'CONSTRUCTION LOGISTICS',
    },
    platforms: ['web', 'mobile'],
    services: ['Flutter', 'Firebase', 'Riverpod'],
    year: '2024',
    status: 'live',
    primaryColor: '#f97316',
    logoUrl: '/projects/sand_manager/sand_manager_logo.png',
    coverImage: '/projects/sand_manager/sand_manager_bg.png',
    backgroundVideo: '/projects/sand_manager/sand_manager_bg.mp4',
    thumbnailSimulationId: 'sand-manager',
    problem: {
      es: 'El seguimiento del inventario de arena y áridos en múltiples obras se hacía en papel, generando desabastecimiento y retrasos en las entregas.',
      en: 'Tracking sand and gravel inventory across multiple construction sites was done on paper, causing supply gaps and delivery delays.',
    },
    solution: {
      es: 'Una plataforma unificada para gestión de inventario, seguimiento de pedidos y coordinación logística en todas las obras.',
      en: 'A unified platform for inventory management, order tracking, and logistics coordination across all sites.',
    },
    storytelling: {
      es: 'Sand Manager digitaliza uno de los sectores más analógicos de la construcción — la cadena de suministro de materias primas — llevando visibilidad en tiempo real a las operaciones de campo.',
      en: 'Sand Manager digitizes one of the most analog sectors in construction — raw material supply chains — bringing real-time visibility to field operations.',
    },
    styleDescription: {
      es: 'Estética industrial de alto contraste, optimizada para uso en campo bajo luz solar directa.',
      en: 'Industrial aesthetic with high contrast, optimized for field use under direct sunlight.',
    },
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
        phase: { es: 'Investigación', en: 'Research' },
        title: { es: 'Investigación de campo', en: 'Field Research' },
        description: {
          es: 'Entrevistas con operadores y conductores de obra para mapear el flujo real de pedidos de arena y áridos.',
          en: 'Interviews with site operators and truck drivers to map the real-world flow of sand and gravel orders.',
        },
      },
      {
        id: 'design',
        phase: { es: 'Diseño', en: 'Design' },
        title: { es: 'UI Industrial', en: 'Industrial UI' },
        description: {
          es: 'Alta legibilidad bajo luz solar directa. Tap targets mínimos de 48px y paleta de alto contraste.',
          en: 'High readability under direct sunlight. Minimum 48px tap targets and a high-contrast color palette.',
        },
      },
      {
        id: 'architecture',
        phase: { es: 'Arquitectura', en: 'Architecture' },
        title: { es: 'Clean Architecture', en: 'Clean Architecture' },
        description: {
          es: 'Separación estricta de capas — dominio, datos y presentación — con Riverpod como único motor de estado.',
          en: 'Strict layer separation — domain, data, and presentation — with Riverpod as the sole state engine.',
        },
      },
      {
        id: 'deploy',
        phase: { es: 'Deploy', en: 'Deploy' },
        title: { es: 'Firebase + CI/CD', en: 'Firebase + CI/CD' },
        description: {
          es: 'Pipeline automatizado con entornos de staging y producción independientes. Rollouts sin downtime.',
          en: 'Automated pipeline with independent staging and production environments. Zero-downtime rollouts.',
        },
      },
    ],
  },
  {
    id: 'arcinus',
    title: 'Arcinus',
    tagline: {
      es: 'Plataforma de gestión para organizaciones deportivas.',
      en: 'Club management platform for sports organizations.',
    },
    category: {
      es: 'SAAS DEPORTIVO',
      en: 'SPORTS SAAS',
    },
    platforms: ['mobile', 'web'],
    services: ['Flutter', 'Supabase', 'Riverpod', 'Clean Architecture'],
    year: '2024',
    status: 'inDevelopment',
    primaryColor: '#6366f1',
    thumbnailSimulationId: 'arcinus',
    problem: {
      es: 'Los clubes deportivos gestionan membresías, pagos y horarios con herramientas desconectadas — planillas, grupos de WhatsApp y cajas manuales.',
      en: 'Sports clubs manage memberships, payments, and schedules across disconnected tools — spreadsheets, WhatsApp groups, and manual cash registers.',
    },
    solution: {
      es: 'Un SaaS unificado que cubre gestión de socios, cobro de cuotas, asistencia y coordinación de equipos desde un único codebase Flutter.',
      en: 'A unified SaaS covering member management, fee collection, attendance, and team coordination from a single Flutter codebase.',
    },
    storytelling: {
      es: 'Arcinus lleva el rigor operativo del software empresarial al mundo de los clubes deportivos locales.',
      en: 'Arcinus brings the operational rigor of enterprise software to the world of local sports clubs.',
    },
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
        phase: { es: 'Investigación', en: 'Research' },
        title: { es: 'Investigación de clubes', en: 'Club Research' },
        description: {
          es: 'Entrevistas con directivos de clubes deportivos para mapear flujos de cobro, asistencia y comunicaciones.',
          en: 'Interviews with sports club directors to map fee collection, attendance, and communication flows.',
        },
      },
      {
        id: 'design',
        phase: { es: 'Diseño', en: 'Design' },
        title: { es: 'UX Multi-rol', en: 'Multi-role UX' },
        description: {
          es: 'Tres perfiles en un codebase: admin del club, miembro y staff. Cada rol ve exactamente lo que necesita.',
          en: 'Three roles in one codebase: club admin, member, and staff. Each role sees exactly what they need.',
        },
      },
      {
        id: 'architecture',
        phase: { es: 'Arquitectura', en: 'Architecture' },
        title: { es: 'Supabase + Hexagonal', en: 'Supabase + Hexagonal' },
        description: {
          es: 'Multi-tenant desde el diseño inicial. Arquitectura hexagonal con repositorios intercambiables por entorno.',
          en: 'Multi-tenant from the initial design. Hexagonal architecture with environment-swappable repositories.',
        },
      },
      {
        id: 'deploy',
        phase: { es: 'Deploy', en: 'Deploy' },
        title: { es: 'SaaS Subscription', en: 'SaaS Subscription' },
        description: {
          es: 'Gestión de planes por club, facturación automática y onboarding guiado sin intervención manual.',
          en: 'Per-club plan management, automatic billing, and guided onboarding without manual intervention.',
        },
      },
    ],
  },
  {
    id: 'asos',
    title: 'ASOS',
    tagline: {
      es: 'Sistema de ventas autónomo con IA para PYMEs.',
      en: 'AI-powered sales operating system for SMEs.',
    },
    category: {
      es: 'IA · SAAS',
      en: 'AI · SAAS',
    },
    platforms: ['web'],
    services: ['Claude', 'FastAPI', 'Next.js', 'PostgreSQL'],
    year: '2025',
    status: 'inDevelopment',
    primaryColor: '#0ea5e9',
    thumbnailSimulationId: 'asos',
    problem: {
      es: 'Los equipos de ventas pequeños desperdician horas en seguimientos manuales, actualizaciones de estado e informes de pipeline que la IA puede gestionar automáticamente.',
      en: 'Small sales teams waste hours on manual follow-ups, status updates, and pipeline reporting that AI can handle automatically.',
    },
    solution: {
      es: 'Un CRM autónomo donde Claude actúa como agente MCP — calificando leads, agendando outreach y escribiendo emails de seguimiento sin intervención humana.',
      en: 'An autonomous CRM where Claude acts as an MCP agent — qualifying leads, scheduling outreach, and writing follow-up emails without human intervention.',
    },
    storytelling: {
      es: 'ASOS convierte un equipo de ventas de dos personas en un motor de ingresos always-on.',
      en: 'ASOS turns a two-person sales team into an always-on revenue engine.',
    },
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
    tagline: {
      es: 'Plataforma digital para jardines infantiles y colegios colombianos.',
      en: 'Digital platform for Colombian preschools and schools.',
    },
    category: {
      es: 'EDTECH',
      en: 'EDTECH',
    },
    platforms: ['web', 'mobile'],
    services: ['Astro', 'Tailwind CSS', 'GSAP', 'Cloudflare'],
    year: '2025',
    status: 'inDevelopment',
    primaryColor: '#10b981',
    thumbnailSimulationId: 'jardin-landing',
    problem: {
      es: 'Los jardines infantiles y colegios pequeños en Colombia operan sin presencia digital — sin forma de que los padres los encuentren, los evalúen o hagan inscripciones en línea.',
      en: 'Jardines infantiles and small schools in Colombia operate without a digital presence — no way for parents to find them, evaluate them, or enroll online.',
    },
    solution: {
      es: 'Una landing page orientada a conversión y una plataforma SaaS que ayuda a los colegios a construir credibilidad y optimizar la comunicación con los padres.',
      en: 'A conversion-focused landing page and SaaS platform that helps schools build credibility and streamline parent communication.',
    },
    storytelling: {
      es: 'Jardín conecta a las familias colombianas con las instituciones educativas que moldean los primeros años de sus hijos.',
      en: "Jardín connects Colombian families with the educational institutions shaping their children's first years.",
    },
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
    tagline: {
      es: 'Gestión de pedidos para restaurantes, sin menús en papel.',
      en: 'Order management for restaurants, no paper menus.',
    },
    category: {
      es: 'HOSPITALIDAD',
      en: 'HOSPITALITY',
    },
    platforms: ['web', 'mobile'],
    services: ['Flutter', 'Melos', 'Firebase'],
    year: '2024',
    status: 'live',
    primaryColor: '#ef4444',
    thumbnailSimulationId: 'no-preguntes',
    problem: {
      es: 'El personal del restaurante pierde tiempo respondiendo preguntas repetitivas sobre menús, disponibilidad y precios — ralentizando el servicio en horas pico.',
      en: 'Restaurant staff spend time answering repetitive questions about menus, availability, and prices — slowing service during peak hours.',
    },
    solution: {
      es: 'Un sistema de menú digital basado en QR y gestión de pedidos con un monorepo Flutter (POS móvil + dashboard web).',
      en: 'A QR-based digital menu and order management system with a Flutter monorepo (mobile POS + web dashboard).',
    },
    storytelling: {
      es: 'No Preguntes elimina el menú en papel y las idas y venidas — los clientes piden, la cocina prepara, el personal sirve.',
      en: 'No Preguntes eliminates the paper menu and the back-and-forth — customers order, kitchen prepares, staff serves.',
    },
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
