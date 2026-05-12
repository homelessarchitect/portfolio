'use client';

import { useState } from 'react';
import { BROWSER_W, BROWSER_H } from '@/components/ui/BrowserSimulationMockup';

const C = {
  bg: '#F8FAFC',
  white: '#FFFFFF',
  primary: '#0F766E',
  primaryLight: '#CCFBF1',
  primaryBorder: '#99F6E4',
  text: '#0F172A',
  textMuted: '#475569',
  textLight: '#94A3B8',
  border: '#E2E8F0',
  borderLight: 'rgba(15,118,110,0.15)',
  success: '#059669',
  successBg: '#ECFDF5',
  warning: '#D97706',
  warningBg: '#FFFBEB',
  blue: '#1D4ED8',
  blueBg: '#EFF6FF',
  purple: '#7C3AED',
  purpleBg: '#F5F3FF',
  amber: '#B45309',
  amberBg: '#FFFBEB',
};

type Tab = 'perfil' | 'modulos' | 'avisos';

const TABS: { id: Tab; label: string }[] = [
  { id: 'perfil', label: 'Perfil Estudiante' },
  { id: 'modulos', label: 'Módulos' },
  { id: 'avisos', label: 'Comunicaciones' },
];

// ——— Perfil ———

function PerfilContent() {
  return (
    <div style={{ display: 'flex', gap: 20, padding: '20px 28px', overflowY: 'auto', height: '100%', boxSizing: 'border-box' }}>
      {/* Left: Student card */}
      <div style={{ width: 260, flexShrink: 0 }}>
        <div style={{
          background: C.white, border: `1px solid ${C.border}`, borderRadius: 20,
          padding: 20, boxShadow: '0 2px 8px rgba(15,23,42,0.06)',
        }}>
          <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', marginBottom: 16 }}>
            <div style={{
              width: 64, height: 64, borderRadius: 20, background: C.primaryLight,
              border: `2px solid ${C.primaryBorder}`, display: 'flex',
              alignItems: 'center', justifyContent: 'center',
              fontSize: 24, fontWeight: 800, color: C.primary, marginBottom: 10,
            }}>
              S
            </div>
            <p style={{ fontSize: 16, fontWeight: 700, color: C.text, margin: '0 0 2px', textAlign: 'center' }}>
              Sara Gómez
            </p>
            <p style={{ fontSize: 12, color: C.textMuted, margin: '0 0 8px', textAlign: 'center' }}>
              1° de Primaria · Grado A
            </p>
            <span style={{
              fontSize: 10, fontWeight: 600, color: C.success, background: C.successBg,
              borderRadius: 99, padding: '3px 10px', border: `1px solid ${C.primary}30`,
            }}>
              ACTIVA
            </span>
          </div>

          {/* Attendance */}
          <div style={{ borderTop: `1px solid ${C.border}`, paddingTop: 14, marginBottom: 14 }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 6 }}>
              <p style={{ fontSize: 12, color: C.textMuted, margin: 0 }}>Asistencia</p>
              <p style={{ fontSize: 12, fontWeight: 700, color: C.primary, margin: 0 }}>92%</p>
            </div>
            <div style={{ height: 5, background: C.border, borderRadius: 99, overflow: 'hidden' }}>
              <div style={{ width: '92%', height: '100%', background: C.primary, borderRadius: 99 }} />
            </div>
          </div>

          {/* Tags */}
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6 }}>
            {['Asistencia', 'Calificaciones', 'Pagos'].map((t) => (
              <span key={t} style={{
                fontSize: 10, color: C.primary, background: C.primaryLight,
                border: `1px solid ${C.primaryBorder}`, borderRadius: 6, padding: '3px 8px',
              }}>
                {t}
              </span>
            ))}
          </div>
        </div>
      </div>

      {/* Right: Details */}
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: 14 }}>
        {/* Grades */}
        <div style={{
          background: C.white, border: `1px solid ${C.border}`, borderRadius: 16,
          padding: 18, boxShadow: '0 1px 4px rgba(15,23,42,0.04)',
        }}>
          <p style={{ fontSize: 11, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.8, margin: '0 0 12px' }}>
            Calificaciones · 2do Período
          </p>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
            {[
              { subject: 'Matemáticas', score: 4.2, color: C.blue },
              { subject: 'Español', score: 4.5, color: C.primary },
              { subject: 'Ciencias Naturales', score: 3.8, color: C.success },
              { subject: 'Arte y Cultura', score: 4.8, color: C.purple },
            ].map((g) => (
              <div key={g.subject} style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                <p style={{ flex: 1, fontSize: 13, color: C.text, margin: 0 }}>{g.subject}</p>
                <div style={{ width: 120, height: 4, background: C.border, borderRadius: 99, overflow: 'hidden' }}>
                  <div style={{ width: `${(g.score / 5) * 100}%`, height: '100%', background: g.color, borderRadius: 99 }} />
                </div>
                <p style={{ fontSize: 13, fontWeight: 700, color: g.color, margin: 0, width: 30, textAlign: 'right' }}>
                  {g.score}
                </p>
              </div>
            ))}
          </div>
        </div>

        {/* Payment */}
        <div style={{
          background: C.white, border: `1px solid ${C.border}`, borderRadius: 16,
          padding: 18, display: 'flex', justifyContent: 'space-between', alignItems: 'center',
          boxShadow: '0 1px 4px rgba(15,23,42,0.04)',
        }}>
          <div>
            <p style={{ fontSize: 11, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.8, margin: '0 0 4px' }}>
              Pensión Escolar
            </p>
            <p style={{ fontSize: 15, fontWeight: 700, color: C.text, margin: 0 }}>Mayo 2026</p>
            <p style={{ fontSize: 12, color: C.textMuted, margin: '2px 0 0' }}>Vence: 15 de mayo</p>
          </div>
          <span style={{
            fontSize: 11, fontWeight: 600, color: C.success, background: C.successBg,
            borderRadius: 8, padding: '5px 12px', border: `1px solid ${C.primary}30`,
          }}>
            AL DÍA
          </span>
        </div>
      </div>
    </div>
  );
}

// ——— Módulos ———

const MODULES = [
  { icon: '📅', label: 'Asistencia', desc: 'Control diario', color: C.primary, bg: C.primaryLight, border: C.primaryBorder },
  { icon: '📊', label: 'Calificaciones', desc: 'Notas y logros', color: C.blue, bg: C.blueBg, border: '#BFDBFE' },
  { icon: '📋', label: 'Circulares', desc: 'Comunicados', color: C.purple, bg: C.purpleBg, border: '#DDD6FE' },
  { icon: '💳', label: 'Pagos', desc: 'Pensiones y cobros', color: C.warning, bg: C.warningBg, border: '#FDE68A' },
  { icon: '👤', label: 'Perfil Escolar', desc: 'Datos del estudiante', color: C.success, bg: C.successBg, border: '#A7F3D0' },
  { icon: '💬', label: 'Comunicación', desc: 'Mensajes directos', color: C.primary, bg: C.primaryLight, border: C.primaryBorder },
];

function ModulosContent() {
  return (
    <div style={{ padding: '20px 28px', overflowY: 'auto', height: '100%', boxSizing: 'border-box' }}>
      <p style={{ fontSize: 11, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.8, margin: '0 0 16px' }}>
        Módulos disponibles
      </p>
      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 14 }}>
        {MODULES.map((m) => (
          <div key={m.label} style={{
            background: C.white, border: `1px solid ${C.border}`, borderRadius: 16,
            padding: '18px 16px', boxShadow: '0 1px 4px rgba(15,23,42,0.04)',
            cursor: 'pointer',
          }}>
            <div style={{
              width: 42, height: 42, borderRadius: 12,
              background: m.bg, border: `1px solid ${m.border}`,
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontSize: 22, marginBottom: 12,
            }}>
              {m.icon}
            </div>
            <p style={{ fontSize: 14, fontWeight: 700, color: C.text, margin: '0 0 4px' }}>{m.label}</p>
            <p style={{ fontSize: 12, color: C.textMuted, margin: 0 }}>{m.desc}</p>
          </div>
        ))}
      </div>
    </div>
  );
}

// ——— Avisos ———

const NOTICES = [
  {
    icon: '📢',
    from: 'Dirección Académica',
    subject: 'Jornada pedagógica — 16 de mayo',
    preview: 'El viernes 16 de mayo no hay clases por jornada pedagógica docente. Los estudiantes...',
    time: 'Hace 2 h',
    color: C.primary,
    bg: C.primaryLight,
  },
  {
    icon: '📝',
    from: 'Maestra Laura',
    subject: 'Tarea Ciencias — Ecosistemas',
    preview: 'Queridos padres, esta semana trabajamos ecosistemas. La tarea es un dibujo de un ecosistema...',
    time: 'Ayer',
    color: C.blue,
    bg: C.blueBg,
  },
  {
    icon: '💳',
    from: 'Tesorería',
    subject: 'Recordatorio pago de pensión',
    preview: 'Recuerde que el plazo para el pago de la pensión del mes de mayo vence el 15...',
    time: 'Hace 2 d',
    color: C.warning,
    bg: C.warningBg,
  },
  {
    icon: '🎭',
    from: 'Coordinación',
    subject: 'Acto cultural — Día de la madre',
    preview: 'Invitamos a todas las familias al acto cultural por el Día de la Madre el sábado 10 de mayo...',
    time: 'Hace 3 d',
    color: C.purple,
    bg: C.purpleBg,
  },
];

function AvisosContent() {
  return (
    <div style={{ padding: '20px 28px', overflowY: 'auto', height: '100%', boxSizing: 'border-box' }}>
      <p style={{ fontSize: 11, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.8, margin: '0 0 16px' }}>
        Comunicaciones del colegio
      </p>
      <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
        {NOTICES.map((n, i) => (
          <div key={i} style={{
            background: C.white, border: `1px solid ${C.border}`, borderRadius: 16,
            padding: '16px 18px', display: 'flex', gap: 14, alignItems: 'flex-start',
            boxShadow: '0 1px 4px rgba(15,23,42,0.04)',
          }}>
            <div style={{
              width: 40, height: 40, borderRadius: 12, background: n.bg,
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontSize: 20, flexShrink: 0,
            }}>
              {n.icon}
            </div>
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 2 }}>
                <p style={{ fontSize: 11, fontWeight: 600, color: n.color, margin: 0 }}>{n.from}</p>
                <p style={{ fontSize: 11, color: C.textLight, margin: 0, flexShrink: 0 }}>{n.time}</p>
              </div>
              <p style={{ fontSize: 13, fontWeight: 700, color: C.text, margin: '0 0 3px' }}>{n.subject}</p>
              <p style={{ fontSize: 12, color: C.textMuted, margin: 0, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                {n.preview}
              </p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

// ——— Root ———

export function JardinSimulation() {
  const [tab, setTab] = useState<Tab>('perfil');

  const NAV_H = 52;

  return (
    <div style={{
      width: BROWSER_W, height: BROWSER_H,
      fontFamily: 'system-ui, -apple-system, "Segoe UI", sans-serif',
      background: C.bg, display: 'flex', flexDirection: 'column', overflow: 'hidden',
    }}>
      {/* Top nav */}
      <div style={{
        height: NAV_H, display: 'flex', alignItems: 'center',
        justifyContent: 'space-between', padding: '0 28px',
        background: C.white, borderBottom: `1px solid ${C.border}`, flexShrink: 0,
      }}>
        {/* Brand */}
        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
          <div style={{ width: 28, height: 28, borderRadius: 8, background: C.primary, display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 16 }}>
            🌱
          </div>
          <p style={{ fontSize: 15, fontWeight: 700, color: C.text, margin: 0 }}>Jardín</p>
          <span style={{
            fontSize: 9, fontWeight: 700, color: C.primary, background: C.primaryLight,
            border: `1px solid ${C.primaryBorder}`, borderRadius: 4, padding: '2px 6px',
            textTransform: 'uppercase', letterSpacing: 0.5,
          }}>
            WIP
          </span>
        </div>

        {/* Tabs */}
        <div style={{ display: 'flex', gap: 4 }}>
          {TABS.map((t) => {
            const active = tab === t.id;
            return (
              <button
                key={t.id}
                onClick={() => setTab(t.id)}
                style={{
                  padding: '7px 14px', borderRadius: 8, border: 'none',
                  cursor: 'pointer', fontFamily: 'inherit',
                  background: active ? C.primary : 'transparent',
                  color: active ? '#fff' : C.textMuted,
                  fontSize: 13, fontWeight: active ? 600 : 500,
                  transition: 'all 0.15s',
                }}
              >
                {t.label}
              </button>
            );
          })}
        </div>

        {/* User */}
        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
          <p style={{ fontSize: 12, color: C.textMuted, margin: 0 }}>Colegio San José</p>
          <div style={{
            width: 30, height: 30, borderRadius: 8, background: C.primaryLight,
            border: `1px solid ${C.primaryBorder}`, display: 'flex',
            alignItems: 'center', justifyContent: 'center',
            fontSize: 14, fontWeight: 700, color: C.primary,
          }}>
            C
          </div>
        </div>
      </div>

      {/* Content */}
      <div style={{ flex: 1, overflow: 'hidden' }}>
        {tab === 'perfil' && <PerfilContent />}
        {tab === 'modulos' && <ModulosContent />}
        {tab === 'avisos' && <AvisosContent />}
      </div>
    </div>
  );
}
