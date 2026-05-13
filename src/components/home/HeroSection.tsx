'use client';

import { useState, useRef } from 'react';
import Image from 'next/image';
import Link from 'next/link';
import { Project } from '@/types/project';
import { useLocale } from '@/context/LocaleContext';

interface Props {
  project: Project;
}

function PauseIcon() {
  return (
    <svg width="10" height="12" viewBox="0 0 10 12" fill="currentColor" aria-hidden="true">
      <rect x="0" y="0" width="3.5" height="12" rx="1" />
      <rect x="6.5" y="0" width="3.5" height="12" rx="1" />
    </svg>
  );
}

function PlayIcon() {
  return (
    <svg width="12" height="14" viewBox="0 0 12 14" fill="currentColor" aria-hidden="true">
      <path d="M1.5 1.5l9 5-9 5V1.5z" />
    </svg>
  );
}

export function HeroSection({ project }: Props) {
  const { t, locale } = useLocale();
  const [isPaused, setIsPaused] = useState(false);
  const videoRef = useRef<HTMLVideoElement>(null);

  const togglePause = () => {
    const video = videoRef.current;
    if (!video) return;
    if (isPaused) {
      video.play();
    } else {
      video.pause();
    }
    setIsPaused((prev) => !prev);
  };

  const hasVideo = Boolean(project.backgroundVideo);
  const hasCover = Boolean(project.coverImage);

  return (
    <section className="relative -mt-[80px] h-screen overflow-hidden">
      {/* Background: video → image → color */}
      {hasVideo ? (
        <video
          ref={videoRef}
          autoPlay
          muted
          loop
          playsInline
          className="absolute inset-0 h-full w-full object-cover"
        >
          <source src={project.backgroundVideo} type="video/mp4" />
        </video>
      ) : hasCover ? (
        <Image
          src={project.coverImage!}
          alt={project.title}
          fill
          priority
          className="object-cover"
          sizes="100vw"
        />
      ) : (
        <div
          className="absolute inset-0"
          style={{
            background: project.primaryColor
              ? `radial-gradient(ellipse at 30% 60%, ${project.primaryColor}40 0%, #0a0a0a 70%)`
              : '#0a0a0a',
          }}
        />
      )}

      {/* Gradient overlay — dark at bottom for text, slight at top under header */}
      <div className="absolute inset-0 bg-gradient-to-t from-black/75 via-black/10 to-black/50" />

      {/* Content — bottom left */}
      <div className="absolute bottom-16 left-8 max-w-2xl sm:left-12 lg:left-16">
        <p className="mb-3 text-[11px] font-semibold uppercase tracking-[0.2em] text-white/50">
          {project.category[locale]}
        </p>
        <h1 className="mb-7 text-5xl font-black leading-[0.95] tracking-tight text-white sm:text-6xl lg:text-7xl">
          {project.title}.
        </h1>
        <Link
          href={`/projects/${project.id}`}
          className="inline-flex items-center gap-2 rounded-full border border-white/30 bg-white/10 px-5 py-2.5 text-sm font-medium text-white backdrop-blur-sm transition-all hover:border-white/60 hover:bg-white/20"
        >
          {t.hero.cta}
        </Link>
      </div>

      {/* Scroll indicator — bottom center */}
      <div className="absolute bottom-8 left-1/2 -translate-x-1/2">
        <svg
          width="16"
          height="22"
          viewBox="0 0 16 22"
          fill="none"
          className="animate-bounce text-white/40"
          aria-hidden="true"
        >
          <path
            d="M8 2v18M2 14l6 6 6-6"
            stroke="currentColor"
            strokeWidth="1.5"
            strokeLinecap="round"
            strokeLinejoin="round"
          />
        </svg>
      </div>

      {/* Pause/play — bottom right (only when there's a video) */}
      {hasVideo && (
        <button
          onClick={togglePause}
          aria-label={isPaused ? t.a11y.playVideo : t.a11y.pauseVideo}
          className="absolute bottom-7 right-8 flex h-9 w-9 items-center justify-center rounded-full border border-white/20 bg-white/10 text-white backdrop-blur-sm transition-all hover:border-white/40 hover:bg-white/20"
        >
          {isPaused ? <PlayIcon /> : <PauseIcon />}
        </button>
      )}
    </section>
  );
}
