import type { ReactNode } from 'react';

const INTERNAL_W = 390;
const INTERNAL_H = Math.round(INTERNAL_W * (19.5 / 9)); // 845

interface Props {
  children: ReactNode;
  primaryColor?: string;
  displayWidth?: number;
}

/**
 * Renders the simulation at internal (390×845) coords and scales the
 * entire phone frame down via transform: scale.  overflow:hidden therefore
 * clips at internal height — the tab bar is never cut off.
 * CSS transform correctly maps pointer events through the scale matrix, so
 * interactions inside the simulation work without any JS zoom hacks.
 */
export function PhoneSimulationMockup({ children, primaryColor, displayWidth = 280 }: Props) {
  const scale = displayWidth / INTERNAL_W;
  const displayHeight = Math.round(displayWidth * (19.5 / 9));

  return (
    <div className="relative mx-auto" style={{ width: displayWidth, height: displayHeight }}>
      {/* phone frame at INTERNAL size, scaled to display size */}
      <div
        style={{
          position: 'absolute',
          top: 0,
          left: 0,
          width: INTERNAL_W,
          height: INTERNAL_H,
          transform: `scale(${scale})`,
          transformOrigin: 'top left',
          borderRadius: 44,
          border: '4px solid rgba(255,255,255,0.08)',
          background: '#111',
          overflow: 'hidden',
        }}
      >
        {/* dynamic island — at internal scale */}
        <div
          style={{
            position: 'absolute',
            width: 100,
            height: 28,
            top: 10,
            left: '50%',
            transform: 'translateX(-50%)',
            borderRadius: 14,
            background: 'black',
            zIndex: 20,
            pointerEvents: 'none',
          }}
        />

        {/* simulation content */}
        {children}

        {/* inset glass ring */}
        <div
          style={{
            position: 'absolute',
            inset: 0,
            borderRadius: 44,
            boxShadow: 'inset 0 0 0 1px rgba(255,255,255,0.05)',
            zIndex: 10,
            pointerEvents: 'none',
          }}
        />

        {primaryColor && (
          <div
            style={{
              position: 'absolute',
              bottom: 0,
              left: 0,
              right: 0,
              height: 80,
              background: `linear-gradient(to top, ${primaryColor}50, transparent)`,
              zIndex: 5,
              pointerEvents: 'none',
            }}
          />
        )}
      </div>
    </div>
  );
}
