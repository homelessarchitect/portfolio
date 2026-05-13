'use client';

import { useState } from 'react';
import { Project } from '@/types/project';

interface Props {
  project: Project;
}

function StarIcon({ filled, color }: { filled: boolean; color: string }) {
  return (
    <svg
      width="36"
      height="36"
      viewBox="0 0 24 24"
      fill={filled ? color : 'none'}
      stroke={filled ? color : '#3f3f46'}
      strokeWidth="1.5"
      strokeLinecap="round"
      strokeLinejoin="round"
      aria-hidden="true"
      className="transition-colors duration-100"
    >
      <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z" />
    </svg>
  );
}

export function RatingSection({ project }: Props) {
  const [hovered, setHovered] = useState(0);
  const [selected, setSelected] = useState(0);

  const accentColor = project.primaryColor ?? '#ffffff';
  const activeLevel = hovered || selected;

  if (selected > 0) {
    return (
      <section className="border-b border-white/[0.04]">
        <div className="mx-auto max-w-screen-xl px-6 py-24">
          <div className="mx-auto flex max-w-lg flex-col items-center gap-8 text-center">
            <p className="text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
              Recibido
            </p>

            <div className="flex gap-3">
              {[1, 2, 3, 4, 5].map((star) => (
                <StarIcon key={star} filled={star <= selected} color={accentColor} />
              ))}
            </div>

            <div>
              <h2 className="text-2xl font-black tracking-tight text-white">
                Gracias por tu valoración.
              </h2>
              <p className="mt-2 text-sm text-zinc-500">
                {selected >= 4
                  ? '¿Querés que construyamos algo juntos?'
                  : '¿Tenés feedback? Me encantaría escucharlo.'}
              </p>
            </div>

            <a
              href="mailto:dariensherrera.dev@gmail.com"
              className="rounded-full bg-white px-7 py-3 text-sm font-semibold text-black transition-opacity duration-200 hover:opacity-80"
            >
              Escribime →
            </a>
          </div>
        </div>
      </section>
    );
  }

  return (
    <section className="border-b border-white/[0.04]">
      <div className="mx-auto max-w-screen-xl px-6 py-24">
        <div className="mx-auto flex max-w-lg flex-col items-center gap-8 text-center">
          <div>
            <p className="mb-4 text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
              Tu opinión
            </p>
            <h2 className="text-2xl font-black tracking-tight text-white sm:text-3xl">
              ¿Qué te pareció {project.title}?
            </h2>
          </div>

          <div
            className="flex gap-3"
            onMouseLeave={() => setHovered(0)}
            role="group"
            aria-label="Valoración de 5 estrellas"
          >
            {[1, 2, 3, 4, 5].map((star) => (
              <button
                key={star}
                aria-label={`${star} estrella${star > 1 ? 's' : ''}`}
                onMouseEnter={() => setHovered(star)}
                onClick={() => setSelected(star)}
                className="transition-transform duration-150 hover:scale-110 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-white/40 focus-visible:ring-offset-2 focus-visible:ring-offset-black"
              >
                <StarIcon filled={star <= activeLevel} color={accentColor} />
              </button>
            ))}
          </div>

          <p className="text-xs text-zinc-700">
            {activeLevel > 0
              ? ['', 'Puede mejorar.', 'Hay potencial.', 'Buen trabajo.', 'Muy bueno.', 'Excelente.'][activeLevel]
              : 'Hacé click en las estrellas.'}
          </p>
        </div>
      </div>
    </section>
  );
}
