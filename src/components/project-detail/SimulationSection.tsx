import { Project } from '@/types/project';
import { AppScreenExplorer } from './AppScreenExplorer';

interface Props {
  project: Project;
}

export function SimulationSection({ project }: Props) {
  if (!project.apps?.length) return null;

  return (
    <section id="simulacion" className="border-b border-white/[0.04]">
      <div className="mx-auto max-w-screen-xl px-6 py-20">
        {/* Header */}
        <div className="mb-12 max-w-xl">
          <p className="mb-4 text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
            Simulación interactiva
          </p>
          <h2 className="text-3xl font-black leading-tight tracking-tight text-white">
            Operá {project.title} directamente desde acá.
          </h2>
          <p className="mt-3 text-sm leading-relaxed text-zinc-500">
            No screenshots. Réplicas funcionales de las pantallas reales.
          </p>
        </div>

        <AppScreenExplorer project={project} />
      </div>
    </section>
  );
}
