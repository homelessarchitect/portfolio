'use client';

import Link from 'next/link';
import { Project } from '@/types/project';
import { SimulationWrapper } from '@/components/simulations/SimulationWrapper';
import { useLocale } from '@/context/LocaleContext';

const BROWSER_SIM_W = 960;
const BROWSER_SIM_H = 560;
const PHONE_SIM_W = 390;
const PHONE_SIM_H = 845;

const STATUS_DOT: Record<string, string> = {
  live: 'bg-emerald-400',
  inDevelopment: 'bg-amber-400',
  archived: 'bg-zinc-600',
};


function SimulationThumbnail({ project }: { project: Project }) {
  const simId = project.thumbnailSimulationId!;
  const thumbnailApp = project.apps?.find((a) => a.simulationId === simId);
  const isPhone = thumbnailApp?.mockupType === 'phone';

  const simW = isPhone ? PHONE_SIM_W : BROWSER_SIM_W;
  const simH = isPhone ? PHONE_SIM_H : BROWSER_SIM_H;
  const thumbW = isPhone ? 130 : 264;
  const scale = thumbW / simW;
  const thumbH = Math.round(simH * scale);

  return (
    <div style={{ width: thumbW, height: thumbH, overflow: 'hidden', borderRadius: 8 }}>
      <div
        style={{
          width: simW,
          height: simH,
          transform: `scale(${scale})`,
          transformOrigin: 'top left',
          pointerEvents: 'none',
        }}
      >
        <SimulationWrapper simulationId={simId} />
      </div>
    </div>
  );
}

function Placeholder({ project }: { project: Project }) {
  return (
    <div
      className="flex h-[200px] w-[150px] items-center justify-center rounded-2xl border border-white/[0.06]"
      style={{ background: project.primaryColor ? `${project.primaryColor}15` : '#1a1a1a' }}
    >
      <span className="text-4xl font-black tracking-tighter text-white/10">
        {project.title.slice(0, 2).toUpperCase()}
      </span>
    </div>
  );
}

export function ProjectCard({ project }: { project: Project }) {
  const { t, locale } = useLocale();
  return (
    <Link
      href={`/projects/${project.id}`}
      className="group relative flex flex-col overflow-hidden rounded-2xl border border-white/[0.06] bg-[#111111] transition-colors duration-300 hover:border-white/[0.12]"
    >
      {/* ── Mockup area ─────────────────────────────── */}
      <div
        className="relative flex items-end justify-center overflow-hidden px-6 pb-6 pt-10"
        style={{
          minHeight: 300,
          background: project.primaryColor
            ? `radial-gradient(ellipse at 50% 0%, ${project.primaryColor}1a 0%, transparent 65%)`
            : 'radial-gradient(ellipse at 50% 0%, rgba(255,255,255,0.04) 0%, transparent 65%)',
        }}
      >
        {/* Mockup — subtle zoom on hover */}
        <div className="transition-transform duration-500 ease-out group-hover:scale-[1.04]">
          {project.thumbnailSimulationId ? (
            <SimulationThumbnail project={project} />
          ) : (
            <Placeholder project={project} />
          )}
        </div>

        {/* Hover overlay with CTA */}
        <div className="absolute inset-0 flex items-center justify-center bg-black/50 opacity-0 backdrop-blur-[2px] transition-opacity duration-300 group-hover:opacity-100">
          <span className="translate-y-1 rounded-full bg-white px-5 py-2 text-sm font-semibold text-black shadow-lg transition-transform duration-300 group-hover:translate-y-0">
            {t.gallery.viewProject}
          </span>
        </div>
      </div>

      {/* ── Info area ───────────────────────────────── */}
      <div className="flex flex-col gap-2 border-t border-white/[0.04] px-5 py-4">
        <p className="text-[9px] font-semibold uppercase tracking-widest text-zinc-600">
          {project.category[locale]}
        </p>

        <div>
          <p className="text-sm font-semibold text-white">{project.title}</p>
          <p className="mt-0.5 line-clamp-2 text-xs leading-relaxed text-zinc-500">
            {project.tagline[locale]}
          </p>
        </div>

        <div className="flex items-center justify-between pt-0.5">
          {/* Platforms */}
          <div className="flex flex-wrap gap-1">
            {project.platforms.map((p) => (
              <span
                key={p}
                className="rounded-md bg-white/[0.04] px-2 py-0.5 text-[9px] font-medium uppercase tracking-wide text-zinc-600"
              >
                {p}
              </span>
            ))}
          </div>

          {/* Status + year */}
          <div className="flex items-center gap-1.5 shrink-0">
            <span className={`h-1.5 w-1.5 rounded-full ${STATUS_DOT[project.status]}`} />
            <span className="text-[10px] text-zinc-600">{project.year}</span>
          </div>
        </div>
      </div>
    </Link>
  );
}
