import es from './es.json';
import en from './en.json';

export type Locale = 'es' | 'en';

export type Dictionary = {
  nav: {
    menu: string;
    contact: string;
    about: string;
    projects: string;
  };
  hero: {
    cta: string;
  };
  home: {
    tagline: string;
    taglineAccent: string;
    taglineSub: string;
    projectsLabel: string;
  };
  gallery: {
    viewProject: string;
  };
  footer: {
    copyright: string;
  };
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
