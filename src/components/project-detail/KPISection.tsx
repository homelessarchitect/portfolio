import Image from 'next/image';
import { Project } from '@/types/project';

interface KPI {
  value: string;
  unit?: string;
  label: string;
}

function buildKPIs(project: Project): KPI[] {
  return [
    { value: project.year, label: 'Año' },
    {
      value: String(project.platforms.length),
      unit: project.platforms.length === 1 ? '' : '+',
      label: 'Plataformas',
    },
    {
      value: String(project.apps?.length ?? project.services.length),
      label: project.apps?.length ? 'Apps' : 'Tecnologías',
    },
  ];
}

interface Props {
  project: Project;
}

export function KPISection({ project }: Props) {
  const kpis = buildKPIs(project);
  const image = project.conceptImageUrl ?? project.coverImage;

  return (
    <section className="border-b border-white/[0.04]">
      <div className="mx-auto grid max-w-screen-xl grid-cols-1 md:grid-cols-2">
        {/* Stats — left */}
        <div className="flex flex-col justify-center gap-10 px-6 py-20 md:px-12">
          {kpis.map((kpi) => (
            <div key={kpi.label}>
              <p className="leading-none">
                <span className="text-8xl font-black tracking-tight text-white sm:text-9xl">
                  {kpi.value}
                </span>
                {kpi.unit && (
                  <span className="ml-1 text-4xl font-black text-zinc-600">
                    {kpi.unit}
                  </span>
                )}
              </p>
              <p className="mt-2 text-sm text-zinc-500">{kpi.label}</p>
            </div>
          ))}
        </div>

        {/* Image — right */}
        <div className="relative hidden min-h-[400px] overflow-hidden md:block">
          {image ? (
            <Image
              src={image}
              alt={project.title}
              fill
              className="object-cover"
              sizes="(min-width: 768px) 50vw, 100vw"
            />
          ) : (
            <div
              className="absolute inset-0"
              style={{
                background: project.primaryColor
                  ? `radial-gradient(ellipse at 50% 50%, ${project.primaryColor}30 0%, transparent 70%)`
                  : 'radial-gradient(ellipse at 50% 50%, rgba(255,255,255,0.04) 0%, transparent 70%)',
              }}
            />
          )}
          {/* Overlay to blend into page */}
          <div className="absolute inset-0 bg-gradient-to-r from-[#0a0a0a] via-transparent to-transparent" />
        </div>
      </div>
    </section>
  );
}
