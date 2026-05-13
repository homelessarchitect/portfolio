'use client';

import { Header } from '@/components/layout/Header';
import { HeroSection } from '@/components/home/HeroSection';
import { ProjectGrid } from '@/components/gallery/ProjectGrid';
import { projects } from '@/data/projects';
import { useLocale } from '@/context/LocaleContext';

const featuredProject = projects[0];

export default function GalleryPage() {
  const { t } = useLocale();

  return (
    <div className="flex min-h-screen flex-col">
      <Header />

      <main className="flex-1">
        {/* Hero — full-bleed, slides under the sticky header */}
        <HeroSection project={featuredProject} />

        {/* Philosophy tagline */}
        <section className="border-b border-white/[0.04] py-24 text-center">
          <h2 className="mx-auto max-w-2xl text-3xl font-black leading-tight tracking-tight text-white sm:text-4xl">
            {t.home.tagline}
            <br />
            <span className="text-zinc-600">{t.home.taglineAccent}</span>
          </h2>
          <p className="mx-auto mt-5 max-w-lg text-sm leading-relaxed text-zinc-500">
            {t.home.taglineSub}
          </p>
        </section>

        {/* Project gallery */}
        <div className="mx-auto max-w-screen-xl px-6 py-16">
          <p className="mb-8 text-[10px] font-semibold uppercase tracking-widest text-zinc-600">
            {t.home.projectsLabel} · {projects.length} productos
          </p>
          <ProjectGrid projects={projects} />
        </div>
      </main>

      <footer className="border-t border-white/[0.04] px-6 py-6">
        <div className="mx-auto flex max-w-screen-xl items-center justify-between">
          <p className="text-xs text-zinc-700">
            © {new Date().getFullYear()} {t.footer.copyright}
          </p>
          <p className="text-xs text-zinc-700">
            Next.js · Tailwind CSS
          </p>
        </div>
      </footer>
    </div>
  );
}
