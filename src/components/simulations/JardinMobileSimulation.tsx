'use client';

// Phone internal dimensions (must match PhoneSimulationMockup)
const PW = 390;
const PH = 845;

const C = {
  bg:          '#F8FAFC',
  white:       '#FFFFFF',
  primary:     '#0F766E',
  primaryLight:'rgba(15,118,110,0.09)',
  primaryBorder:'rgba(15,118,110,0.20)',
  text:        '#0F172A',
  textMuted:   '#475569',
  textLight:   '#94A3B8',
  border:      'rgba(15,23,42,0.08)',
  borderMid:   'rgba(15,23,42,0.13)',
  success:     '#059669',
  successBg:   'rgba(5,150,105,0.09)',
  successBorder:'rgba(5,150,105,0.20)',
  danger:      '#DC2626',
  dangerBg:    'rgba(220,38,38,0.07)',
  dangerBorder:'rgba(220,38,38,0.14)',
  warning:     '#D97706',
  warningBg:   'rgba(180,83,9,0.08)',
  blue:        '#1D4ED8',
  blueBg:      'rgba(29,78,216,0.07)',
  blueBorder:  'rgba(29,78,216,0.15)',
  purple:      '#7C3AED',
  purpleBg:    'rgba(124,58,237,0.07)',
};

const STATUS_BAR_H = 44;
const HEADER_H     = 56;
const TAB_BAR_H    = 56;
const CONTENT_H    = PH - STATUS_BAR_H - HEADER_H - TAB_BAR_H;

// ——— Shared components ———

function StatusBar() {
  return (
    <div style={{
      height: STATUS_BAR_H, background: C.white,
      display: 'flex', alignItems: 'flex-end',
      justifyContent: 'space-between',
      padding: '0 20px 8px',
    }}>
      <span style={{ fontSize: 13, fontWeight: 600, color: C.text }}>9:41</span>
      <span style={{ fontSize: 11, color: C.textMuted }}>●● ◼ ▮▮▮</span>
    </div>
  );
}

interface AppHeaderProps {
  title: string;
  subtitle?: string;
  showBack?: boolean;
  showAvatar?: boolean;
}

function AppHeader({ title, subtitle, showBack, showAvatar }: AppHeaderProps) {
  return (
    <div style={{
      height: HEADER_H, background: C.white,
      borderBottom: `1px solid ${C.border}`,
      display: 'flex', alignItems: 'center',
      padding: '0 18px', gap: 10,
    }}>
      {showBack && (
        <div style={{
          width: 32, height: 32, borderRadius: 10, background: C.bg,
          border: `1px solid ${C.border}`,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          fontSize: 14, cursor: 'pointer',
        }}>←</div>
      )}
      <div style={{ flex: 1 }}>
        <p style={{ fontSize: 16, fontWeight: 700, color: C.text, margin: 0, lineHeight: 1.2 }}>{title}</p>
        {subtitle && <p style={{ fontSize: 11, color: C.textMuted, margin: 0 }}>{subtitle}</p>}
      </div>
      {showAvatar && (
        <div style={{
          width: 32, height: 32, borderRadius: 10,
          background: C.primaryLight, border: `1px solid ${C.primaryBorder}`,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          fontSize: 12, fontWeight: 700, color: C.primary,
        }}>A</div>
      )}
    </div>
  );
}

interface BottomTabBarProps {
  active: string;
}

const TABS = [
  { id: 'dashboard', icon: '🏠', label: 'Inicio' },
  { id: 'attendance', icon: '📅', label: 'Asistencia' },
  { id: 'grades',    icon: '📊', label: 'Notas' },
  { id: 'messages',  icon: '💬', label: 'Mensajes' },
];

function BottomTabBar({ active }: BottomTabBarProps) {
  return (
    <div style={{
      height: TAB_BAR_H, background: C.white,
      borderTop: `1px solid ${C.border}`,
      display: 'flex', alignItems: 'center',
    }}>
      {TABS.map((tab) => {
        const isActive = tab.id === active;
        return (
          <div key={tab.id} style={{
            flex: 1, display: 'flex', flexDirection: 'column',
            alignItems: 'center', justifyContent: 'center', gap: 3,
            cursor: 'pointer',
          }}>
            <span style={{ fontSize: 18 }}>{tab.icon}</span>
            <span style={{
              fontSize: 9, fontWeight: isActive ? 600 : 400,
              color: isActive ? C.primary : C.textLight,
            }}>{tab.label}</span>
            {isActive && (
              <div style={{
                position: 'absolute', bottom: 0,
                width: 28, height: 2, background: C.primary, borderRadius: 2,
              }} />
            )}
          </div>
        );
      })}
    </div>
  );
}

// ——— Dashboard screen ———

function DashboardScreen() {
  return (
    <>
      <AppHeader title="Hola, Andrea 👋" subtitle="Colegio San José" showAvatar />
      <div style={{ height: CONTENT_H, overflowY: 'auto', background: C.bg, padding: '16px 18px' }}>

        {/* Child card */}
        <div style={{
          background: C.primary, borderRadius: 18, padding: '18px',
          marginBottom: 14, position: 'relative', overflow: 'hidden',
        }}>
          <div style={{
            position: 'absolute', top: -30, right: -30,
            width: 120, height: 120, borderRadius: '50%',
            background: 'rgba(255,255,255,0.06)',
          }} />
          <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 12 }}>
            <div style={{
              width: 40, height: 40, borderRadius: 12, background: 'rgba(255,255,255,0.2)',
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontSize: 14, fontWeight: 700, color: '#fff',
            }}>SM</div>
            <div>
              <p style={{ fontSize: 14, fontWeight: 700, color: '#fff', margin: 0 }}>Sofía Martínez</p>
              <p style={{ fontSize: 11, color: 'rgba(255,255,255,0.65)', margin: 0 }}>Grado 2B · Jardín Los Pinos</p>
            </div>
            <span style={{
              marginLeft: 'auto', fontSize: 10, fontWeight: 600,
              color: '#fff', background: 'rgba(255,255,255,0.2)',
              borderRadius: 20, padding: '3px 9px',
            }}>ACTIVA</span>
          </div>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 8 }}>
            <div style={{ background: 'rgba(255,255,255,0.12)', borderRadius: 10, padding: '10px 12px' }}>
              <p style={{ fontSize: 18, fontWeight: 800, color: '#fff', margin: '0 0 1px' }}>✓ HOY</p>
              <p style={{ fontSize: 10, color: 'rgba(255,255,255,0.65)', margin: 0 }}>Asistencia</p>
            </div>
            <div style={{ background: 'rgba(255,255,255,0.12)', borderRadius: 10, padding: '10px 12px' }}>
              <p style={{ fontSize: 18, fontWeight: 800, color: '#fff', margin: '0 0 1px' }}>4.2</p>
              <p style={{ fontSize: 10, color: 'rgba(255,255,255,0.65)', margin: 0 }}>Promedio</p>
            </div>
          </div>
        </div>

        {/* Quick stats */}
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10, marginBottom: 14 }}>
          {[
            { icon: '📅', label: 'Asistencia', value: '18/20', sub: 'Mayo', color: C.primary, bg: C.primaryLight, border: C.primaryBorder },
            { icon: '📊', label: 'Promedio',   value: '4.2',   sub: '2do Período', color: C.blue, bg: C.blueBg, border: C.blueBorder },
            { icon: '💬', label: 'Mensajes',   value: '2',     sub: 'Sin leer', color: C.warning, bg: C.warningBg, border: 'rgba(180,83,9,0.18)' },
            { icon: '💳', label: 'Pensión',    value: 'Al día', sub: 'Mayo 2026', color: C.success, bg: C.successBg, border: C.successBorder },
          ].map((s) => (
            <div key={s.label} style={{
              background: C.white, border: `1px solid ${C.border}`,
              borderRadius: 14, padding: '12px 14px',
            }}>
              <div style={{
                width: 30, height: 30, borderRadius: 8, marginBottom: 8,
                background: s.bg, border: `1px solid ${s.border}`,
                display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 15,
              }}>
                {s.icon}
              </div>
              <p style={{ fontSize: 11, fontWeight: 700, color: s.color, margin: '0 0 2px' }}>{s.label}</p>
              <p style={{ fontSize: 16, fontWeight: 800, color: C.text, margin: '0 0 2px', lineHeight: 1 }}>{s.value}</p>
              <p style={{ fontSize: 10, color: C.textLight, margin: 0 }}>{s.sub}</p>
            </div>
          ))}
        </div>

        {/* Last message */}
        <div style={{
          background: C.white, border: `1px solid ${C.border}`,
          borderRadius: 14, padding: '14px',
        }}>
          <p style={{ fontSize: 10, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.8, margin: '0 0 10px' }}>
            Último mensaje
          </p>
          <div style={{ display: 'flex', gap: 10 }}>
            <div style={{
              width: 36, height: 36, borderRadius: 10, background: C.primaryLight,
              border: `1px solid ${C.primaryBorder}`,
              display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 17, flexShrink: 0,
            }}>📢</div>
            <div style={{ flex: 1, minWidth: 0 }}>
              <p style={{ fontSize: 11, fontWeight: 600, color: C.primary, margin: '0 0 1px' }}>Dirección Académica</p>
              <p style={{ fontSize: 12, fontWeight: 600, color: C.text, margin: '0 0 2px' }}>Jornada pedagógica — 16 de mayo</p>
              <p style={{ fontSize: 11, color: C.textMuted, margin: 0, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                El viernes 16 no hay clases por jornada docente...
              </p>
            </div>
            <p style={{ fontSize: 10, color: C.textLight, flexShrink: 0, margin: '2px 0 0' }}>2h</p>
          </div>
        </div>
      </div>
    </>
  );
}

// ——— Attendance screen ———

const ATT_DAYS = [
  { d: 1, s: 'P' }, { d: 2, s: 'P' }, { d: 3, s: 'P' }, { d: 4, s: 'P' }, { d: 5, s: 'P' },
  { d: 6, s: '-' }, { d: 7, s: '-' }, { d: 8, s: 'P' }, { d: 9, s: 'P' }, { d: 10, s: 'A' },
  { d: 11, s: 'P' }, { d: 12, s: 'P' }, { d: 13, s: 'P' }, { d: 14, s: 'P' }, { d: 15, s: 'P' },
  { d: 16, s: '-' }, { d: 17, s: '-' }, { d: 18, s: 'P' }, { d: 19, s: 'A' }, { d: 20, s: 'P' },
  { d: 21, s: 'P' }, { d: 22, s: 'P' }, { d: 23, s: 'P' }, { d: 24, s: 'P' }, { d: 25, s: 'P' },
  { d: 26, s: '-' }, { d: 27, s: '-' }, { d: 28, s: 'P' }, { d: 29, s: 'P' }, { d: 30, s: 'P' },
  { d: 31, s: '-' },
];

function AttendanceScreen() {
  return (
    <>
      <AppHeader title="Asistencia" subtitle="Sofía · Mayo 2026" showBack />
      <div style={{ height: CONTENT_H, overflowY: 'auto', background: C.bg, padding: '16px 18px' }}>

        {/* Summary */}
        <div style={{
          background: C.white, border: `1px solid ${C.border}`,
          borderRadius: 16, padding: '16px', marginBottom: 14,
        }}>
          <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 8 }}>
            <div>
              <p style={{ fontSize: 22, fontWeight: 800, color: C.primary, margin: 0 }}>18 / 20</p>
              <p style={{ fontSize: 11, color: C.textMuted, margin: '2px 0 0' }}>Días asistidos</p>
            </div>
            <div style={{ textAlign: 'right' }}>
              <p style={{ fontSize: 22, fontWeight: 800, color: C.text, margin: 0 }}>90%</p>
              <p style={{ fontSize: 11, color: C.textMuted, margin: '2px 0 0' }}>Porcentaje</p>
            </div>
          </div>
          <div style={{ height: 6, background: C.bg, borderRadius: 99, overflow: 'hidden' }}>
            <div style={{ width: '90%', height: '100%', background: C.primary, borderRadius: 99 }} />
          </div>
        </div>

        {/* Calendar grid */}
        <div style={{
          background: C.white, border: `1px solid ${C.border}`,
          borderRadius: 16, padding: '16px', marginBottom: 14,
        }}>
          <p style={{ fontSize: 11, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.8, margin: '0 0 12px' }}>
            Mayo 2026
          </p>
          <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 6 }}>
            {['L','M','X','J','V','S','D'].map((d) => (
              <span key={d} style={{ width: 36, textAlign: 'center', fontSize: 10, color: C.textLight, fontWeight: 600 }}>{d}</span>
            ))}
          </div>
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 0 }}>
            {/* Starting on Thursday (offset 3) */}
            {[...Array(3)].map((_, i) => (
              <div key={`pad-${i}`} style={{ width: 36, height: 32 }} />
            ))}
            {ATT_DAYS.map((day) => (
              <div key={day.d} style={{
                width: 36, height: 32,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                <div style={{
                  width: 26, height: 26, borderRadius: 8,
                  background: day.s === 'P' ? C.successBg : day.s === 'A' ? C.dangerBg : 'transparent',
                  border: day.s === 'P' ? `1px solid ${C.successBorder}` : day.s === 'A' ? `1px solid ${C.dangerBorder}` : 'none',
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                }}>
                  <span style={{
                    fontSize: 10, fontWeight: 600,
                    color: day.s === 'P' ? C.success : day.s === 'A' ? C.danger : C.textLight,
                  }}>{day.d}</span>
                </div>
              </div>
            ))}
          </div>
          <div style={{ display: 'flex', gap: 14, marginTop: 10, justifyContent: 'center' }}>
            {[
              { color: C.success, bg: C.successBg, label: 'Presente (18)' },
              { color: C.danger,  bg: C.dangerBg,  label: 'Ausente (2)'   },
            ].map((l) => (
              <div key={l.label} style={{ display: 'flex', alignItems: 'center', gap: 5, fontSize: 10, color: C.textMuted }}>
                <div style={{ width: 10, height: 10, borderRadius: 3, background: l.bg, border: `1px solid ${l.color}` }} />
                {l.label}
              </div>
            ))}
          </div>
        </div>

        {/* Absences */}
        <div style={{
          background: C.white, border: `1px solid ${C.border}`,
          borderRadius: 16, padding: '14px',
        }}>
          <p style={{ fontSize: 11, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.8, margin: '0 0 10px' }}>
            Ausencias (2)
          </p>
          {[
            { date: 'Viernes 10 de mayo', reason: 'Cita médica (justificada)' },
            { date: 'Lunes 19 de mayo',   reason: 'Sin justificación' },
          ].map((a) => (
            <div key={a.date} style={{
              display: 'flex', gap: 10, alignItems: 'flex-start', marginBottom: 8,
            }}>
              <div style={{
                width: 7, height: 7, borderRadius: '50%', background: C.danger,
                marginTop: 4, flexShrink: 0,
              }} />
              <div>
                <p style={{ fontSize: 12, fontWeight: 600, color: C.text, margin: '0 0 1px' }}>{a.date}</p>
                <p style={{ fontSize: 11, color: C.textMuted, margin: 0 }}>{a.reason}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </>
  );
}

// ——— Grades screen ———

function GradesScreen() {
  return (
    <>
      <AppHeader title="Calificaciones" subtitle="Sofía · 2do Período" showBack />
      <div style={{ height: CONTENT_H, overflowY: 'auto', background: C.bg, padding: '16px 18px' }}>

        {/* Period selector */}
        <div style={{ display: 'flex', gap: 6, marginBottom: 14 }}>
          {['1P', '2P', '3P', '4P'].map((p) => (
            <button key={p} style={{
              flex: 1, padding: '7px 0', borderRadius: 8,
              background: p === '2P' ? C.primary : C.white,
              color: p === '2P' ? '#fff' : C.textMuted,
              fontSize: 12, fontWeight: p === '2P' ? 600 : 400,
              cursor: 'pointer', fontFamily: 'inherit',
              border: `1px solid ${p === '2P' ? C.primary : C.border}`,
            } as React.CSSProperties}>{p}</button>
          ))}
        </div>

        {/* Average card */}
        <div style={{
          background: C.primary, borderRadius: 14, padding: '14px 16px', marginBottom: 12,
          display: 'flex', alignItems: 'center', justifyContent: 'space-between',
        }}>
          <div>
            <p style={{ fontSize: 11, color: 'rgba(255,255,255,0.65)', margin: '0 0 2px' }}>Promedio General</p>
            <p style={{ fontSize: 28, fontWeight: 800, color: '#fff', margin: 0, lineHeight: 1 }}>4.35</p>
          </div>
          <div style={{ textAlign: 'right' }}>
            <p style={{ fontSize: 11, color: 'rgba(255,255,255,0.65)', margin: '0 0 2px' }}>Puesto</p>
            <p style={{ fontSize: 22, fontWeight: 700, color: '#fff', margin: 0 }}>3 / 22</p>
          </div>
        </div>

        {/* Subject grades */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
          {[
            { subject: 'Matemáticas',       score: 4.5, color: C.blue,    bg: C.blueBg    },
            { subject: 'Español',           score: 4.3, color: C.primary, bg: C.primaryLight },
            { subject: 'Ciencias Naturales',score: 3.8, color: C.warning, bg: C.warningBg },
            { subject: 'Arte y Cultura',    score: 4.8, color: C.purple,  bg: C.purpleBg  },
            { subject: 'Ed. Física',        score: 4.6, color: C.success, bg: C.successBg },
          ].map((g) => (
            <div key={g.subject} style={{
              background: C.white, border: `1px solid ${C.border}`,
              borderRadius: 12, padding: '12px 14px',
              display: 'flex', alignItems: 'center', gap: 12,
            }}>
              <div style={{
                width: 36, height: 36, borderRadius: 10,
                background: g.bg, flexShrink: 0,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                <span style={{ fontSize: 18, fontWeight: 800, color: g.color }}>{g.score}</span>
              </div>
              <div style={{ flex: 1 }}>
                <p style={{ fontSize: 13, fontWeight: 500, color: C.text, margin: '0 0 5px' }}>
                  {g.subject}
                </p>
                <div style={{ height: 3, background: C.bg, borderRadius: 99, overflow: 'hidden' }}>
                  <div style={{ width: `${(g.score / 5) * 100}%`, height: '100%', background: g.color, borderRadius: 99 }} />
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </>
  );
}

// ——— Messages screen ———

const MESSAGES = [
  { icon: '📢', from: 'Dirección Académica', subject: 'Jornada pedagógica — 16 de mayo',   time: '2h',  read: false, color: C.primary, bg: C.primaryLight },
  { icon: '📝', from: 'Profa. Laura Vargas', subject: 'Tarea Ciencias — Ecosistemas',      time: 'Ayer', read: false, color: C.blue,    bg: C.blueBg       },
  { icon: '💳', from: 'Tesorería',           subject: 'Recordatorio — Pensión mayo',       time: '2d',  read: true,  color: C.warning, bg: C.warningBg    },
  { icon: '🎭', from: 'Coordinación',        subject: 'Acto cultural — Día de la madre',   time: '3d',  read: true,  color: C.purple,  bg: C.purpleBg     },
  { icon: '📅', from: 'Profa. Laura Vargas', subject: 'Registro de clase — Matemáticas',   time: '5d',  read: true,  color: C.primary, bg: C.primaryLight },
];

function MessagesScreen() {
  return (
    <>
      <AppHeader title="Mensajes" subtitle="Jardín Los Pinos" showBack />
      <div style={{ height: CONTENT_H, overflowY: 'auto', background: C.bg, padding: '12px 18px' }}>
        {/* Unread badge */}
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 12 }}>
          <span style={{ fontSize: 11, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.8 }}>
            Mensajes
          </span>
          <span style={{
            fontSize: 10, fontWeight: 700, color: C.white, background: C.primary,
            borderRadius: 99, padding: '2px 7px',
          }}>2 nuevos</span>
        </div>

        <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
          {MESSAGES.map((m, i) => (
            <div key={i} style={{
              background: C.white, border: `1px solid ${m.read ? C.border : C.primaryBorder}`,
              borderRadius: 14, padding: '12px 14px',
              display: 'flex', gap: 10, alignItems: 'flex-start',
              boxShadow: m.read ? 'none' : '0 0 0 3px rgba(15,118,110,0.06)',
            }}>
              <div style={{
                width: 36, height: 36, borderRadius: 10, background: m.bg,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 17, flexShrink: 0,
              }}>
                {m.icon}
              </div>
              <div style={{ flex: 1, minWidth: 0 }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 1 }}>
                  <span style={{ fontSize: 11, fontWeight: 600, color: m.color }}>{m.from}</span>
                  <span style={{ fontSize: 10, color: C.textLight, flexShrink: 0 }}>{m.time}</span>
                </div>
                <p style={{
                  fontSize: 12, fontWeight: m.read ? 400 : 600, color: C.text, margin: 0,
                  whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis',
                }}>{m.subject}</p>
              </div>
              {!m.read && (
                <div style={{
                  width: 7, height: 7, borderRadius: '50%', background: C.primary,
                  flexShrink: 0, marginTop: 6,
                }} />
              )}
            </div>
          ))}
        </div>
      </div>
    </>
  );
}

// ——— Root ———

interface JardinMobileSimulationProps {
  screen?: string;
}

export function JardinMobileSimulation({ screen = 'dashboard' }: JardinMobileSimulationProps) {
  return (
    <div style={{
      width: PW, height: PH,
      fontFamily: 'system-ui, -apple-system, "Segoe UI", sans-serif',
      background: C.bg, display: 'flex', flexDirection: 'column', overflow: 'hidden',
    }}>
      <StatusBar />
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', overflow: 'hidden' }}>
        {screen === 'dashboard'  && <DashboardScreen />}
        {screen === 'attendance' && <AttendanceScreen />}
        {screen === 'grades'     && <GradesScreen />}
        {screen === 'messages'   && <MessagesScreen />}
      </div>
      <BottomTabBar active={screen} />
    </div>
  );
}

// Suppress React.CSSProperties issue for button border override
declare module 'react' {
  interface CSSProperties {
    border?: string;
  }
}
