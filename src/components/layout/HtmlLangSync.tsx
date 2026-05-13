'use client';

import { useEffect } from 'react';
import { useLocale } from '@/context/LocaleContext';

export function HtmlLangSync() {
  const { locale } = useLocale();

  useEffect(() => {
    document.documentElement.lang = locale;
  }, [locale]);

  return null;
}
