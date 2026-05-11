import { Header } from '@/components/layout/Header';
import { ProjectGrid } from '@/components/gallery/ProjectGrid';
import { projects } from '@/data/projects';

export default function GalleryPage() {
  return (
    <div className="flex min-h-screen flex-col">
      <Header />

      <main className="flex-1">
        <div className="mx-auto max-w-screen-xl px-6 py-10">
          <div className="mb-10">
            <h1 className="text-2xl font-bold tracking-tight text-white">
              Projects
            </h1>
            <p className="mt-1 text-sm text-zinc-500">
              {projects.length} products built — interactive replicas, not
              screenshots.
            </p>
          </div>

          <ProjectGrid projects={projects} />
        </div>
      </main>

      <footer className="border-t border-white/[0.04] px-6 py-6">
        <div className="mx-auto flex max-w-screen-xl items-center justify-between">
          <p className="text-xs text-zinc-700">
            © {new Date().getFullYear()} Homeless Architect
          </p>
          <p className="text-xs text-zinc-700">
            Built with Next.js · Tailwind CSS
          </p>
        </div>
      </footer>
    </div>
  );
}
