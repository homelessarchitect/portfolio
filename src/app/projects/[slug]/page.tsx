import { notFound } from 'next/navigation';
import Image from 'next/image';
import Link from 'next/link';
import type { Metadata } from 'next';
import { Header } from '@/components/layout/Header';
import { projects, getProject } from '@/data/projects';

interface Props {
  params: Promise<{ slug: string }>;
}

export async function generateStaticParams() {
  return projects.map((p) => ({ slug: p.id }));
}

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params;
  const project = getProject(slug);
  if (!project) return {};
  return {
    title: `${project.title} — Homeless Architect`,
    description: project.tagline,
  };
}

const STATUS_LABEL: Record<string, string> = {
  live: 'Live',
  inDevelopment: 'In Development',
  archived: 'Archived',
};

const STATUS_COLOR: Record<string, string> = {
  live: 'text-emerald-400',
  inDevelopment: 'text-amber-400',
  archived: 'text-zinc-500',
};

export default async function ProjectDetailPage({ params }: Props) {
  const { slug } = await params;
  const project = getProject(slug);

  if (!project) notFound();

  return (
    <div className="flex min-h-screen flex-col">
      <Header />

      <main className="flex-1">
        <section className="relative overflow-hidden">
          {project.backgroundVideo ? (
            <video
              autoPlay
              muted
              loop
              playsInline
              className="absolute inset-0 h-full w-full object-cover opacity-20"
            >
              <source src={project.backgroundVideo} type="video/mp4" />
            </video>
          ) : null}
          <div className="absolute inset-0 bg-gradient-to-b from-transparent via-[#0a0a0a]/60 to-[#0a0a0a]" />

          <div className="relative mx-auto max-w-screen-xl px-6 py-20">
            <Link
              href="/"
              className="mb-8 inline-flex items-center gap-1.5 text-xs text-zinc-600 transition-colors hover:text-zinc-400"
            >
              <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
                <path
                  d="M7.5 2L3.5 6l4 4"
                  stroke="currentColor"
                  strokeWidth="1.5"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
              </svg>
              All Projects
            </Link>

            <div className="flex flex-col gap-4">
              <div className="flex items-center gap-3">
                {project.logoUrl && (
                  <div className="relative h-12 w-12 overflow-hidden rounded-xl border border-white/[0.08] bg-zinc-900">
                    <Image
                      src={project.logoUrl}
                      alt={`${project.title} logo`}
                      fill
                      className="object-contain p-2"
                      sizes="48px"
                    />
                  </div>
                )}
                <div>
                  <p className="text-xs font-medium uppercase tracking-widest text-zinc-600">
                    {project.category}
                  </p>
                  <h1 className="text-4xl font-black tracking-tight text-white">
                    {project.title}
                  </h1>
                </div>
              </div>

              <p className="max-w-xl text-lg text-zinc-400">{project.tagline}</p>

              <div className="flex flex-wrap items-center gap-4 text-xs">
                <span className={`font-semibold ${STATUS_COLOR[project.status]}`}>
                  ● {STATUS_LABEL[project.status]}
                </span>
                <span className="text-zinc-700">·</span>
                <span className="text-zinc-500">{project.year}</span>
                <span className="text-zinc-700">·</span>
                <span className="text-zinc-500">
                  {project.platforms.join(' + ')}
                </span>
              </div>

              <div className="flex flex-wrap gap-1.5 pt-1">
                {project.services.map((s) => (
                  <span
                    key={s}
                    className="rounded-md border border-white/[0.06] bg-white/[0.03] px-2 py-1 text-[11px] text-zinc-500"
                  >
                    {s}
                  </span>
                ))}
              </div>
            </div>
          </div>
        </section>

        <div className="mx-auto max-w-screen-xl px-6 pb-20">
          {project.problem && project.solution && (
            <div className="mb-16 grid gap-6 md:grid-cols-2">
              <div className="rounded-2xl border border-white/[0.06] bg-[#111] p-6">
                <p className="mb-3 text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
                  Problem
                </p>
                <p className="text-sm leading-relaxed text-zinc-300">
                  {project.problem}
                </p>
              </div>
              <div className="rounded-2xl border border-white/[0.06] bg-[#111] p-6">
                <p className="mb-3 text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
                  Solution
                </p>
                <p className="text-sm leading-relaxed text-zinc-300">
                  {project.solution}
                </p>
              </div>
            </div>
          )}

          {project.conceptImageUrl && (
            <div className="mb-8 overflow-hidden rounded-2xl border border-white/[0.06]">
              <Image
                src={project.conceptImageUrl}
                alt={`${project.title} concept`}
                width={1200}
                height={600}
                className="w-full object-cover"
              />
            </div>
          )}

          {project.problemSolutionImageUrl && (
            <div className="mb-8 overflow-hidden rounded-2xl border border-white/[0.06]">
              <Image
                src={project.problemSolutionImageUrl}
                alt={`${project.title} problem & solution`}
                width={1200}
                height={600}
                className="w-full object-cover"
              />
            </div>
          )}

          {project.historyImageUrl && (
            <div className="mb-8 overflow-hidden rounded-2xl border border-white/[0.06]">
              <Image
                src={project.historyImageUrl}
                alt={`${project.title} history`}
                width={1200}
                height={600}
                className="w-full object-cover"
              />
            </div>
          )}

          {project.storytelling && (
            <div className="mb-16 border-l-2 border-white/[0.08] pl-6">
              <p className="text-base leading-relaxed text-zinc-400 italic">
                &ldquo;{project.storytelling}&rdquo;
              </p>
            </div>
          )}
        </div>
      </main>
    </div>
  );
}
