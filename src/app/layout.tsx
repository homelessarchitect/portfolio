import type { Metadata } from 'next';
import { Geist, Geist_Mono } from 'next/font/google';
import { LocaleProvider } from '@/context/LocaleContext';
import { HtmlLangSync } from '@/components/layout/HtmlLangSync';
import './globals.css';

const geistSans = Geist({
  variable: '--font-geist-sans',
  subsets: ['latin'],
});

const geistMono = Geist_Mono({
  variable: '--font-geist-mono',
  subsets: ['latin'],
});

export const metadata: Metadata = {
  title: 'Homeless Architect — Portfolio',
  description:
    'Interactive portfolio of mobile and web products. Built with real code, not screenshots.',
  openGraph: {
    title: 'Homeless Architect',
    description: 'Interactive portfolio of mobile and web products.',
    type: 'website',
  },
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html
      lang="es"
      className={`${geistSans.variable} ${geistMono.variable} h-full antialiased`}
    >
      <body className="min-h-full flex flex-col">
        <LocaleProvider>
          <HtmlLangSync />
          {children}
        </LocaleProvider>
      </body>
    </html>
  );
}
