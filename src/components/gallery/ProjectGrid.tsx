'use client';

import { useState } from 'react';
import { Project } from '@/types/project';
import { ProjectCard } from './ProjectCard';
import { FilterBar, PlatformFilter, StatusFilter } from './FilterBar';

interface ProjectGridProps {
  projects: Project[];
}

export function ProjectGrid({ projects }: ProjectGridProps) {
  const [platform, setPlatform] = useState<PlatformFilter>('all');
  const [status, setStatus] = useState<StatusFilter>('all');

  const filtered = projects.filter((p) => {
    const matchPlatform =
      platform === 'all' || p.platforms.includes(platform as never);
    const matchStatus = status === 'all' || p.status === status;
    return matchPlatform && matchStatus;
  });

  return (
    <div className="flex flex-col gap-8">
      <FilterBar onPlatformChange={setPlatform} onStatusChange={setStatus} />

      {filtered.length === 0 ? (
        <div className="flex h-48 items-center justify-center">
          <p className="text-sm text-zinc-600">No projects match these filters.</p>
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          {filtered.map((project) => (
            <ProjectCard key={project.id} project={project} />
          ))}
        </div>
      )}
    </div>
  );
}
