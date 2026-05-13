import Link from 'next/link';
import { Project } from '@/types/project';

interface Props {
  project: Project;
}

export function StickyProjectBar({ project }: Props) {
  const liveUrl = project.apps?.find((a) => a.liveUrl)?.liveUrl;

  return (
    <div className="sticky top-[80px] z-20 border-b border-white/[0.06] bg-[#0a0a0a]/95 backdrop-blur-md">
      <div className="mx-auto flex h-12 max-w-screen-xl items-center justify-between px-6">
        {/* Left: project name */}
        <p className="text-sm font-semibold text-white">{project.title}</p>

        {/* Center: change project */}
        <Link
          href="/"
          className="text-xs text-zinc-500 transition-colors hover:text-white"
        >
          Cambiar proyecto
        </Link>

        {/* Right: live demo or empty */}
        {liveUrl ? (
          <a
            href={liveUrl}
            target="_blank"
            rel="noopener noreferrer"
            className="text-xs text-zinc-500 transition-colors hover:text-white"
          >
            Ver demo en vivo ↗
          </a>
        ) : (
          <span className="w-[120px]" />
        )}
      </div>
    </div>
  );
}
