'use client';

import { BROWSER_W, BROWSER_H } from '@/components/ui/BrowserSimulationMockup';

// Jardín design tokens (light mode)
const T = {
  bg:          '#FFFFFF',
  bg2:         '#F8FAFC',
  bgAlt:       '#F1F5F9',
  surface:     '#FFFFFF',
  line:        'rgba(15,23,42,0.07)',
  line2:       'rgba(15,23,42,0.13)',
  text:        '#0F172A',
  text2:       '#475569',
  text3:       '#94A3B8',
  accent:      '#0F766E',
  accentSoft:  'rgba(15,118,110,0.08)',
  accentLine:  'rgba(15,118,110,0.20)',
  ok:          '#059669',
  okSoft:      'rgba(5,150,105,0.09)',
  okLine:      'rgba(5,150,105,0.20)',
  amber:       '#B45309',
  amberSoft:   'rgba(180,83,9,0.08)',
  blue:        '#1D4ED8',
  blueSoft:    'rgba(29,78,216,0.07)',
  blueLine:    'rgba(29,78,216,0.15)',
  purple:      '#7C3AED',
  purpleSoft:  'rgba(124,58,237,0.07)',
  purpleLine:  'rgba(124,58,237,0.16)',
  teal:        '#0D9488',
  tealSoft:    'rgba(13,148,136,0.08)',
  tealLine:    'rgba(13,148,136,0.18)',
  green:       '#059669',
  greenSoft:   'rgba(5,150,105,0.08)',
  greenLine:   'rgba(5,150,105,0.18)',
};

const NAV_H = 52;
const CONTENT_H = BROWSER_H - NAV_H;

// ——— Nav ———

function LandingNav() {
  return (
    <div style={{
      height: NAV_H, background: T.bg,
      borderBottom: `1px solid ${T.line}`,
      display: 'flex', alignItems: 'center',
      justifyContent: 'space-between',
      padding: '0 40px', flexShrink: 0,
    }}>
      <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
        <div style={{
          width: 28, height: 28, borderRadius: 8,
          background: T.accent,
          display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 15,
        }}>🌱</div>
        <span style={{ fontSize: 15, fontWeight: 700, color: T.text }}>Jardín</span>
      </div>

      <div style={{ display: 'flex', gap: 24 }}>
        {['Funcionalidades', 'Modelos', 'Contacto'].map((label) => (
          <span key={label} style={{ fontSize: 13, color: T.text2, cursor: 'pointer' }}>
            {label}
          </span>
        ))}
      </div>

      <button style={{
        padding: '7px 16px', borderRadius: 8, border: 'none',
        background: T.accent, color: '#fff',
        fontSize: 13, fontWeight: 600, cursor: 'pointer', fontFamily: 'inherit',
      }}>
        Quiero enterarme →
      </button>
    </div>
  );
}

// ——— Hero section ———

function StudentMockupCard() {
  return (
    <div style={{
      background: T.surface,
      border: `1px solid ${T.line2}`,
      borderRadius: 20,
      boxShadow: '0 4px 8px rgba(15,23,42,0.07), 0 12px 32px rgba(15,23,42,0.08)',
      overflow: 'hidden',
      width: '100%',
    }}>
      {/* Student header */}
      <div style={{
        padding: '16px 20px',
        background: T.bg2,
        borderBottom: `1px solid ${T.line}`,
        display: 'flex', alignItems: 'center', gap: 10,
      }}>
        <div style={{
          width: 36, height: 36, borderRadius: '50%',
          background: T.accentSoft, border: `1px solid ${T.accentLine}`,
          color: T.accent, fontSize: 11, fontWeight: 700,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          flexShrink: 0, letterSpacing: '0.04em',
        }}>SM</div>
        <div style={{ flex: 1, minWidth: 0 }}>
          <p style={{ fontSize: 13, fontWeight: 600, color: T.text, margin: '0 0 1px' }}>
            Sofía Martínez
          </p>
          <p style={{ fontSize: 11, color: T.text3, margin: 0 }}>
            Grado 2B · Jardín Los Pinos
          </p>
        </div>
        <span style={{
          fontSize: 10, fontWeight: 500, color: T.ok,
          background: T.okSoft,
          border: `1px solid ${T.okLine}`,
          padding: '2px 8px', borderRadius: 20,
        }}>Activa</span>
      </div>

      {/* Module 1: Asistencia */}
      <div style={{ padding: '12px 20px', borderBottom: `1px solid ${T.line}` }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 8 }}>
          <span style={{ fontSize: 13 }}>📅</span>
          <span style={{ fontSize: 11, fontWeight: 500, color: T.text2, flex: 1 }}>
            Asistencia — Mayo
          </span>
          <span style={{ fontSize: 11, fontWeight: 600, color: T.text }}>18 / 20</span>
        </div>
        <div style={{ height: 4, background: T.bgAlt, borderRadius: 10, overflow: 'hidden' }}>
          <div style={{ width: '90%', height: '100%', background: T.accent, borderRadius: 10 }} />
        </div>
      </div>

      {/* Module 2: Calificaciones */}
      <div style={{ padding: '12px 20px', borderBottom: `1px solid ${T.line}` }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 8 }}>
          <span style={{ fontSize: 13 }}>📝</span>
          <span style={{ fontSize: 11, fontWeight: 500, color: T.text2, flex: 1 }}>
            Calificaciones
          </span>
          <span style={{ fontSize: 11, fontWeight: 600, color: T.text }}>Prom. 4.2</span>
        </div>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 4 }}>
          {[
            { label: 'Matemáticas', score: 4.5, good: true },
            { label: 'Español',     score: 4.3, good: true },
            { label: 'Ciencias',    score: 3.8, good: false },
          ].map((g) => (
            <div key={g.label} style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
              <span style={{ fontSize: 11, color: T.text2 }}>{g.label}</span>
              <span style={{
                fontSize: 11, fontWeight: 600, padding: '1px 6px', borderRadius: 4,
                color: g.good ? T.ok : T.amber,
                background: g.good ? T.okSoft : T.amberSoft,
              }}>{g.score}</span>
            </div>
          ))}
        </div>
      </div>

      {/* Module 3: Pills */}
      <div style={{ padding: '12px 20px', display: 'flex', flexDirection: 'column', gap: 6 }}>
        <div style={{
          display: 'flex', alignItems: 'center', gap: 6, fontSize: 11,
          color: T.text2, background: T.bg2, border: `1px solid ${T.line}`,
          borderRadius: 8, padding: '6px 10px',
        }}>
          <span>💬</span>
          <span>Último aviso a acudiente: <strong style={{ color: T.text, fontWeight: 500 }}>hace 1 día</strong></span>
        </div>
        <div style={{
          display: 'flex', alignItems: 'center', gap: 6, fontSize: 11,
          color: '#065F46', background: T.okSoft, border: `1px solid ${T.okLine}`,
          borderRadius: 8, padding: '6px 10px',
        }}>
          <span>✓</span>
          <span>Pensión mayo — <strong style={{ fontWeight: 500 }}>Pagada</strong></span>
        </div>
      </div>
    </div>
  );
}

function HeroSection() {
  return (
    <div style={{
      height: CONTENT_H, background: T.bg,
      display: 'flex', alignItems: 'center',
      padding: '0 40px',
      position: 'relative', overflow: 'hidden',
    }}>
      {/* Background radial glow */}
      <div style={{
        position: 'absolute', top: -120, right: -60,
        width: 500, height: 500, borderRadius: '50%',
        background: 'radial-gradient(circle, rgba(15,118,110,0.06) 0%, transparent 60%)',
        pointerEvents: 'none',
      }} />

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 56, alignItems: 'center', width: '100%' }}>
        {/* Left: Copy */}
        <div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 7, marginBottom: 18 }}>
            <div style={{
              width: 7, height: 7, borderRadius: '50%', background: T.teal,
              boxShadow: `0 0 0 4px rgba(13,148,136,0.15)`,
            }} />
            <span style={{ fontSize: 11, letterSpacing: '0.10em', textTransform: 'uppercase', color: T.text3 }}>
              Validando mercado · Bogotá
            </span>
          </div>

          <h1 style={{
            fontSize: 36, fontWeight: 500, letterSpacing: '-0.03em', lineHeight: 1.08,
            color: T.text, margin: '0 0 14px',
          }}>
            Asistencia, notas,<br />
            comunicación y cobros.<br />
            <span style={{ color: T.accent, fontWeight: 400 }}>Todo en un solo sistema.</span>
          </h1>

          <p style={{ fontSize: 13, lineHeight: 1.65, color: T.text2, maxWidth: 400, margin: '0 0 18px' }}>
            El sistema operativo para jardines y colegios que unifica todo lo que hoy está repartido entre cuadernos, Excel y grupos de WhatsApp.
          </p>

          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6, marginBottom: 22 }}>
            {['Asistencia', 'Calificaciones', 'Registro de clases', 'Comunicación', 'Cobros'].map((tag) => (
              <span key={tag} style={{
                fontSize: 11, fontWeight: 500, padding: '4px 9px', borderRadius: 6,
                background: T.bg2, border: `1px solid ${T.line2}`, color: T.text2,
              }}>{tag}</span>
            ))}
          </div>

          <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
            <button style={{
              alignSelf: 'flex-start', padding: '10px 20px', borderRadius: 10, border: 'none',
              background: T.accent, color: '#fff',
              fontSize: 13, fontWeight: 600, cursor: 'pointer', fontFamily: 'inherit',
            }}>
              Quiero enterarme primero
            </button>
            <span style={{ fontSize: 11, color: T.text3, letterSpacing: '0.04em' }}>
              Gratis durante la validación &nbsp;·&nbsp; Sin compromiso
            </span>
          </div>
        </div>

        {/* Right: Mockup */}
        <div style={{ position: 'relative' }}>
          <StudentMockupCard />
          {/* Floating notification */}
          <div style={{
            position: 'absolute', bottom: -10, right: -10,
            background: T.surface, border: `1px solid ${T.line2}`,
            borderRadius: 12, padding: '8px 12px',
            display: 'flex', alignItems: 'center', gap: 8,
            boxShadow: '0 2px 4px rgba(15,23,42,0.06), 0 4px 16px rgba(15,23,42,0.06)',
          }}>
            <span style={{ fontSize: 16 }}>📋</span>
            <div>
              <p style={{ fontSize: 11, fontWeight: 600, color: T.text, margin: '0 0 1px' }}>
                Registro de clase guardado
              </p>
              <p style={{ fontSize: 10, color: T.text3, margin: 0 }}>
                Matemáticas · Salón 2B · ahora
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

// ——— Features section ———

interface Feature {
  icon: string;
  title: string;
  body: string;
  variant: string;
  badge?: string;
}

const FEATURES: Feature[] = [
  { icon: '👥', title: 'Registro de asistencia', body: 'Pasá lista por salón en segundos. Histórico por estudiante y alertas automáticas para acudientes.', variant: 'accent' },
  { icon: '📄', title: 'Seguimiento de calificaciones', body: 'Notas por período, boletines automáticos y alertas de bajo rendimiento para intervenir a tiempo.', variant: 'blue' },
  { icon: '📚', title: 'Registro de clases', body: 'El docente registra qué se trabajó: logros, actividades, observaciones. Todo queda en el historial.', variant: 'purple' },
  { icon: '💬', title: 'Comunicación con acudientes', body: 'Circulares y mensajes por curso, nivel o institución. Sin grupos de WhatsApp que nadie controla.', variant: 'teal' },
  { icon: '💼', title: 'Perfil completo del estudiante', body: 'Matrícula, historial académico, contactos y documentos. Todo accesible en segundos.', variant: 'green' },
  { icon: '💰', title: 'Cobros y pensiones', body: 'Solo privados. Registro de pagos, recordatorios automáticos y reportes financieros.', variant: 'amber', badge: 'Solo privados' },
];

const VARIANT_COLORS: Record<string, { color: string; bg: string; border: string }> = {
  accent: { color: T.accent,  bg: T.accentSoft, border: T.accentLine },
  blue:   { color: T.blue,    bg: T.blueSoft,   border: T.blueLine   },
  purple: { color: T.purple,  bg: T.purpleSoft, border: T.purpleLine },
  teal:   { color: T.teal,    bg: T.tealSoft,   border: T.tealLine   },
  green:  { color: T.green,   bg: T.greenSoft,  border: T.greenLine  },
  amber:  { color: T.amber,   bg: T.amberSoft,  border: 'rgba(180,83,9,0.18)' },
};

function FeaturesSection() {
  return (
    <div style={{
      height: CONTENT_H, background: T.bg2,
      borderTop: `1px solid ${T.line}`,
      padding: '28px 40px', overflowY: 'auto',
    }}>
      <div style={{ marginBottom: 20 }}>
        <p style={{ fontSize: 10, letterSpacing: '0.14em', textTransform: 'uppercase', color: T.text3, margin: '0 0 6px' }}>
          02 · Módulos
        </p>
        <h2 style={{ fontSize: 24, fontWeight: 500, letterSpacing: '-0.03em', color: T.text, margin: '0 0 6px' }}>
          Todo lo que necesita <span style={{ fontWeight: 400, color: T.accent }}>tu institución educativa.</span>
        </h2>
        <p style={{ fontSize: 13, lineHeight: 1.65, color: T.text2, maxWidth: 500, margin: 0 }}>
          Seis módulos integrados que reemplazan las planillas, WhatsApp y los cuadernos de notas.
        </p>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 10 }}>
        {FEATURES.map((f) => {
          const c = VARIANT_COLORS[f.variant];
          return (
            <div key={f.title} style={{
              background: T.surface, border: `1px solid ${T.line}`,
              borderRadius: 16, padding: '16px',
              boxShadow: '0 1px 2px rgba(15,23,42,0.06)',
            }}>
              <div style={{ display: 'flex', alignItems: 'flex-start', justifyContent: 'space-between', marginBottom: 10 }}>
                <div style={{
                  width: 36, height: 36, borderRadius: 10,
                  background: c.bg, border: `1px solid ${c.border}`,
                  display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 18,
                }}>
                  {f.icon}
                </div>
                {f.badge && (
                  <span style={{
                    fontSize: 9, fontWeight: 600, letterSpacing: '0.06em', textTransform: 'uppercase',
                    color: c.color, background: c.bg, border: `1px solid ${c.border}`,
                    padding: '2px 7px', borderRadius: 4,
                  }}>{f.badge}</span>
                )}
              </div>
              <p style={{ fontSize: 13, fontWeight: 600, color: T.text, margin: '0 0 5px', lineHeight: 1.3 }}>
                {f.title}
              </p>
              <p style={{ fontSize: 11, lineHeight: 1.6, color: T.text2, margin: 0 }}>
                {f.body}
              </p>
            </div>
          );
        })}
      </div>
    </div>
  );
}

// ——— Schools section ———

const SHARED_FEATURES = [
  'Registro de asistencia diario',
  'Seguimiento de calificaciones',
  'Registro de clases y logros',
  'Comunicación con acudientes',
  'Perfil completo del estudiante',
  'Historial académico',
];

const PRIVATE_FEATURES = [
  'Cobro de pensiones y matrículas',
  'Recordatorios automáticos de pago',
  'Reportes financieros',
  'Cierre de mes sin planillas',
];

function SchoolsSection() {
  return (
    <div style={{
      height: CONTENT_H, background: T.bg,
      borderTop: `1px solid ${T.line}`,
      padding: '28px 40px', overflowY: 'auto',
    }}>
      <div style={{ marginBottom: 20 }}>
        <p style={{ fontSize: 10, letterSpacing: '0.14em', textTransform: 'uppercase', color: T.text3, margin: '0 0 6px' }}>
          03 · Modelos
        </p>
        <h2 style={{ fontSize: 24, fontWeight: 500, letterSpacing: '-0.03em', color: T.text, margin: 0 }}>
          Para instituciones <span style={{ fontWeight: 400, color: T.accent }}>públicas y privadas.</span>
        </h2>
      </div>

      <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 16, maxWidth: 800 }}>
        {/* Público */}
        <div style={{
          background: T.surface, border: `1px solid ${T.line2}`,
          borderRadius: 20, padding: 22,
          boxShadow: '0 1px 2px rgba(15,23,42,0.06)',
        }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 16 }}>
            <span style={{ fontSize: 22 }}>🏫</span>
            <div>
              <p style={{ fontSize: 14, fontWeight: 600, color: T.text, margin: '0 0 1px' }}>Institución pública</p>
              <p style={{ fontSize: 11, color: T.text3, margin: 0 }}>Colegios y jardines distritales</p>
            </div>
          </div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
            {SHARED_FEATURES.map((f) => (
              <div key={f} style={{ display: 'flex', alignItems: 'baseline', gap: 8, fontSize: 12, color: T.text2 }}>
                <span style={{ fontSize: 11, fontWeight: 700, color: T.ok, width: 14 }}>✓</span>
                <span>{f}</span>
              </div>
            ))}
            {PRIVATE_FEATURES.map((f) => (
              <div key={f} style={{ display: 'flex', alignItems: 'baseline', gap: 8, fontSize: 12, color: T.text3 }}>
                <span style={{ fontSize: 11, color: T.text3, width: 14 }}>—</span>
                <span>{f}</span>
              </div>
            ))}
          </div>
        </div>

        {/* Privado */}
        <div style={{
          background: T.surface,
          border: `1px solid ${T.accentLine}`,
          borderRadius: 20, padding: 22, position: 'relative',
          boxShadow: `0 2px 4px rgba(15,23,42,0.06), 0 0 0 1px ${T.accentLine}`,
        }}>
          <span style={{
            position: 'absolute', top: -12, left: 20,
            fontSize: 10, fontWeight: 600, letterSpacing: '0.06em', textTransform: 'uppercase',
            color: T.accent, background: T.surface, border: `1px solid ${T.accentLine}`,
            padding: '2px 10px', borderRadius: 20,
          }}>Incluye cobros</span>

          <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 16 }}>
            <span style={{ fontSize: 22 }}>🏛️</span>
            <div>
              <p style={{ fontSize: 14, fontWeight: 600, color: T.text, margin: '0 0 1px' }}>Institución privada</p>
              <p style={{ fontSize: 11, color: T.text3, margin: 0 }}>Jardines y colegios de pago</p>
            </div>
          </div>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
            {SHARED_FEATURES.map((f) => (
              <div key={f} style={{ display: 'flex', alignItems: 'baseline', gap: 8, fontSize: 12, color: T.text2 }}>
                <span style={{ fontSize: 11, fontWeight: 700, color: T.ok, width: 14 }}>✓</span>
                <span>{f}</span>
              </div>
            ))}
            {PRIVATE_FEATURES.map((f) => (
              <div key={f} style={{ display: 'flex', alignItems: 'baseline', gap: 8, fontSize: 12, color: T.text }}>
                <span style={{ fontSize: 11, fontWeight: 700, color: T.accent, width: 14 }}>✓</span>
                <span>{f}</span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}

// ——— CTA section ———

function CtaSection() {
  return (
    <div style={{
      height: CONTENT_H, background: T.bg,
      borderTop: `1px solid ${T.line}`,
      display: 'flex', alignItems: 'center', justifyContent: 'center',
      padding: '0 40px',
    }}>
      <div style={{ textAlign: 'center', maxWidth: 560 }}>
        <div style={{
          width: 52, height: 52, borderRadius: 16, background: T.accentSoft,
          border: `1px solid ${T.accentLine}`,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          fontSize: 26, margin: '0 auto 20px',
        }}>🌱</div>

        <h2 style={{
          fontSize: 32, fontWeight: 500, letterSpacing: '-0.03em',
          lineHeight: 1.1, color: T.text, margin: '0 0 12px',
        }}>
          Sé de los primeros<br />
          <span style={{ color: T.accent, fontWeight: 400 }}>en conocerlo.</span>
        </h2>

        <p style={{ fontSize: 14, lineHeight: 1.7, color: T.text2, margin: '0 0 28px' }}>
          Estamos validando el mercado en Bogotá. Registrate para ser notificado cuando abramos acceso y obtener condiciones especiales durante el lanzamiento.
        </p>

        <div style={{ display: 'flex', gap: 10, justifyContent: 'center' }}>
          <input
            readOnly
            placeholder="tu@correo.com"
            style={{
              padding: '10px 16px', borderRadius: 10, border: `1px solid ${T.line2}`,
              background: T.bg2, color: T.text2, fontSize: 13,
              outline: 'none', fontFamily: 'inherit', width: 220,
            }}
          />
          <button style={{
            padding: '10px 20px', borderRadius: 10, border: 'none',
            background: T.accent, color: '#fff', fontSize: 13, fontWeight: 600,
            cursor: 'pointer', fontFamily: 'inherit',
          }}>
            Anotarme
          </button>
        </div>

        <p style={{ fontSize: 11, color: T.text3, marginTop: 12, letterSpacing: '0.04em' }}>
          Gratis durante la validación &nbsp;·&nbsp; Sin compromiso &nbsp;·&nbsp; Sin spam
        </p>
      </div>
    </div>
  );
}

// ——— Root ———

interface JardinLandingSimulationProps {
  screen?: string;
}

export function JardinLandingSimulation({ screen = 'hero' }: JardinLandingSimulationProps) {
  return (
    <div style={{
      width: BROWSER_W, height: BROWSER_H,
      fontFamily: 'system-ui, -apple-system, "Segoe UI", sans-serif',
      background: T.bg, display: 'flex', flexDirection: 'column', overflow: 'hidden',
    }}>
      <LandingNav />
      <div style={{ flex: 1, overflow: 'hidden' }}>
        {screen === 'hero'     && <HeroSection />}
        {screen === 'features' && <FeaturesSection />}
        {screen === 'schools'  && <SchoolsSection />}
        {screen === 'cta'      && <CtaSection />}
      </div>
    </div>
  );
}
