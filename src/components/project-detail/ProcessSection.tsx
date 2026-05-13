'use client';

import { Project } from '@/types/project';
import { useLocale } from '@/context/LocaleContext';

interface Props {
  project: Project;
}

export function ProcessSection({ project }: Props) {
  const { t, locale } = useLocale();

  if (!project.processSteps?.length) return null;

  return (
    <section className="border-b border-white/[0.04]">
      <div className="mx-auto max-w-screen-xl px-6 py-20">
        {/* Header */}
        <div className="mb-16 max-w-2xl">
          <p className="mb-4 text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
            {t.detail.process}
          </p>
          <h2 className="text-3xl font-black leading-tight tracking-tight text-white sm:text-4xl">
            {t.detail.howWeBuilt} {project.title}.
          </h2>
        </div>

        {/* Steps */}
        <div className="grid grid-cols-1 gap-0 border-t border-white/[0.06] sm:grid-cols-2 lg:grid-cols-4">
          {project.processSteps.map((step, i) => (
            <div
              key={step.id}
              className="border-b border-r border-white/[0.06] px-6 py-8 last:border-r-0 sm:[&:nth-child(2n)]:border-r-0 lg:[&:nth-child(2n)]:border-r lg:[&:nth-child(4n)]:border-r-0"
            >
              {/* Accent line */}
              <div
                className="mb-8 h-[2px] w-8"
                style={{ background: project.primaryColor ?? '#52525b' }}
              />

              {/* Step number */}
              <p
                className="mb-6 text-5xl font-black tabular-nums leading-none"
                style={{
                  color: project.primaryColor ?? '#52525b',
                  opacity: 0.25,
                }}
              >
                {String(i + 1).padStart(2, '0')}
              </p>

              {/* Phase label */}
              <p className="mb-2 text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
                {step.phase[locale]}
              </p>

              {/* Title */}
              <p className="mb-3 text-base font-semibold text-white">{step.title[locale]}</p>

              {/* Description */}
              <p className="text-sm leading-relaxed text-zinc-500">{step.description[locale]}</p>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
