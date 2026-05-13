import { notFound } from 'next/navigation';
import type { Metadata } from 'next';
import { Header } from '@/components/layout/Header';
import { projects, getProject } from '@/data/projects';
import { StickyProjectBar } from '@/components/project-detail/StickyProjectBar';
import { ProductHero } from '@/components/project-detail/ProductHero';
import { EditorialSection } from '@/components/project-detail/EditorialSection';
import { TechSection } from '@/components/project-detail/TechSection';
import { ProcessSection } from '@/components/project-detail/ProcessSection';
import { SimulationSection } from '@/components/project-detail/SimulationSection';
import { RatingSection } from '@/components/project-detail/RatingSection';

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
    description: project.tagline.en,
  };
}

export default async function ProjectDetailPage({ params }: Props) {
  const { slug } = await params;
  const project = getProject(slug);

  if (!project) notFound();

  return (
    <div className="flex min-h-screen flex-col">
      <Header />

      {/* 1 — Product hero (mockup + title + CTAs) */}
      <ProductHero project={project} />

      {/* 2 — Sticky bar (appears once hero scrolls out) */}
      <StickyProjectBar project={project} />

      {/* 3 — Editorial (storytelling + problema/solución) */}
      <EditorialSection project={project} />

      {/* 5 — Stack técnico */}
      <TechSection project={project} />

      {/* 6 — Proceso */}
      <ProcessSection project={project} />

      {/* 7 — Simulación interactiva */}
      <SimulationSection project={project} />

      {/* 8 — Rating */}
      <RatingSection project={project} />

      {/* Footer */}
      <footer className="border-t border-white/[0.04] px-6 py-8">
        <div className="mx-auto flex max-w-screen-xl items-center justify-between">
          <p className="text-xs text-zinc-700">
            © {new Date().getFullYear()} Homeless Architect
          </p>
          <p className="text-xs text-zinc-700">Next.js · Tailwind CSS</p>
        </div>
      </footer>
    </div>
  );
}
