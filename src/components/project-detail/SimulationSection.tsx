'use client';

import { Project } from '@/types/project';
import { AppScreenExplorer } from './AppScreenExplorer';
import { useLocale } from '@/context/LocaleContext';

interface Props {
  project: Project;
}

export function SimulationSection({ project }: Props) {
  const { t } = useLocale();

  if (!project.apps?.length) return null;

  return (
    <section id="simulacion" className="border-b border-white/[0.04]">
      <div className="mx-auto max-w-screen-xl px-6 py-20">
        {/* Header */}
        <div className="mb-12 max-w-xl">
          <p className="mb-4 text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
            {t.detail.simulation}
          </p>
          <h2 className="text-3xl font-black leading-tight tracking-tight text-white">
            {t.detail.simulationCta} {project.title} {t.detail.simulationCtaSuffix}
          </h2>
          <p className="mt-3 text-sm leading-relaxed text-zinc-500">
            {t.detail.simulationSub}
          </p>
        </div>

        <AppScreenExplorer project={project} />
      </div>
    </section>
  );
}
