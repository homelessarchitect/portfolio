import { Project } from '@/types/project';

const PLATFORM_DESC: Record<string, string> = {
  web: 'Aplicación web — acceso desde cualquier navegador sin instalación.',
  mobile: 'Aplicación móvil nativa — iOS y Android desde un único codebase.',
  desktop: 'Aplicación de escritorio — integración directa con el sistema operativo.',
};

interface Props {
  project: Project;
}

export function TechSection({ project }: Props) {
  const headline = project.styleDescription
    ? project.styleDescription
    : `${project.services.slice(0, 2).join(' + ')} — arquitectura construida para escalar.`;

  const appsCount = project.apps?.length ?? project.services.length;
  const appsLabel = project.apps?.length ? 'Apps' : 'Servicios';

  return (
    <section className="border-b border-white/[0.04] bg-[#080808]">
      <div className="mx-auto max-w-screen-xl px-6 py-20">
        {/* Headline */}
        <div className="mb-16 max-w-2xl">
          <p className="mb-4 text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
            Stack técnico
          </p>
          <h2 className="text-3xl font-black leading-tight tracking-tight text-white sm:text-4xl">
            {headline}
          </h2>
        </div>

        {/* KPIs — merged from KPISection */}
        <div className="mb-16 grid grid-cols-3 gap-6 border-b border-white/[0.04] pb-16">
          <div>
            <p className="text-6xl font-black tracking-tight text-white sm:text-7xl">
              {project.year}
            </p>
            <p className="mt-2 text-xs text-zinc-500">Año</p>
          </div>
          <div>
            <p className="leading-none">
              <span className="text-6xl font-black tracking-tight text-white sm:text-7xl">
                {project.platforms.length}
              </span>
              {project.platforms.length > 1 && (
                <span className="ml-1 text-3xl font-black text-zinc-600">+</span>
              )}
            </p>
            <p className="mt-2 text-xs text-zinc-500">Plataformas</p>
          </div>
          <div>
            <p className="text-6xl font-black tracking-tight text-white sm:text-7xl">
              {appsCount}
            </p>
            <p className="mt-2 text-xs text-zinc-500">{appsLabel}</p>
          </div>
        </div>

        {/* Stack grid */}
        <div className="mb-16">
          <p className="mb-6 text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
            Tecnologías
          </p>
          <div className="flex flex-wrap gap-3">
            {project.services.map((service, i) => (
              <div
                key={service}
                className="flex items-center gap-3 rounded-xl border border-white/[0.06] bg-white/[0.03] px-4 py-3"
              >
                {/* Index indicator */}
                <span className="text-[10px] font-black tabular-nums text-zinc-700">
                  {String(i + 1).padStart(2, '0')}
                </span>
                <span className="text-sm font-medium text-white">{service}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Platforms */}
        <div>
          <p className="mb-6 text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
            Plataformas
          </p>
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {project.platforms.map((platform) => (
              <div
                key={platform}
                className="rounded-2xl border border-white/[0.06] bg-white/[0.02] p-6"
              >
                <p className="mb-2 text-sm font-semibold capitalize text-white">
                  {platform === 'web'
                    ? 'Web'
                    : platform === 'mobile'
                      ? 'Mobile'
                      : 'Desktop'}
                </p>
                <p className="text-xs leading-relaxed text-zinc-500">
                  {PLATFORM_DESC[platform] ?? platform}
                </p>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}
