import es from './es.json';
import en from './en.json';

export type Locale = 'es' | 'en';

export type Dictionary = {
  nav: { menu: string; contact: string; about: string; projects: string };
  hero: { cta: string };
  home: { tagline: string; taglineAccent: string; taglineSub: string; projectsLabel: string };
  gallery: { viewProject: string };
  status: { live: string; inDevelopment: string; archived: string };
  detail: {
    viewSimulation: string;
    liveDemo: string;
    liveDemoFull: string;
    viewLive: string;
    changeProject: string;
    problem: string;
    solution: string;
    techStack: string;
    year: string;
    platforms: string;
    technologies: string;
    apps: string;
    services: string;
    builtToScale: string;
    process: string;
    howWeBuilt: string;
    simulation: string;
    simulationCta: string;
    simulationCtaSuffix: string;
    simulationSub: string;
  };
  platform: { web: string; mobile: string; desktop: string };
  rating: {
    label: string;
    question: string;
    placeholder: string;
    level1: string;
    level2: string;
    level3: string;
    level4: string;
    level5: string;
    received: string;
    thanks: string;
    ctaHigh: string;
    ctaLow: string;
    cta: string;
    ariaGroup: string;
    ariaStar: string;
    ariaStars: string;
  };
  footer: { copyright: string };
  a11y: {
    openMenu: string;
    closeMenu: string;
    contactEmail: string;
    openLocale: string;
    pauseVideo: string;
    playVideo: string;
  };
};

const dictionaries: Record<Locale, Dictionary> = { es, en };

export function getDictionary(locale: Locale): Dictionary {
  return dictionaries[locale];
}
