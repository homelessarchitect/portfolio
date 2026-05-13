'use client';

import { useState } from 'react';
import type { Project } from '@/types/project';
import { BrowserSimulationMockup } from '@/components/ui/BrowserSimulationMockup';
import { PhoneSimulationMockup } from '@/components/ui/PhoneSimulationMockup';
import { SimulationWrapper } from '@/components/simulations/SimulationWrapper';
import { useLocale } from '@/context/LocaleContext';

interface Props {
  project: Project;
}

export function AppScreenExplorer({ project }: Props) {
  const { t } = useLocale();
  const apps = project.apps ?? [];

  const [activeAppId, setActiveAppId] = useState(() => apps[0]?.id ?? '');
  const activeApp = apps.find((a) => a.id === activeAppId) ?? apps[0];
  const [activeScreenId, setActiveScreenId] = useState(
    () => activeApp?.screens[0]?.id ?? '',
  );

  if (!activeApp) return null;

  function handleSelectApp(appId: string) {
    const app = apps.find((a) => a.id === appId);
    setActiveAppId(appId);
    setActiveScreenId(app?.screens[0]?.id ?? '');
  }

  const groupMap = activeApp.screens.reduce<Record<string, typeof activeApp.screens>>(
    (acc, screen) => {
      const key = screen.group ?? '__default__';
      if (!acc[key]) acc[key] = [];
      acc[key].push(screen);
      return acc;
    },
    {},
  );
  const groups = Object.entries(groupMap);
  const hasGroups = groups.some(([k]) => k !== '__default__');

  return (
    <div className="space-y-6">
      {/* App tabs */}
      <div className="flex flex-wrap gap-2">
        {apps.map((app) => (
          <button
            key={app.id}
            onClick={() => handleSelectApp(app.id)}
            className={`flex items-center gap-2 rounded-full px-3 py-1.5 text-xs font-semibold transition-all ${
              activeAppId === app.id
                ? 'bg-white text-black'
                : 'border border-white/[0.08] text-zinc-400 hover:border-white/[0.16] hover:text-white'
            }`}
          >
            {app.label}
            <span
              className={`rounded-full px-1.5 py-0.5 text-[9px] font-bold ${
                app.status === 'live'
                  ? 'bg-emerald-500/20 text-emerald-400'
                  : 'bg-amber-500/20 text-amber-400'
              }`}
            >
              {app.status === 'live' ? 'LIVE' : 'DEV'}
            </span>
          </button>
        ))}
      </div>

      {/* Layout: screen sidebar + simulation */}
      <div className="flex flex-col gap-6 md:flex-row md:items-start">
        {/* Screen nav */}
        <nav className="flex shrink-0 flex-row gap-1 overflow-x-auto md:w-36 md:flex-col">
          {groups.map(([group, screens]) => (
            <div key={group} className="contents md:block">
              {hasGroups && group !== '__default__' && (
                <p className="hidden px-2 pb-1 pt-2 text-[9px] font-semibold uppercase tracking-widest text-zinc-600 md:block">
                  {group}
                </p>
              )}
              {screens.map((screen) => (
                <button
                  key={screen.id}
                  onClick={() => setActiveScreenId(screen.id)}
                  className={`flex shrink-0 items-center gap-2 rounded-lg px-2.5 py-2 text-left text-xs transition-all md:w-full ${
                    activeScreenId === screen.id
                      ? 'bg-white/[0.08] text-white'
                      : 'text-zinc-500 hover:text-zinc-300'
                  }`}
                >
                  {screen.icon && <span className="text-sm leading-none">{screen.icon}</span>}
                  <span className="flex-1 truncate">{screen.label}</span>
                  {screen.badge && (
                    <span className="hidden rounded bg-zinc-800 px-1 text-[8px] text-zinc-500 md:inline">
                      {screen.badge}
                    </span>
                  )}
                </button>
              ))}
            </div>
          ))}
        </nav>

        {/* Simulation */}
        <div className="flex flex-1 flex-col items-center gap-4">
          {activeApp.mockupType === 'browser' ? (
            <BrowserSimulationMockup displayWidth={560} urlLabel={activeApp.urlLabel}>
              <SimulationWrapper
                simulationId={activeApp.simulationId}
                screen={activeScreenId}
              />
            </BrowserSimulationMockup>
          ) : (
            <PhoneSimulationMockup primaryColor={project.primaryColor} displayWidth={280}>
              <SimulationWrapper
                simulationId={activeApp.simulationId}
                screen={activeScreenId}
              />
            </PhoneSimulationMockup>
          )}

          <div className="flex items-center gap-3">
            {activeApp.liveUrl && (
              <a
                href={activeApp.liveUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-1.5 rounded-full border border-white/[0.08] px-3 py-1.5 text-xs text-zinc-400 transition-colors hover:border-white/[0.2] hover:text-white"
              >
                {activeApp.urlLabel ?? t.detail.viewLive}
                <span className="text-[10px]">↗</span>
              </a>
            )}
            <p className="text-center text-[11px] text-zinc-600">
              {t.detail.simulation}
            </p>
          </div>
        </div>
      </div>
    </div>
  );
}
