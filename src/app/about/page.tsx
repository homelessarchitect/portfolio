import type { Metadata } from 'next';
import Link from 'next/link';
import { Header } from '@/components/layout/Header';

export const metadata: Metadata = {
  title: 'About — Homeless Architect',
  description:
    'Mobile products for SMEs. Flutter developer based in Bucaramanga, Colombia.',
};

export default function AboutPage() {
  return (
    <div className="flex min-h-screen flex-col">
      <Header />

      <main className="flex-1">
        <div className="mx-auto max-w-screen-xl px-6 py-24">

          {/* Value proposition */}
          <div className="max-w-2xl">
            <p className="mb-6 text-[11px] font-semibold uppercase tracking-widest text-zinc-600">
              Darien Herrera · Bucaramanga, Colombia
            </p>

            <h1 className="mb-8 text-4xl font-black leading-tight tracking-tight text-white md:text-5xl">
              I build mobile products
              <br />
              <span className="text-zinc-500">that solve real problems.</span>
            </h1>

            <p className="mb-12 text-lg leading-relaxed text-zinc-400">
              Flutter developer with an architecture background. I come from designing
              physical spaces — now I design systems. That means I think about the
              whole product, not just the screen in front of me. I work with SMEs that
              need software that actually gets used in the field.
            </p>

            <div className="mb-12 grid gap-4 sm:grid-cols-3">
              {[
                {
                  title: 'Cross-platform',
                  body: 'iOS, Android, and Web from a single Flutter codebase.',
                },
                {
                  title: 'SME-focused',
                  body: 'Products built for real operational use, not demos.',
                },
                {
                  title: 'Design-first',
                  body: 'Architecture background means fewer UI revision rounds.',
                },
              ].map((item) => (
                <div
                  key={item.title}
                  className="rounded-xl border border-white/[0.06] bg-white/[0.02] p-4"
                >
                  <p className="mb-1 text-sm font-semibold text-white">{item.title}</p>
                  <p className="text-xs leading-relaxed text-zinc-500">{item.body}</p>
                </div>
              ))}
            </div>

            {/* Stack */}
            <div className="mb-12 flex flex-wrap gap-2">
              {['Flutter', 'Firebase', 'Dart', 'Git'].map((tech) => (
                <span
                  key={tech}
                  className="rounded-lg border border-white/[0.08] bg-white/[0.03] px-3 py-1.5 text-sm font-medium text-zinc-400"
                >
                  {tech}
                </span>
              ))}
            </div>

            {/* CTA */}
            <div className="flex flex-wrap gap-3">
              <Link
                href="/"
                className="rounded-xl border border-white/[0.1] bg-white/[0.04] px-5 py-2.5 text-sm font-medium text-zinc-300 transition-colors hover:bg-white/[0.08]"
              >
                See projects →
              </Link>
              <a
                href="mailto:dariensherrera.dev@gmail.com"
                className="rounded-xl bg-white px-5 py-2.5 text-sm font-semibold text-black transition-opacity hover:opacity-90"
              >
                Get in touch
              </a>
            </div>
          </div>

        </div>
      </main>

      <footer className="border-t border-white/[0.04] px-6 py-6">
        <div className="mx-auto flex max-w-screen-xl items-center justify-between">
          <p className="text-xs text-zinc-700">© {new Date().getFullYear()} Darien Herrera</p>
          <p className="text-xs text-zinc-700">Built with Next.js · Tailwind CSS</p>
        </div>
      </footer>
    </div>
  );
}
