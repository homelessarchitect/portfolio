'use client';

import { useState } from 'react';
import Link from 'next/link';
import { NavigationDrawer } from './NavigationDrawer';
import { LocaleSelector } from './LocaleSelector';
import { useLocale } from '@/context/LocaleContext';

export function Header() {
  const [isDrawerOpen, setIsDrawerOpen] = useState(false);
  const { t } = useLocale();

  return (
    <>
      <header className="sticky top-0 z-30 flex h-[80px] items-center justify-between bg-[#0a0a0a]/90 px-6 backdrop-blur-md">
        {/* Left: Menu trigger */}
        <button
          onClick={() => setIsDrawerOpen(true)}
          aria-label={t.a11y.openMenu}
          className="flex items-center gap-2.5 text-white/60 transition-colors hover:text-white"
        >
          <svg
            width="18"
            height="13"
            viewBox="0 0 18 13"
            fill="none"
            aria-hidden="true"
          >
            <path
              d="M0 1.5h18M0 6.5h18M0 11.5h18"
              stroke="currentColor"
              strokeWidth="1.5"
              strokeLinecap="round"
            />
          </svg>
          <span className="text-sm tracking-wide">{t.nav.menu}</span>
        </button>

        {/* Center: Logo */}
        <Link
          href="/"
          className="absolute left-1/2 -translate-x-1/2 text-[15px] font-black uppercase tracking-[0.22em] text-white transition-opacity hover:opacity-70"
        >
          Homeless Architect
        </Link>

        {/* Right: Contact + Locale */}
        <div className="flex items-center gap-3">
          <a
            href="mailto:dariensherrera.dev@gmail.com"
            aria-label={t.a11y.contactEmail}
            className="text-white/40 transition-colors hover:text-white"
          >
            <svg
              width="18"
              height="18"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="1.5"
              strokeLinecap="round"
              strokeLinejoin="round"
              aria-hidden="true"
            >
              <rect x="2" y="4" width="20" height="16" rx="2" />
              <path d="M2 7l10 7 10-7" />
            </svg>
          </a>
          <LocaleSelector />
        </div>
      </header>

      <NavigationDrawer
        isOpen={isDrawerOpen}
        onClose={() => setIsDrawerOpen(false)}
      />
    </>
  );
}
