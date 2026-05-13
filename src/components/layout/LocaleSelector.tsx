'use client';

import { useEffect, useRef, useState } from 'react';
import { useLocale } from '@/context/LocaleContext';
import type { Locale } from '@/i18n/dictionaries';

const OPTIONS: { locale: Locale; label: string }[] = [
  { locale: 'es', label: 'Español' },
  { locale: 'en', label: 'English' },
];

export function LocaleSelector() {
  const [isOpen, setIsOpen] = useState(false);
  const { locale, setLocale, t } = useLocale();
  const triggerRef = useRef<HTMLButtonElement>(null);
  const firstOptionRef = useRef<HTMLButtonElement>(null);

  useEffect(() => {
    if (!isOpen) return;
    const handler = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        setIsOpen(false);
        triggerRef.current?.focus();
      }
    };
    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [isOpen]);

  useEffect(() => {
    document.body.style.overflow = isOpen ? 'hidden' : '';
    return () => {
      document.body.style.overflow = '';
    };
  }, [isOpen]);

  useEffect(() => {
    if (isOpen) firstOptionRef.current?.focus();
  }, [isOpen]);

  return (
    <>
      <button
        ref={triggerRef}
        onClick={() => setIsOpen(true)}
        aria-label={t.a11y.openLocale}
        aria-expanded={isOpen}
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
          <circle cx="12" cy="12" r="10" />
          <path d="M2 12h20" />
          <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
        </svg>
      </button>

      {isOpen && (
        <div
          aria-hidden="true"
          onClick={() => setIsOpen(false)}
          className="fixed inset-0 z-[60] bg-black/50 backdrop-blur-sm"
        />
      )}

      {isOpen && (
        <div
          role="dialog"
          aria-modal="true"
          aria-label={t.a11y.openLocale}
          className="fixed right-4 top-[88px] z-[70] w-40 rounded-2xl border border-white/10 bg-[#111] p-2 shadow-2xl"
        >
          {OPTIONS.map(({ locale: loc, label }, index) => (
            <button
              key={loc}
              ref={index === 0 ? firstOptionRef : undefined}
              onClick={() => {
                setLocale(loc);
                setIsOpen(false);
              }}
              className={`flex w-full items-center gap-3 rounded-xl px-3 py-2.5 text-sm transition-colors hover:bg-white/10 ${
                locale === loc ? 'font-semibold text-white' : 'text-white/50'
              }`}
            >
              <span
                className={`h-1.5 w-1.5 flex-shrink-0 rounded-full ${
                  locale === loc ? 'bg-white' : 'bg-transparent'
                }`}
              />
              {label}
            </button>
          ))}
        </div>
      )}
    </>
  );
}
