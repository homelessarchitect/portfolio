import type { Metadata } from 'next';
import Link from 'next/link';
import { Header } from '@/components/layout/Header';

export const metadata: Metadata = {
  title: 'About — Homeless Architect',
  description:
    'Architect turned developer. Building digital products from Bucaramanga, Colombia.',
};

const STACK = [
  { name: 'Flutter', level: 'Proficient' },
  { name: 'Firebase', level: 'Proficient' },
  { name: 'Dart', level: 'Proficient' },
  { name: 'JavaScript', level: 'Learning' },
  { name: 'Python', level: 'Learning' },
  { name: 'Git / GitHub', level: 'Proficient' },
  { name: 'Selenium', level: 'Familiar' },
];

const EXPERIENCE = [
  {
    role: 'Junior Mobile Developer',
    company: 'Freelance',
    period: '2025 — Present',
    location: 'Remote · Colombia',
    items: [
      'Industrial Management System for a UTV car factory — inventory control and manufacturing processes with Flutter & Firebase.',
      'Services Marketplace platform connecting providers and clients through scalable architecture.',
      'Club Manager — architecture design and data models for real-time sports club membership administration.',
    ],
  },
  {
    role: 'Technical Coordinator',
    company: 'INACAR',
    period: 'Mar 2024 — Jun 2024',
    location: 'Bucaramanga, Colombia',
    items: [
      'Collaborated with multidisciplinary teams to optimize blueprint and technical documentation delivery under pressure.',
      'Improved technical data organization in the design department, increasing file retrieval efficiency.',
    ],
  },
];

const EDUCATION = [
  {
    degree: 'Architecture',
    institution: 'Universidad Santo Tomás de Aquino',
    period: '2024',
    note: 'Design thinking, project management, and technical coordination — transferred to software development.',
  },
  {
    degree: 'Software Development & English',
    institution: 'Platzi',
    period: '2025 — Present',
    note: 'Continuous learning in software engineering and professional English.',
  },
];

export default function AboutPage() {
  return (
    <div className="flex min-h-screen flex-col">
      <Header />

      <main className="flex-1">
        {/* Hero */}
        <section className="relative overflow-hidden border-b border-white/[0.04]">
          <div className="pointer-events-none absolute inset-0">
            <div className="absolute -left-32 -top-32 h-96 w-96 rounded-full bg-white/[0.02] blur-3xl" />
            <div className="absolute -right-32 top-0 h-96 w-96 rounded-full bg-white/[0.015] blur-3xl" />
            {/* Architectural grid lines */}
            <svg
              className="absolute inset-0 h-full w-full opacity-[0.03]"
              xmlns="http://www.w3.org/2000/svg"
            >
              <defs>
                <pattern
                  id="grid"
                  width="40"
                  height="40"
                  patternUnits="userSpaceOnUse"
                >
                  <path
                    d="M 40 0 L 0 0 0 40"
                    fill="none"
                    stroke="white"
                    strokeWidth="1"
                  />
                </pattern>
              </defs>
              <rect width="100%" height="100%" fill="url(#grid)" />
            </svg>
          </div>

          <div className="relative mx-auto max-w-screen-xl px-6 py-24">
            <p className="mb-4 text-[11px] font-semibold uppercase tracking-widest text-zinc-600">
              Bucaramanga, Colombia
            </p>

            <h1 className="mb-6 text-5xl font-black tracking-tight text-white md:text-7xl">
              Darien
              <br />
              Herrera
            </h1>

            <p className="max-w-lg text-xl leading-relaxed text-zinc-400 md:text-2xl">
              Architect turned developer.{' '}
              <span className="text-white">
                I build digital products for SMEs
              </span>{' '}
              — the kind that actually solve operational problems.
            </p>

            <div className="mt-10 flex flex-wrap gap-3">
              <a
                href="mailto:dariensherrera.dev@gmail.com"
                className="rounded-xl bg-white px-5 py-2.5 text-sm font-semibold text-black transition-opacity hover:opacity-90"
              >
                dariensherrera.dev@gmail.com
              </a>
              <a
                href="https://github.com/homelessarchitect"
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center gap-2 rounded-xl border border-white/[0.1] bg-white/[0.04] px-5 py-2.5 text-sm font-medium text-zinc-300 transition-colors hover:bg-white/[0.08]"
              >
                <svg width="15" height="15" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M12 0C5.37 0 0 5.37 0 12c0 5.3 3.438 9.8 8.205 11.385.6.113.82-.258.82-.577 0-.285-.01-1.04-.015-2.04-3.338.724-4.042-1.61-4.042-1.61C4.422 18.07 3.633 17.7 3.633 17.7c-1.087-.744.084-.729.084-.729 1.205.084 1.838 1.236 1.838 1.236 1.07 1.835 2.809 1.305 3.495.998.108-.776.417-1.305.76-1.605-2.665-.3-5.466-1.332-5.466-5.93 0-1.31.465-2.38 1.235-3.22-.135-.303-.54-1.523.105-3.176 0 0 1.005-.322 3.3 1.23.96-.267 1.98-.399 3-.405 1.02.006 2.04.138 3 .405 2.28-1.552 3.285-1.23 3.285-1.23.645 1.653.24 2.873.12 3.176.765.84 1.23 1.91 1.23 3.22 0 4.61-2.805 5.625-5.475 5.92.42.36.81 1.096.81 2.22 0 1.606-.015 2.896-.015 3.286 0 .315.21.69.825.57C20.565 21.795 24 17.295 24 12c0-6.63-5.37-12-12-12z" />
                </svg>
                homelessarchitect
              </a>
              <a
                href="https://www.linkedin.com/in/darien-herrera/"
                target="_blank"
                rel="noopener noreferrer"
                className="flex items-center gap-2 rounded-xl border border-white/[0.1] bg-white/[0.04] px-5 py-2.5 text-sm font-medium text-zinc-300 transition-colors hover:bg-white/[0.08]"
              >
                <svg width="15" height="15" viewBox="0 0 24 24" fill="currentColor">
                  <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433a2.062 2.062 0 01-2.063-2.065 2.064 2.064 0 112.063 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z" />
                </svg>
                LinkedIn
              </a>
            </div>
          </div>
        </section>

        {/* Story */}
        <section className="border-b border-white/[0.04]">
          <div className="mx-auto max-w-screen-xl px-6 py-20">
            <div className="grid gap-12 md:grid-cols-[1fr_2fr]">
              <div>
                <p className="text-[11px] font-semibold uppercase tracking-widest text-zinc-600">
                  The story
                </p>
              </div>
              <div className="space-y-6">
                <p className="text-lg leading-relaxed text-zinc-300">
                  I studied architecture. Five years reading blueprints, managing
                  projects, coordinating technical teams under deadline pressure. I
                  learned to think in systems — how a change in one place propagates
                  through everything else.
                </p>
                <p className="text-lg leading-relaxed text-zinc-300">
                  Then I realized the most interesting buildings being constructed
                  were digital. I left architecture and went all-in on software.
                  The{' '}
                  <span className="font-semibold text-white">
                    "homeless architect"
                  </span>{' '}
                  — without a professional house — building a new one in code.
                </p>
                <p className="text-lg leading-relaxed text-zinc-300">
                  Today I build mobile and web products for SMEs with Flutter and
                  Firebase. My background in design and project coordination means I
                  think about the whole system, not just the component in front of me.
                </p>

                <blockquote className="border-l-2 border-white/20 pl-5 text-base italic text-zinc-500">
                  "Modular architecture, process automation, and UX that makes
                  operational complexity invisible."
                </blockquote>
              </div>
            </div>
          </div>
        </section>

        {/* Experience */}
        <section className="border-b border-white/[0.04]">
          <div className="mx-auto max-w-screen-xl px-6 py-20">
            <div className="grid gap-12 md:grid-cols-[1fr_2fr]">
              <div>
                <p className="text-[11px] font-semibold uppercase tracking-widest text-zinc-600">
                  Experience
                </p>
              </div>
              <div className="space-y-10">
                {EXPERIENCE.map((job) => (
                  <div key={job.company} className="group">
                    <div className="mb-3 flex flex-wrap items-start justify-between gap-2">
                      <div>
                        <p className="font-semibold text-white">{job.role}</p>
                        <p className="text-sm text-zinc-500">{job.company}</p>
                      </div>
                      <div className="text-right">
                        <p className="text-xs text-zinc-600">{job.period}</p>
                        <p className="text-xs text-zinc-700">{job.location}</p>
                      </div>
                    </div>
                    <ul className="space-y-2">
                      {job.items.map((item, i) => (
                        <li key={i} className="flex gap-3 text-sm text-zinc-400">
                          <span className="mt-1.5 h-1 w-1 shrink-0 rounded-full bg-zinc-700" />
                          {item}
                        </li>
                      ))}
                    </ul>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </section>

        {/* Stack */}
        <section className="border-b border-white/[0.04]">
          <div className="mx-auto max-w-screen-xl px-6 py-20">
            <div className="grid gap-12 md:grid-cols-[1fr_2fr]">
              <div>
                <p className="text-[11px] font-semibold uppercase tracking-widest text-zinc-600">
                  Stack
                </p>
              </div>
              <div className="flex flex-wrap gap-2">
                {STACK.map((s) => (
                  <div
                    key={s.name}
                    className="flex items-center gap-2 rounded-xl border border-white/[0.06] bg-white/[0.03] px-4 py-2.5"
                  >
                    <span className="text-sm font-medium text-white">{s.name}</span>
                    <span
                      className={`text-[10px] font-medium ${
                        s.level === 'Proficient'
                          ? 'text-emerald-500'
                          : s.level === 'Learning'
                          ? 'text-amber-500'
                          : 'text-zinc-600'
                      }`}
                    >
                      {s.level}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </section>

        {/* Education */}
        <section className="border-b border-white/[0.04]">
          <div className="mx-auto max-w-screen-xl px-6 py-20">
            <div className="grid gap-12 md:grid-cols-[1fr_2fr]">
              <div>
                <p className="text-[11px] font-semibold uppercase tracking-widest text-zinc-600">
                  Education
                </p>
              </div>
              <div className="space-y-8">
                {EDUCATION.map((ed) => (
                  <div key={ed.institution}>
                    <div className="mb-1 flex flex-wrap items-start justify-between gap-2">
                      <div>
                        <p className="font-semibold text-white">{ed.degree}</p>
                        <p className="text-sm text-zinc-500">{ed.institution}</p>
                      </div>
                      <p className="text-xs text-zinc-600">{ed.period}</p>
                    </div>
                    <p className="text-sm text-zinc-500">{ed.note}</p>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </section>

        {/* CTA */}
        <section>
          <div className="mx-auto max-w-screen-xl px-6 py-24">
            <div className="flex flex-col items-start gap-6 md:flex-row md:items-center md:justify-between">
              <div>
                <h2 className="text-3xl font-black tracking-tight text-white">
                  Let&apos;s build something.
                </h2>
                <p className="mt-1 text-zinc-500">
                  Open to freelance projects and full-time opportunities.
                </p>
              </div>
              <div className="flex gap-3">
                <Link
                  href="/"
                  className="rounded-xl border border-white/[0.1] bg-white/[0.04] px-5 py-2.5 text-sm font-medium text-zinc-300 transition-colors hover:bg-white/[0.08]"
                >
                  See projects
                </Link>
                <a
                  href="mailto:dariensherrera.dev@gmail.com"
                  className="rounded-xl bg-white px-5 py-2.5 text-sm font-semibold text-black transition-opacity hover:opacity-90"
                >
                  Send a message
                </a>
              </div>
            </div>
          </div>
        </section>
      </main>

      <footer className="border-t border-white/[0.04] px-6 py-6">
        <div className="mx-auto flex max-w-screen-xl items-center justify-between">
          <p className="text-xs text-zinc-700">
            © {new Date().getFullYear()} Darien Herrera
          </p>
          <p className="text-xs text-zinc-700">Built with Next.js · Tailwind CSS</p>
        </div>
      </footer>
    </div>
  );
}
