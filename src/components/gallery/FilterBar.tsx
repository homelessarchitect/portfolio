'use client';

import { useState } from 'react';
import { ProjectPlatform, ProjectStatus } from '@/types/project';

export type PlatformFilter = ProjectPlatform | 'all';
export type StatusFilter = ProjectStatus | 'all';

interface FilterBarProps {
  onPlatformChange: (p: PlatformFilter) => void;
  onStatusChange: (s: StatusFilter) => void;
}

const PLATFORMS: { label: string; value: PlatformFilter }[] = [
  { label: 'All', value: 'all' },
  { label: 'Web', value: 'web' },
  { label: 'Mobile', value: 'mobile' },
];

const STATUSES: { label: string; value: StatusFilter }[] = [
  { label: 'All', value: 'all' },
  { label: 'Live', value: 'live' },
  { label: 'In Dev', value: 'inDevelopment' },
  { label: 'Archived', value: 'archived' },
];

export function FilterBar({ onPlatformChange, onStatusChange }: FilterBarProps) {
  const [platform, setPlatform] = useState<PlatformFilter>('all');
  const [status, setStatus] = useState<StatusFilter>('all');

  function handlePlatform(v: PlatformFilter) {
    setPlatform(v);
    onPlatformChange(v);
  }

  function handleStatus(v: StatusFilter) {
    setStatus(v);
    onStatusChange(v);
  }

  return (
    <div className="flex flex-wrap items-center gap-6">
      <div className="flex items-center gap-1 rounded-lg border border-white/[0.06] bg-white/[0.03] p-1">
        {PLATFORMS.map((p) => (
          <button
            key={p.value}
            onClick={() => handlePlatform(p.value)}
            className={`rounded-md px-3 py-1 text-xs font-medium transition-all ${
              platform === p.value
                ? 'bg-white text-black'
                : 'text-zinc-500 hover:text-zinc-300'
            }`}
          >
            {p.label}
          </button>
        ))}
      </div>

      <div className="flex items-center gap-1">
        {STATUSES.map((s) => (
          <button
            key={s.value}
            onClick={() => handleStatus(s.value)}
            className={`rounded-full px-3 py-1 text-xs font-medium transition-all ${
              status === s.value
                ? 'bg-white/[0.1] text-white'
                : 'text-zinc-600 hover:text-zinc-400'
            }`}
          >
            {s.label}
          </button>
        ))}
      </div>
    </div>
  );
}
