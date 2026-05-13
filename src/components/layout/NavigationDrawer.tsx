'use client';

import { useState, useEffect } from 'react';
import Link from 'next/link';
import { projects } from '@/data/projects';
import { Project, ProjectApp } from '@/types/project';
import { SimulationWrapper } from '@/components/simulations/SimulationWrapper';
import { PhoneSimulationMockup } from '@/components/ui/PhoneSimulationMockup';
import { BrowserSimulationMockup } from '@/components/ui/BrowserSimulationMockup';

interface Props {
  isOpen: boolean;
  onClose: () => void;
}

const STATUS_DOT: Record<string, string> = {
  live: 'bg-emerald-400',
  inDevelopment: 'bg-amber-400',
  archived: 'bg-zinc-400',
};

const STATUS_LABEL: Record<string, string> = {
  live: 'Live',
  inDevelopment: 'En desarrollo',
  archived: 'Archivado',
};

function ChevronRight({ className = '' }: { className?: string }) {
  return (
    <svg
      width="7"
      height="12"
      viewBox="0 0 7 12"
      fill="none"
      aria-hidden="true"
      className={className}
    >
      <path
        d="M1 1l5 5-5 5"
        stroke="currentColor"
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

function ChevronLeft() {
  return (
    <svg width="16" height="16" viewBox="0 0 16 16" fill="none" aria-hidden="true">
      <path
        d="M10 3L5 8l5 5"
        stroke="currentColor"
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

function ArrowRight() {
  return (
    <svg width="14" height="14" viewBox="0 0 14 14" fill="none" aria-hidden="true">
      <path
        d="M3 7h8M7 3l4 4-4 4"
        stroke="currentColor"
        strokeWidth="1.5"
        strokeLinecap="round"
        strokeLinejoin="round"
      />
    </svg>
  );
}

const PHONE_W = 52;
const PHONE_H = Math.round(PHONE_W * (845 / 390)); // 113px
const BROWSER_W = 76;
const BROWSER_H = Math.round(BROWSER_W * (596 / 960)); // 47px

function ProjectThumb({ project }: { project: Project }) {
  const phoneApp = project.apps?.find((a) => a.mockupType === 'phone');
  const browserApp = project.apps?.find((a) => a.mockupType === 'browser');

  // Phone-only — centered, full device shape
  if (phoneApp && !browserApp) {
    return (
      <div style={{ width: PHONE_W, height: PHONE_H, flexShrink: 0, pointerEvents: 'none' }}>
        <PhoneSimulationMockup displayWidth={PHONE_W} primaryColor={project.primaryColor}>
          <SimulationWrapper simulationId={phoneApp.simulationId} />
        </PhoneSimulationMockup>
      </div>
    );
  }

  // Browser-only
  if (browserApp && !phoneApp) {
    return (
      <div style={{ width: BROWSER_W, height: BROWSER_H, flexShrink: 0, pointerEvents: 'none' }}>
        <BrowserSimulationMockup displayWidth={BROWSER_W} urlLabel={browserApp.urlLabel}>
          <SimulationWrapper simulationId={browserApp.simulationId} />
        </BrowserSimulationMockup>
      </div>
    );
  }

  // Web + Mobile — phone front-left, browser behind-right, 50% horizontal overlap
  if (phoneApp && browserApp) {
    const overlap = Math.round(PHONE_W / 2);
    const containerW = overlap + BROWSER_W;
    const browserTop = Math.round((PHONE_H - BROWSER_H) / 2);
    return (
      <div style={{ position: 'relative', width: containerW, height: PHONE_H, flexShrink: 0, pointerEvents: 'none' }}>
        <div style={{ position: 'absolute', left: overlap, top: browserTop, zIndex: 1 }}>
          <BrowserSimulationMockup displayWidth={BROWSER_W} urlLabel={browserApp.urlLabel}>
            <SimulationWrapper simulationId={browserApp.simulationId} />
          </BrowserSimulationMockup>
        </div>
        <div style={{ position: 'absolute', left: 0, top: 0, zIndex: 2 }}>
          <PhoneSimulationMockup displayWidth={PHONE_W} primaryColor={project.primaryColor}>
            <SimulationWrapper simulationId={phoneApp.simulationId} />
          </PhoneSimulationMockup>
        </div>
      </div>
    );
  }

  // Fallback
  return (
    <div
      className="flex h-14 w-14 flex-shrink-0 items-center justify-center rounded-xl text-[11px] font-black tracking-tight text-white"
      style={{ background: project.primaryColor ?? '#27272a' }}
    >
      {project.title.slice(0, 2).toUpperCase()}
    </div>
  );
}

const APP_PHONE_W = 48;
const APP_PHONE_H = Math.round(APP_PHONE_W * (845 / 390)); // 104px
const APP_BROWSER_W = 88;
const APP_BROWSER_H = Math.round(APP_BROWSER_W * (596 / 960)); // 55px

function AppThumb({ app }: { app: ProjectApp }) {
  if (app.mockupType === 'phone') {
    return (
      <div style={{ width: APP_PHONE_W, height: APP_PHONE_H, flexShrink: 0, pointerEvents: 'none' }}>
        <PhoneSimulationMockup displayWidth={APP_PHONE_W}>
          <SimulationWrapper simulationId={app.simulationId} />
        </PhoneSimulationMockup>
      </div>
    );
  }
  return (
    <div style={{ width: APP_BROWSER_W, height: APP_BROWSER_H, flexShrink: 0, pointerEvents: 'none' }}>
      <BrowserSimulationMockup displayWidth={APP_BROWSER_W} urlLabel={app.urlLabel}>
        <SimulationWrapper simulationId={app.simulationId} />
      </BrowserSimulationMockup>
    </div>
  );
}

function ProjectList({ onSelect }: { onSelect: (id: string) => void }) {
  return (
    <div className="flex h-full flex-col">
      <div className="px-6 pb-4 pt-10">
        <p className="text-[10px] font-semibold uppercase tracking-widest text-zinc-400">
          Proyectos
        </p>
      </div>

      <div className="flex-1 overflow-y-auto px-4 pb-6">
        {projects.map((project) => (
          <button
            key={project.id}
            onClick={() => onSelect(project.id)}
            className="group flex w-full items-center gap-4 rounded-2xl px-4 py-3 text-left transition-colors hover:bg-white"
          >
            <ProjectThumb project={project} />

            <div className="min-w-0 flex-1">
              <p className="truncate text-sm font-semibold text-zinc-900">{project.title}</p>
              <p className="mt-0.5 truncate text-xs text-zinc-500">{project.category}</p>
              <div className="mt-1.5 flex flex-wrap gap-1">
                {project.platforms.map((p) => (
                  <span
                    key={p}
                    className="rounded-md bg-zinc-200 px-1.5 py-0.5 text-[9px] font-medium uppercase tracking-wide text-zinc-500"
                  >
                    {p}
                  </span>
                ))}
              </div>
            </div>

            <ChevronRight className="flex-shrink-0 text-zinc-300 transition-colors group-hover:text-zinc-500" />
          </button>
        ))}
      </div>
    </div>
  );
}

function ProjectDetail({
  project,
  onBack,
  onClose,
}: {
  project: Project;
  onBack: () => void;
  onClose: () => void;
}) {
  return (
    <div className="flex h-full flex-col">
      <div className="px-6 pt-6">
        <button
          onClick={onBack}
          className="mb-5 flex items-center gap-2 text-xs font-medium text-zinc-500 transition-colors hover:text-zinc-900"
        >
          <ChevronLeft />
          Proyectos
        </button>

        <p className="mb-1 text-2xl font-black italic tracking-tight text-zinc-900">
          {project.title}
        </p>

        <Link
          href={`/projects/${project.id}`}
          onClick={onClose}
          className="flex items-center gap-1.5 text-sm text-zinc-500 transition-colors hover:text-zinc-900"
        >
          Resumen del proyecto
          <ArrowRight />
        </Link>
      </div>

      <div className="flex-1 overflow-y-auto px-4 py-4">
        {project.apps?.length ? (
          <div className="space-y-3">
            {project.apps.map((app) => (
              <div
                key={app.id}
                className="rounded-2xl border border-zinc-200 bg-white p-4"
              >
                <div className="mb-3 flex items-start justify-between gap-3">
                  <div className="min-w-0 flex-1">
                    <p className="truncate text-sm font-semibold text-zinc-900">{app.label}</p>
                    <div className="mt-1 flex items-center gap-1.5">
                      <span className={`h-1.5 w-1.5 rounded-full ${STATUS_DOT[app.status]}`} />
                      <span className="text-xs text-zinc-500">{STATUS_LABEL[app.status]}</span>
                    </div>
                  </div>
                  <AppThumb app={app} />
                </div>

                <div className="flex flex-wrap gap-1">
                  {app.screens.slice(0, 4).map((screen) => (
                    <span
                      key={screen.id}
                      className="rounded-md bg-zinc-100 px-2 py-0.5 text-[10px] text-zinc-500"
                    >
                      {screen.icon} {screen.label}
                    </span>
                  ))}
                  {app.screens.length > 4 && (
                    <span className="text-[10px] text-zinc-400">
                      +{app.screens.length - 4} más
                    </span>
                  )}
                </div>
              </div>
            ))}
          </div>
        ) : (
          <div className="flex h-full items-center justify-center">
            <p className="text-sm text-zinc-400">Sin apps registradas.</p>
          </div>
        )}
      </div>

      <div className="space-y-2 px-4 pb-6">
        <Link
          href={`/projects/${project.id}`}
          onClick={onClose}
          className="block w-full rounded-xl bg-zinc-900 py-3 text-center text-sm font-semibold text-white transition-colors hover:bg-zinc-800"
        >
          Ver proyecto
        </Link>
        {project.apps?.find((a) => a.liveUrl) && (
          <a
            href={project.apps.find((a) => a.liveUrl)!.liveUrl!}
            target="_blank"
            rel="noopener noreferrer"
            onClick={onClose}
            className="block w-full rounded-xl bg-zinc-100 py-3 text-center text-sm font-semibold text-zinc-900 transition-colors hover:bg-zinc-200"
          >
            Ver demo en vivo ↗
          </a>
        )}
      </div>
    </div>
  );
}

type MobileStep = 'nav' | 'list' | 'detail';

export function NavigationDrawer({ isOpen, onClose }: Props) {
  const [activeProjectId, setActiveProjectId] = useState<string | null>(null);
  const [mobileStep, setMobileStep] = useState<MobileStep>('nav');

  const activeProject = activeProjectId
    ? (projects.find((p) => p.id === activeProjectId) ?? null)
    : null;

  useEffect(() => {
    if (!isOpen) return;
    const handler = (e: KeyboardEvent) => {
      if (e.key === 'Escape') onClose();
    };
    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [isOpen, onClose]);

  useEffect(() => {
    if (isOpen) {
      document.body.style.overflow = 'hidden';
    } else {
      document.body.style.overflow = '';
    }
    return () => {
      document.body.style.overflow = '';
    };
  }, [isOpen]);

  useEffect(() => {
    if (isOpen) return;
    const timer = setTimeout(() => {
      setActiveProjectId(null);
      setMobileStep('nav');
    }, 300);
    return () => clearTimeout(timer);
  }, [isOpen]);

  const handleMobileProjectSelect = (id: string) => {
    setActiveProjectId(id);
    setMobileStep('detail');
  };

  return (
    <>
      {/* Backdrop */}
      <div
        aria-hidden="true"
        onClick={onClose}
        className={`fixed inset-0 z-[60] bg-black/50 backdrop-blur-sm transition-opacity duration-300 ${
          isOpen ? 'opacity-100' : 'pointer-events-none opacity-0'
        }`}
      />

      {/* ✕ Close button */}
      <button
        aria-label="Cerrar menú"
        onClick={onClose}
        className={`fixed right-5 top-5 z-[80] flex h-10 w-10 items-center justify-center rounded-full bg-black/20 text-white backdrop-blur-md transition-all duration-300 hover:bg-black/40 ${
          isOpen ? 'opacity-100' : 'pointer-events-none opacity-0'
        }`}
      >
        <svg width="14" height="14" viewBox="0 0 14 14" fill="none" aria-hidden="true">
          <path
            d="M1 1l12 12M13 1L1 13"
            stroke="currentColor"
            strokeWidth="1.5"
            strokeLinecap="round"
          />
        </svg>
      </button>

      {/* Drawer wrapper */}
      <div
        role="dialog"
        aria-modal="true"
        aria-label="Menú de navegación"
        className={`fixed inset-y-0 left-0 z-[70] transition-transform duration-300 ease-in-out ${
          isOpen ? 'translate-x-0' : '-translate-x-full'
        }`}
      >
        {/* ── DESKTOP (md+): two panels side by side ── */}
        <div className="hidden h-full md:flex">
          {/* Panel 1 — Main nav */}
          <div className="flex h-full w-72 flex-col bg-white shadow-2xl">
            <nav className="mt-20 flex flex-col px-3">
              <div className="flex items-center justify-between rounded-xl bg-zinc-100 px-4 py-4">
                <span className="text-base font-medium text-zinc-900">Proyectos</span>
                <ChevronRight className="text-zinc-400" />
              </div>

              <Link
                href="/about"
                onClick={onClose}
                className="flex items-center justify-between rounded-xl px-4 py-4 text-base font-medium text-zinc-900 transition-colors hover:bg-zinc-50"
              >
                Sobre mí
              </Link>

              <a
                href="mailto:dariensherrera.dev@gmail.com"
                onClick={onClose}
                className="flex items-center justify-between rounded-xl px-4 py-4 text-base font-medium text-zinc-900 transition-colors hover:bg-zinc-50"
              >
                Contacto
              </a>
            </nav>
          </div>

          {/* Panel 2 — Project list / Project detail (cross-fade) */}
          <div className="relative h-full w-96 overflow-hidden bg-[#f5f5f5]">
            <div
              className={`absolute inset-0 transition-all duration-200 ease-in-out ${
                activeProjectId
                  ? 'pointer-events-none -translate-x-3 opacity-0'
                  : 'translate-x-0 opacity-100'
              }`}
            >
              <ProjectList onSelect={setActiveProjectId} />
            </div>

            <div
              className={`absolute inset-0 transition-all duration-200 ease-in-out ${
                activeProjectId
                  ? 'translate-x-0 opacity-100'
                  : 'pointer-events-none translate-x-3 opacity-0'
              }`}
            >
              {activeProject && (
                <ProjectDetail
                  project={activeProject}
                  onBack={() => setActiveProjectId(null)}
                  onClose={onClose}
                />
              )}
            </div>
          </div>
        </div>

        {/* ── MOBILE (<md): single full-screen, 3 sliding steps ── */}
        <div className="relative h-[100dvh] w-screen overflow-hidden md:hidden">
          {/* Step 1 — Nav */}
          <div
            className={`absolute inset-0 flex flex-col bg-white transition-transform duration-300 ease-in-out ${
              mobileStep === 'nav' ? 'translate-x-0' : '-translate-x-full'
            }`}
          >
            <nav className="mt-20 flex flex-col px-3">
              <button
                onClick={() => setMobileStep('list')}
                className="flex items-center justify-between rounded-xl bg-zinc-100 px-4 py-4 text-base font-medium text-zinc-900"
              >
                Proyectos
                <ChevronRight className="text-zinc-400" />
              </button>

              <Link
                href="/about"
                onClick={onClose}
                className="flex items-center justify-between rounded-xl px-4 py-4 text-base font-medium text-zinc-900 transition-colors hover:bg-zinc-50"
              >
                Sobre mí
              </Link>

              <a
                href="mailto:dariensherrera.dev@gmail.com"
                onClick={onClose}
                className="flex items-center justify-between rounded-xl px-4 py-4 text-base font-medium text-zinc-900 transition-colors hover:bg-zinc-50"
              >
                Contacto
              </a>
            </nav>
          </div>

          {/* Step 2 — Project list */}
          <div
            className={`absolute inset-0 flex flex-col bg-[#f5f5f5] transition-transform duration-300 ease-in-out ${
              mobileStep === 'list'
                ? 'translate-x-0'
                : mobileStep === 'nav'
                  ? 'translate-x-full'
                  : '-translate-x-full'
            }`}
          >
            <div className="flex-shrink-0 px-5 pb-2 pt-6">
              <button
                onClick={() => setMobileStep('nav')}
                className="flex items-center gap-2 text-xs font-medium text-zinc-500 transition-colors hover:text-zinc-900"
              >
                <ChevronLeft />
                Menú
              </button>
            </div>
            <div className="min-h-0 flex-1">
              <ProjectList onSelect={handleMobileProjectSelect} />
            </div>
          </div>

          {/* Step 3 — Project detail */}
          <div
            className={`absolute inset-0 bg-white transition-transform duration-300 ease-in-out ${
              mobileStep === 'detail' ? 'translate-x-0' : 'translate-x-full'
            }`}
          >
            {activeProject && (
              <ProjectDetail
                project={activeProject}
                onBack={() => setMobileStep('list')}
                onClose={onClose}
              />
            )}
          </div>
        </div>
      </div>
    </>
  );
}
