'use client';

import { useState } from 'react';
import { Project, ProjectApp } from '@/types/project';
import { PhoneSimulationMockup } from '@/components/ui/PhoneSimulationMockup';
import { BrowserSimulationMockup } from '@/components/ui/BrowserSimulationMockup';
import { SimulationWrapper } from '@/components/simulations/SimulationWrapper';

const STATUS_LABEL: Record<string, string> = {
  live: 'Live',
  inDevelopment: 'En desarrollo',
  archived: 'Archivado',
};

const STATUS_DOT: Record<string, string> = {
  live: 'bg-emerald-400',
  inDevelopment: 'bg-amber-400',
  archived: 'bg-zinc-500',
};

interface Props {
  project: Project;
}

function AppMockup({ app, project }: { app: ProjectApp; project: Project }) {
  const firstScreen = app.screens[0]?.id;

  if (app.mockupType === 'browser') {
    return (
      <div style={{ pointerEvents: 'none' }}>
        <BrowserSimulationMockup displayWidth={480} urlLabel={app.urlLabel}>
          <SimulationWrapper simulationId={app.simulationId} screen={firstScreen} />
        </BrowserSimulationMockup>
      </div>
    );
  }

  return (
    <div style={{ pointerEvents: 'none' }}>
      <PhoneSimulationMockup displayWidth={200} primaryColor={project.primaryColor}>
        <SimulationWrapper simulationId={app.simulationId} screen={firstScreen} />
      </PhoneSimulationMockup>
    </div>
  );
}

export function ProductHero({ project }: Props) {
  const apps = project.apps ?? [];
  const [activeAppId, setActiveAppId] = useState(apps[0]?.id ?? '');
  const activeApp = apps.find((a) => a.id === activeAppId) ?? apps[0];
  const hasMultipleApps = apps.length > 1;

  const liveUrl = apps.find((a) => a.liveUrl)?.liveUrl;

  return (
    <section className="relative flex min-h-[calc(100vh-80px)] flex-col overflow-hidden bg-[#0a0a0a]">
      {/* Watermark */}
      <div
        aria-hidden="true"
        className="pointer-events-none absolute inset-0 flex items-center justify-center overflow-hidden select-none"
      >
        <span
          className="whitespace-nowrap font-black uppercase leading-none tracking-tight text-white"
          style={{ fontSize: 'clamp(80px, 14vw, 180px)', opacity: 0.03 }}
        >
          {project.title}
        </span>
      </div>

      <div className="relative mx-auto flex flex-1 max-w-screen-xl flex-col items-center justify-center gap-10 px-6 py-20">
        {/* Mockup */}
        {activeApp && (
          <div className="flex items-end justify-center">
            <AppMockup app={activeApp} project={project} />
          </div>
        )}

        {/* App toggle */}
        {hasMultipleApps && (
          <div className="flex items-center gap-1 rounded-full border border-white/[0.08] bg-white/[0.03] p-1">
            {apps.map((app) => (
              <button
                key={app.id}
                onClick={() => setActiveAppId(app.id)}
                className={`rounded-full px-4 py-1.5 text-xs font-medium transition-all ${
                  activeAppId === app.id
                    ? 'bg-white text-black'
                    : 'text-zinc-400 hover:text-white'
                }`}
              >
                {app.label}
              </button>
            ))}
          </div>
        )}

        {/* Title & meta */}
        <div className="flex flex-col items-center gap-3 text-center">
          <p className="text-[11px] font-semibold uppercase tracking-[0.2em] text-zinc-600">
            {project.category}
          </p>

          <h1 className="text-5xl font-black tracking-tight text-white sm:text-6xl">
            {project.title}
          </h1>

          {/* Status + year + platforms */}
          <div className="flex items-center gap-3 text-xs text-zinc-500">
            <span className="flex items-center gap-1.5">
              <span className={`h-1.5 w-1.5 rounded-full ${STATUS_DOT[project.status]}`} />
              {STATUS_LABEL[project.status]}
            </span>
            <span className="text-zinc-700">·</span>
            <span>{project.year}</span>
            <span className="text-zinc-700">·</span>
            <span>{project.platforms.join(' + ')}</span>
          </div>

          {/* Services */}
          <div className="flex flex-wrap justify-center gap-1.5">
            {project.services.map((s) => (
              <span
                key={s}
                className="rounded-md border border-white/[0.06] bg-white/[0.03] px-2.5 py-1 text-[11px] text-zinc-500"
              >
                {s}
              </span>
            ))}
          </div>

          {/* CTAs */}
          <div className="mt-2 flex gap-3">
            <a
              href="#simulacion"
              className="rounded-full bg-white px-5 py-2.5 text-sm font-semibold text-black transition-opacity hover:opacity-80"
            >
              Ver simulación
            </a>
            {liveUrl && (
              <a
                href={liveUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="rounded-full border border-white/[0.2] px-5 py-2.5 text-sm font-medium text-white transition-colors hover:border-white/40"
              >
                Demo en vivo ↗
              </a>
            )}
          </div>
        </div>
      </div>
    </section>
  );
}
