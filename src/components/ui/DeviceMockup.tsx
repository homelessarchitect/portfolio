import Image from 'next/image';

export const SIMULATION_DIMS = { w: 390, h: 845 };

interface PhoneMockupProps {
  src: string;
  alt: string;
  primaryColor?: string;
}

interface BrowserMockupProps {
  src: string;
  alt: string;
}

export function PhoneMockup({ src, alt, primaryColor }: PhoneMockupProps) {
  return (
    <div className="relative mx-auto w-[160px]">
      <div
        className="relative overflow-hidden rounded-[28px] border border-white/[0.1] bg-zinc-900"
        style={{ aspectRatio: '9/19.5' }}
      >
        <div className="absolute inset-0 z-10 rounded-[28px] shadow-[inset_0_0_0_1px_rgba(255,255,255,0.06)]" />

        <div className="absolute left-1/2 top-3 z-20 h-[10px] w-[60px] -translate-x-1/2 rounded-full bg-black" />

        <Image
          src={src}
          alt={alt}
          fill
          className="object-cover object-top"
          sizes="160px"
        />

        {primaryColor && (
          <div
            className="absolute bottom-0 left-0 right-0 h-24 opacity-30"
            style={{
              background: `linear-gradient(to top, ${primaryColor}, transparent)`,
            }}
          />
        )}
      </div>
    </div>
  );
}

export function BrowserMockup({ src, alt }: BrowserMockupProps) {
  return (
    <div className="relative mx-auto w-full max-w-[280px]">
      <div
        className="overflow-hidden rounded-xl border border-white/[0.1] bg-zinc-900"
        style={{ aspectRatio: '16/10' }}
      >
        <div className="flex h-7 items-center gap-1.5 border-b border-white/[0.06] bg-zinc-900 px-3">
          <span className="h-2 w-2 rounded-full bg-zinc-700" />
          <span className="h-2 w-2 rounded-full bg-zinc-700" />
          <span className="h-2 w-2 rounded-full bg-zinc-700" />
          <div className="mx-2 flex-1 rounded bg-zinc-800 px-2 py-0.5">
            <span className="text-[9px] text-zinc-600">localhost:3000</span>
          </div>
        </div>
        <div className="relative" style={{ height: 'calc(100% - 28px)' }}>
          <Image
            src={src}
            alt={alt}
            fill
            className="object-cover object-top"
            sizes="280px"
          />
        </div>
      </div>
    </div>
  );
}
