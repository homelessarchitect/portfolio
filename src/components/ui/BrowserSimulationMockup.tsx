import type { ReactNode } from 'react';

export const BROWSER_W = 960;
export const BROWSER_H = 560;
const CHROME_H = 36;
const TOTAL_H = BROWSER_H + CHROME_H;

interface Props {
  children: ReactNode;
  displayWidth?: number;
  urlLabel?: string;
}

export function BrowserSimulationMockup({ children, displayWidth = 520, urlLabel = 'app.example.com' }: Props) {
  const scale = displayWidth / BROWSER_W;
  const displayHeight = Math.round(displayWidth * (TOTAL_H / BROWSER_W));

  return (
    <div className="relative mx-auto" style={{ width: displayWidth, height: displayHeight }}>
      <div
        style={{
          position: 'absolute',
          top: 0,
          left: 0,
          width: BROWSER_W,
          height: TOTAL_H,
          transform: `scale(${scale})`,
          transformOrigin: 'top left',
          borderRadius: 12,
          border: '1px solid rgba(255,255,255,0.08)',
          background: '#111',
          overflow: 'hidden',
        }}
      >
        {/* Browser chrome */}
        <div
          style={{
            height: CHROME_H,
            background: '#1c1c1c',
            borderBottom: '1px solid rgba(255,255,255,0.06)',
            display: 'flex',
            alignItems: 'center',
            gap: 6,
            padding: '0 12px',
            flexShrink: 0,
          }}
        >
          <div style={{ width: 10, height: 10, borderRadius: '50%', background: '#FF5F56' }} />
          <div style={{ width: 10, height: 10, borderRadius: '50%', background: '#FFBD2E' }} />
          <div style={{ width: 10, height: 10, borderRadius: '50%', background: '#27C93F' }} />
          <div
            style={{
              flex: 1,
              margin: '0 8px',
              background: 'rgba(255,255,255,0.06)',
              borderRadius: 6,
              padding: '4px 10px',
              display: 'flex',
              alignItems: 'center',
            }}
          >
            <span style={{ fontSize: 11, color: 'rgba(255,255,255,0.35)', fontFamily: 'system-ui, sans-serif' }}>
              {urlLabel}
            </span>
          </div>
        </div>

        {/* Content area */}
        <div style={{ height: BROWSER_H, overflow: 'hidden' }}>
          {children}
        </div>

        {/* Inset glass ring */}
        <div
          style={{
            position: 'absolute',
            inset: 0,
            borderRadius: 12,
            boxShadow: 'inset 0 0 0 1px rgba(255,255,255,0.04)',
            zIndex: 10,
            pointerEvents: 'none',
          }}
        />
      </div>
    </div>
  );
}
