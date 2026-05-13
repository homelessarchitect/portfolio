export type LocalizedString = { es: string; en: string };
export type ProjectPlatform = 'web' | 'mobile' | 'desktop';
export type ProjectStatus = 'live' | 'inDevelopment' | 'archived';

export interface ProjectScreen {
  id: string;
  label: string;
  icon?: string;
  group?: string;
  badge?: string;
}

export interface ProjectApp {
  id: string;
  label: string;
  type: 'landing' | 'web' | 'mobile' | 'desktop';
  status: ProjectStatus;
  liveUrl?: string;
  simulationId: string;
  mockupType: 'browser' | 'phone';
  urlLabel?: string;
  screens: ProjectScreen[];
}

export interface ProcessStep {
  id: string;
  phase: LocalizedString;
  title: LocalizedString;
  description: LocalizedString;
}

export interface Project {
  id: string;
  title: string;
  tagline: LocalizedString;
  category: LocalizedString;
  platforms: ProjectPlatform[];
  services: string[];
  year: string;
  status: ProjectStatus;

  logoUrl?: string;
  coverImage?: string;
  backgroundImage?: string;
  backgroundVideo?: string;

  concept?: LocalizedString;
  problem?: LocalizedString;
  solution?: LocalizedString;
  storytelling?: LocalizedString;
  styleDescription?: LocalizedString;

  conceptImageUrl?: string;
  historyImageUrl?: string;
  problemSolutionImageUrl?: string;

  primaryColor?: string;
  demoUrl?: string;

  thumbnailSimulationId?: string;

  apps?: ProjectApp[];
  processSteps?: ProcessStep[];
}
