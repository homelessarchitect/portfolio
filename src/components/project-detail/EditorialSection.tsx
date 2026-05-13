'use client';

import Image from 'next/image';
import { Project } from '@/types/project';
import { useLocale } from '@/context/LocaleContext';

interface Props {
  project: Project;
}

export function EditorialSection({ project }: Props) {
  const { t, locale } = useLocale();

  const hasStory = Boolean(project.storytelling?.[locale] || project.tagline[locale]);
  const hasImages = Boolean(
    project.conceptImageUrl ||
      project.historyImageUrl ||
      project.problemSolutionImageUrl,
  );
  const hasProblemSolution = Boolean(project.problem && project.solution);

  if (!hasStory && !hasImages && !hasProblemSolution) return null;

  return (
    <section className="border-b border-white/[0.04]">
      {/* Headline + story — full width asymmetric */}
      {hasStory && (
        <div className="mx-auto grid max-w-screen-xl grid-cols-1 gap-12 px-6 py-20 md:grid-cols-2 md:items-start md:gap-20">
          {/* Left: copy */}
          <div>
            <h2 className="mb-6 text-3xl font-black leading-tight tracking-tight text-white sm:text-4xl">
              {project.tagline[locale]}
            </h2>
            {project.storytelling && (
              <p className="text-base leading-relaxed text-zinc-400">
                {project.storytelling[locale]}
              </p>
            )}
          </div>

          {/* Right: image or gradient */}
          <div className="relative overflow-hidden rounded-2xl" style={{ minHeight: 280 }}>
            {project.historyImageUrl ? (
              <Image
                src={project.historyImageUrl}
                alt={`${project.title} historia`}
                fill
                className="object-cover"
                sizes="(min-width: 768px) 50vw, 100vw"
              />
            ) : project.coverImage ? (
              <Image
                src={project.coverImage}
                alt={project.title}
                fill
                className="object-cover"
                sizes="(min-width: 768px) 50vw, 100vw"
              />
            ) : (
              <div
                className="absolute inset-0 rounded-2xl"
                style={{
                  background: project.primaryColor
                    ? `radial-gradient(ellipse at 60% 40%, ${project.primaryColor}25 0%, transparent 70%)`
                    : 'radial-gradient(ellipse at 60% 40%, rgba(255,255,255,0.04) 0%, transparent 70%)',
                }}
              />
            )}
          </div>
        </div>
      )}

      {/* Problem / Solution */}
      {hasProblemSolution && (
        <div className="mx-auto grid max-w-screen-xl grid-cols-1 gap-4 px-6 pb-20 md:grid-cols-2">
          <div className="rounded-2xl border border-white/[0.06] bg-white/[0.02] p-8">
            <p className="mb-4 text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
              {t.detail.problem}
            </p>
            <p className="text-sm leading-relaxed text-zinc-300">
              {project.problem![locale]}
            </p>
          </div>
          <div className="rounded-2xl border border-white/[0.06] bg-white/[0.02] p-8">
            <p className="mb-4 text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
              {t.detail.solution}
            </p>
            <p className="text-sm leading-relaxed text-zinc-300">
              {project.solution![locale]}
            </p>
          </div>
        </div>
      )}

      {/* Concept / problem-solution image */}
      {project.conceptImageUrl && (
        <div className="mx-auto max-w-screen-xl px-6 pb-20">
          <div className="overflow-hidden rounded-2xl border border-white/[0.06]">
            <Image
              src={project.conceptImageUrl}
              alt={`${project.title} concepto`}
              width={1200}
              height={600}
              className="w-full object-cover"
            />
          </div>
        </div>
      )}
    </section>
  );
}
