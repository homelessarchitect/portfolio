export type ProjectPlatform = 'web' | 'mobile' | 'desktop';
export type ProjectStatus = 'live' | 'inDevelopment' | 'archived';

export interface Project {
  id: string;
  title: string;
  tagline: string;
  category: string;
  platforms: ProjectPlatform[];
  services: string[];
  year: string;
  status: ProjectStatus;

  logoUrl?: string;
  coverImage?: string;
  backgroundImage?: string;
  backgroundVideo?: string;

  concept?: string;
  problem?: string;
  solution?: string;
  storytelling?: string;
  styleDescription?: string;

  conceptImageUrl?: string;
  historyImageUrl?: string;
  problemSolutionImageUrl?: string;

  primaryColor?: string;
  demoUrl?: string;
}
