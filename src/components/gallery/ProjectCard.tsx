import Link from 'next/link';
import Image from 'next/image';
import { Project } from '@/types/project';
import { PhoneMockup, BrowserMockup } from '@/components/ui/DeviceMockup';

const STATUS_BADGE: Record<
  string,
  { label: string; className: string }
> = {
  live: {
    label: 'Live',
    className: 'bg-emerald-500/10 text-emerald-400 border border-emerald-500/20',
  },
  inDevelopment: {
    label: 'In Dev',
    className: 'bg-amber-500/10 text-amber-400 border border-amber-500/20',
  },
  archived: {
    label: 'Archived',
    className: 'bg-zinc-800 text-zinc-500 border border-zinc-700/50',
  },
};

const PLATFORM_LABEL: Record<string, string> = {
  web: 'Web',
  mobile: 'Mobile',
  desktop: 'Desktop',
};

interface ProjectCardProps {
  project: Project;
}

export function ProjectCard({ project }: ProjectCardProps) {
  const badge = STATUS_BADGE[project.status];
  const hasCover = Boolean(project.coverImage);
  const hasMobile = project.platforms.includes('mobile');
  const hasWeb = project.platforms.includes('web');

  return (
    <Link
      href={`/projects/${project.id}`}
      className="group relative flex flex-col overflow-hidden rounded-2xl border border-white/[0.06] bg-[#111111] transition-all duration-300 hover:border-white/[0.12] hover:shadow-[0_0_0_1px_rgba(255,255,255,0.04),0_20px_40px_rgba(0,0,0,0.4)]"
    >
      <div
        className="relative flex items-end justify-center overflow-hidden px-6 pt-8 pb-4"
        style={{
          minHeight: 260,
          background: project.primaryColor
            ? `radial-gradient(ellipse at 50% 0%, ${project.primaryColor}18 0%, transparent 70%)`
            : 'radial-gradient(ellipse at 50% 0%, rgba(255,255,255,0.03) 0%, transparent 70%)',
        }}
      >
        <span
          className={`absolute left-3 top-3 z-10 rounded-full px-2 py-0.5 text-[10px] font-semibold ${badge.className}`}
        >
          {badge.label}
        </span>

        {hasCover ? (
          hasMobile && !hasWeb ? (
            <PhoneMockup
              src={project.coverImage!}
              alt={project.title}
              primaryColor={project.primaryColor}
            />
          ) : hasMobile && hasWeb ? (
            <div className="flex items-end gap-3">
              <div className="translate-y-2 scale-90 opacity-70">
                <BrowserMockup
                  src={project.coverImage!}
                  alt={`${project.title} web`}
                />
              </div>
              <PhoneMockup
                src={project.coverImage!}
                alt={`${project.title} mobile`}
                primaryColor={project.primaryColor}
              />
            </div>
          ) : (
            <BrowserMockup
              src={project.coverImage!}
              alt={project.title}
            />
          )
        ) : (
          <div
            className="flex h-[180px] w-[160px] items-center justify-center rounded-2xl border border-white/[0.06]"
            style={{
              background: project.primaryColor
                ? `${project.primaryColor}15`
                : '#1a1a1a',
            }}
          >
            <span className="text-3xl font-black tracking-tighter text-white/10">
              {project.title.slice(0, 2).toUpperCase()}
            </span>
          </div>
        )}
      </div>

      <div className="flex flex-col gap-2 border-t border-white/[0.04] px-4 py-4">
        <div className="flex items-center gap-2">
          {project.logoUrl ? (
            <div className="relative h-8 w-8 overflow-hidden rounded-lg border border-white/[0.08] bg-zinc-900">
              <Image
                src={project.logoUrl}
                alt={`${project.title} logo`}
                fill
                className="object-contain p-1"
                sizes="32px"
              />
            </div>
          ) : (
            <div
              className="flex h-8 w-8 items-center justify-center rounded-lg text-[10px] font-black text-white"
              style={{ background: project.primaryColor ?? '#27272a' }}
            >
              {project.title.slice(0, 2).toUpperCase()}
            </div>
          )}

          <div className="flex-1 min-w-0">
            <p className="truncate text-sm font-semibold text-white">
              {project.title}
            </p>
            <p className="truncate text-xs text-zinc-500">{project.tagline}</p>
          </div>
        </div>

        <div className="flex items-center gap-1.5 flex-wrap">
          {project.platforms.map((p) => (
            <span
              key={p}
              className="rounded-md bg-white/[0.04] px-2 py-0.5 text-[10px] font-medium text-zinc-500"
            >
              {PLATFORM_LABEL[p]}
            </span>
          ))}
          <span className="ml-auto text-[10px] text-zinc-700">
            {project.year}
          </span>
        </div>
      </div>
    </Link>
  );
}
