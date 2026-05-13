'use client';

import { useState } from 'react';
import { BROWSER_W, BROWSER_H } from '@/components/ui/BrowserSimulationMockup';

const C = {
  bg: '#F8FAFC',
  bg2: '#F1F5F9',
  white: '#FFFFFF',
  primary: '#0F766E',
  primaryLight: 'rgba(15,118,110,0.08)',
  primaryBorder: 'rgba(15,118,110,0.20)',
  text: '#0F172A',
  textMuted: '#475569',
  textLight: '#94A3B8',
  border: 'rgba(15,23,42,0.07)',
  borderMid: 'rgba(15,23,42,0.13)',
  success: '#059669',
  successBg: 'rgba(5,150,105,0.08)',
  successBorder: 'rgba(5,150,105,0.18)',
  danger: '#DC2626',
  dangerBg: 'rgba(220,38,38,0.07)',
  dangerBorder: 'rgba(220,38,38,0.14)',
  warning: '#D97706',
  warningBg: 'rgba(180,83,9,0.08)',
  warningBorder: 'rgba(180,83,9,0.18)',
  blue: '#1D4ED8',
  blueBg: 'rgba(29,78,216,0.07)',
  blueBorder: 'rgba(29,78,216,0.15)',
  purple: '#7C3AED',
  purpleBg: 'rgba(124,58,237,0.07)',
  purpleBorder: 'rgba(124,58,237,0.16)',
};

const NAV_H = 52;
const CONTENT_H = BROWSER_H - NAV_H;

// ——— Asistencia ———

type AttStatus = 'present' | 'absent';

interface Student {
  id: number;
  name: string;
  initials: string;
  status: AttStatus;
}

const INITIAL_STUDENTS: Student[] = [
  { id: 1,  name: 'Ana García Pérez',    initials: 'AG', status: 'present' },
  { id: 2,  name: 'Carlos López Silva',  initials: 'CL', status: 'present' },
  { id: 3,  name: 'María Rodríguez',     initials: 'MR', status: 'absent'  },
  { id: 4,  name: 'Juan Martínez Cruz',  initials: 'JM', status: 'present' },
  { id: 5,  name: 'Sofía Hernández',     initials: 'SH', status: 'present' },
  { id: 6,  name: 'Diego Torres Mora',   initials: 'DT', status: 'absent'  },
  { id: 7,  name: 'Valentina Gómez',     initials: 'VG', status: 'present' },
  { id: 8,  name: 'Santiago Díaz',       initials: 'SD', status: 'present' },
  { id: 9,  name: 'Isabella Moreno',     initials: 'IM', status: 'present' },
  { id: 10, name: 'Mateo Jiménez R.',    initials: 'MJ', status: 'absent'  },
  { id: 11, name: 'Camila Vargas',       initials: 'CV', status: 'present' },
  { id: 12, name: 'Sebastián Castillo',  initials: 'SC', status: 'present' },
];

const CLASES = [
  { label: 'Matemáticas', room: 'Salón 2B', time: '7:00 AM',  active: true  },
  { label: 'Español',     room: 'Salón 2B', time: '8:30 AM',  active: false },
  { label: 'Ciencias',    room: 'Salón 3A', time: '10:00 AM', active: false },
  { label: 'Ed. Física',  room: 'Cancha',   time: '11:30 AM', active: false },
];

function AsistenciaContent() {
  const [students, setStudents] = useState<Student[]>(INITIAL_STUDENTS);
  const [saved, setSaved] = useState(false);

  const present = students.filter((s) => s.status === 'present').length;
  const absent  = students.filter((s) => s.status === 'absent').length;

  function toggle(id: number) {
    setSaved(false);
    setStudents((prev) =>
      prev.map((s) =>
        s.id === id ? { ...s, status: s.status === 'present' ? 'absent' : 'present' } : s
      )
    );
  }

  function save()  { setSaved(true); }
  function reset() { setStudents(INITIAL_STUDENTS); setSaved(false); }

  return (
    <div style={{ display: 'flex', height: CONTENT_H, overflow: 'hidden' }}>
      {/* Sidebar */}
      <div style={{
        width: 192, flexShrink: 0,
        borderRight: `1px solid ${C.border}`,
        background: C.white,
        display: 'flex', flexDirection: 'column',
      }}>
        <div style={{ padding: '12px 16px 8px', borderBottom: `1px solid ${C.border}` }}>
          <p style={{ fontSize: 10, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.8, margin: 0 }}>
            Clases de hoy
          </p>
        </div>
        <div style={{ flex: 1, overflowY: 'auto', padding: '8px' }}>
          {CLASES.map((cls) => (
            <div key={cls.label} style={{
              padding: '9px 12px', borderRadius: 10, marginBottom: 3,
              cursor: 'pointer',
              background: cls.active ? C.primaryLight : 'transparent',
              border: `1px solid ${cls.active ? C.primaryBorder : 'transparent'}`,
            }}>
              <p style={{ fontSize: 13, fontWeight: 600, color: cls.active ? C.primary : C.text, margin: '0 0 1px' }}>
                {cls.label}
              </p>
              <p style={{ fontSize: 11, color: C.textMuted, margin: 0 }}>{cls.room} · {cls.time}</p>
            </div>
          ))}
        </div>
      </div>

      {/* Main */}
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', overflow: 'hidden' }}>
        {/* Header */}
        <div style={{
          padding: '10px 18px', borderBottom: `1px solid ${C.border}`,
          background: C.white, flexShrink: 0,
          display: 'flex', alignItems: 'center', justifyContent: 'space-between',
        }}>
          <div>
            <p style={{ fontSize: 13, fontWeight: 700, color: C.text, margin: '0 0 1px' }}>
              Matemáticas · Salón 2B
            </p>
            <p style={{ fontSize: 11, color: C.textMuted, margin: 0 }}>Lunes 12 de mayo · Profa. Laura Vargas</p>
          </div>
          <div style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
            {[
              { val: students.length, label: 'Total',     color: C.text    },
              { val: present,         label: 'Presentes', color: C.success },
              { val: absent,          label: 'Ausentes',  color: C.danger  },
            ].map(({ val, label, color }, i) => (
              <div key={label} style={{ display: 'flex', alignItems: 'center', gap: 14 }}>
                {i > 0 && <div style={{ width: 1, height: 26, background: C.border }} />}
                <div style={{ textAlign: 'center' }}>
                  <p style={{ fontSize: 18, fontWeight: 800, color, margin: 0, lineHeight: 1 }}>{val}</p>
                  <p style={{ fontSize: 9, color: C.textLight, margin: '2px 0 0' }}>{label}</p>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Students grid */}
        <div style={{ flex: 1, overflowY: 'auto', padding: '10px 18px', background: C.bg }}>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 7 }}>
            {students.map((s) => {
              const ok = s.status === 'present';
              return (
                <button
                  key={s.id}
                  onClick={() => toggle(s.id)}
                  style={{
                    display: 'flex', alignItems: 'center', gap: 9,
                    padding: '8px 12px', borderRadius: 12, cursor: 'pointer',
                    background: C.white,
                    border: `1px solid ${ok ? C.border : C.dangerBorder}`,
                    textAlign: 'left', fontFamily: 'inherit',
                  }}
                >
                  <div style={{
                    width: 28, height: 28, borderRadius: 7, flexShrink: 0,
                    background: ok ? C.primaryLight : C.dangerBg,
                    border: `1px solid ${ok ? C.primaryBorder : C.dangerBorder}`,
                    display: 'flex', alignItems: 'center', justifyContent: 'center',
                    fontSize: 9, fontWeight: 700, color: ok ? C.primary : C.danger,
                  }}>
                    {s.initials}
                  </div>
                  <p style={{ flex: 1, fontSize: 12, fontWeight: 500, color: C.text, margin: 0 }}>
                    {s.name}
                  </p>
                  <span style={{
                    fontSize: 8, fontWeight: 700, padding: '2px 6px', borderRadius: 5, flexShrink: 0,
                    background: ok ? C.successBg : C.dangerBg,
                    color: ok ? C.success : C.danger,
                    border: `1px solid ${ok ? C.successBorder : C.dangerBorder}`,
                    letterSpacing: 0.3,
                  }}>
                    {ok ? 'PRESENTE' : 'AUSENTE'}
                  </span>
                </button>
              );
            })}
          </div>
        </div>

        {/* Footer */}
        <div style={{
          padding: '8px 18px', borderTop: `1px solid ${C.border}`,
          background: C.white, flexShrink: 0,
          display: 'flex', justifyContent: 'flex-end', alignItems: 'center', gap: 8,
        }}>
          {saved && <span style={{ fontSize: 11, color: C.success, fontWeight: 500 }}>✓ Registro guardado</span>}
          <button onClick={reset} style={{
            padding: '6px 12px', borderRadius: 7,
            border: `1px solid ${C.borderMid}`,
            background: 'transparent', color: C.textMuted,
            fontSize: 11, fontWeight: 500, cursor: 'pointer', fontFamily: 'inherit',
          }}>Reiniciar</button>
          <button onClick={save} style={{
            padding: '6px 14px', borderRadius: 7, border: 'none',
            background: saved ? C.success : C.primary,
            color: '#fff', fontSize: 11, fontWeight: 600,
            cursor: 'pointer', fontFamily: 'inherit',
          }}>
            {saved ? '✓ Guardado' : 'Guardar registro'}
          </button>
        </div>
      </div>
    </div>
  );
}

// ——— Calificaciones ———

const GRADE_STUDENTS = [
  { name: 'Ana García',       scores: [4.5, 4.3, 4.2, 4.8] },
  { name: 'Carlos López',     scores: [3.8, 4.1, 3.5, 4.6] },
  { name: 'María Rodríguez',  scores: [4.2, 4.6, 4.0, 4.5] },
  { name: 'Juan Martínez',    scores: [3.5, 3.8, 3.3, 4.2] },
  { name: 'Sofía Hernández',  scores: [4.8, 4.9, 4.7, 4.9] },
  { name: 'Diego Torres',     scores: [3.2, 3.5, 3.0, 4.0] },
  { name: 'Valentina Gómez',  scores: [4.4, 4.2, 4.5, 4.7] },
  { name: 'Santiago Díaz',    scores: [4.0, 4.3, 3.9, 4.4] },
];

const SUBJECTS = ['Matemáticas', 'Español', 'Ciencias', 'Arte'];
const SUBJECT_COLORS = [C.blue, C.primary, C.success, C.purple];

function CalificacionesContent() {
  const [period, setPeriod] = useState('2P');

  return (
    <div style={{ height: CONTENT_H, display: 'flex', flexDirection: 'column', overflow: 'hidden' }}>
      {/* Header */}
      <div style={{
        padding: '10px 20px', borderBottom: `1px solid ${C.border}`,
        background: C.white, flexShrink: 0,
        display: 'flex', alignItems: 'center', justifyContent: 'space-between',
      }}>
        <div>
          <p style={{ fontSize: 13, fontWeight: 700, color: C.text, margin: '0 0 1px' }}>Calificaciones · Salón 2B</p>
          <p style={{ fontSize: 11, color: C.textMuted, margin: 0 }}>22 estudiantes · Profa. Laura Vargas</p>
        </div>
        <div style={{ display: 'flex', gap: 4 }}>
          {['1P', '2P', '3P', '4P'].map((p) => (
            <button key={p} onClick={() => setPeriod(p)} style={{
              padding: '5px 10px', borderRadius: 7, border: 'none', cursor: 'pointer', fontFamily: 'inherit',
              background: period === p ? C.primary : 'transparent',
              color: period === p ? '#fff' : C.textMuted,
              fontSize: 12, fontWeight: period === p ? 600 : 400,
            }}>{p}</button>
          ))}
        </div>
      </div>

      {/* Table */}
      <div style={{ flex: 1, overflowY: 'auto', background: C.bg }}>
        {/* Column headers */}
        <div style={{
          display: 'grid', gridTemplateColumns: '180px repeat(4, 1fr) 80px',
          padding: '0 20px', borderBottom: `1px solid ${C.border}`,
          background: C.white, position: 'sticky', top: 0, zIndex: 1,
        }}>
          <div style={{ padding: '8px 0', fontSize: 10, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.7 }}>
            Estudiante
          </div>
          {SUBJECTS.map((s, i) => (
            <div key={s} style={{ padding: '8px 4px', fontSize: 10, fontWeight: 700, color: SUBJECT_COLORS[i], textTransform: 'uppercase', letterSpacing: 0.7, textAlign: 'center' }}>
              {s}
            </div>
          ))}
          <div style={{ padding: '8px 0', fontSize: 10, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.7, textAlign: 'center' }}>
            Prom.
          </div>
        </div>

        {/* Rows */}
        <div style={{ padding: '4px 20px' }}>
          {GRADE_STUDENTS.map((st, ri) => {
            const avg = (st.scores.reduce((a, b) => a + b, 0) / st.scores.length).toFixed(1);
            const avgNum = parseFloat(avg);
            return (
              <div key={st.name} style={{
                display: 'grid', gridTemplateColumns: '180px repeat(4, 1fr) 80px',
                borderRadius: 8, padding: '2px 0', marginBottom: 2,
                background: ri % 2 === 0 ? 'transparent' : C.white,
              }}>
                <div style={{ padding: '8px 0', display: 'flex', alignItems: 'center', gap: 8 }}>
                  <div style={{
                    width: 24, height: 24, borderRadius: 6, background: C.primaryLight,
                    border: `1px solid ${C.primaryBorder}`, flexShrink: 0,
                    display: 'flex', alignItems: 'center', justifyContent: 'center',
                    fontSize: 8, fontWeight: 700, color: C.primary,
                  }}>
                    {st.name.split(' ').map(w => w[0]).join('').slice(0, 2)}
                  </div>
                  <span style={{ fontSize: 12, color: C.text, fontWeight: 500 }}>{st.name}</span>
                </div>
                {st.scores.map((score, ci) => (
                  <div key={ci} style={{ padding: '8px 4px', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                    <span style={{
                      fontSize: 12, fontWeight: 600, padding: '2px 8px', borderRadius: 5,
                      color: score >= 4.0 ? C.success : score >= 3.5 ? C.warning : C.danger,
                      background: score >= 4.0 ? C.successBg : score >= 3.5 ? C.warningBg : C.dangerBg,
                    }}>
                      {score}
                    </span>
                  </div>
                ))}
                <div style={{ padding: '8px 0', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
                  <span style={{
                    fontSize: 12, fontWeight: 700, padding: '2px 8px', borderRadius: 5,
                    color: avgNum >= 4.0 ? C.primary : avgNum >= 3.5 ? C.warning : C.danger,
                    background: avgNum >= 4.0 ? C.primaryLight : avgNum >= 3.5 ? C.warningBg : C.dangerBg,
                    border: `1px solid ${avgNum >= 4.0 ? C.primaryBorder : avgNum >= 3.5 ? C.warningBorder : C.dangerBorder}`,
                  }}>
                    {avg}
                  </span>
                </div>
              </div>
            );
          })}
        </div>

        {/* Class average */}
        <div style={{
          margin: '8px 20px 12px', background: C.white,
          border: `1px solid ${C.borderMid}`, borderRadius: 10, padding: '10px 14px',
          display: 'flex', alignItems: 'center', justifyContent: 'space-between',
        }}>
          <span style={{ fontSize: 12, fontWeight: 600, color: C.textMuted }}>Promedio del salón</span>
          <div style={{ display: 'flex', gap: 16 }}>
            {SUBJECTS.map((s, i) => {
              const avg = (GRADE_STUDENTS.reduce((a, st) => a + st.scores[i], 0) / GRADE_STUDENTS.length).toFixed(1);
              return (
                <div key={s} style={{ textAlign: 'center' }}>
                  <p style={{ fontSize: 13, fontWeight: 700, color: SUBJECT_COLORS[i], margin: 0 }}>{avg}</p>
                  <p style={{ fontSize: 9, color: C.textLight, margin: 0 }}>{s.slice(0, 3)}</p>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    </div>
  );
}

// ——— Perfil ———

function PerfilContent() {
  return (
    <div style={{ display: 'flex', gap: 18, padding: '18px 24px', overflowY: 'auto', height: CONTENT_H, boxSizing: 'border-box' }}>
      {/* Student card */}
      <div style={{ width: 240, flexShrink: 0 }}>
        <div style={{
          background: C.white, border: `1px solid ${C.borderMid}`, borderRadius: 18,
          padding: 18, boxShadow: '0 2px 8px rgba(15,23,42,0.06)',
        }}>
          <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', marginBottom: 14 }}>
            <div style={{
              width: 56, height: 56, borderRadius: 16, background: C.primaryLight,
              border: `2px solid ${C.primaryBorder}`,
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontSize: 20, fontWeight: 800, color: C.primary, marginBottom: 9,
            }}>SM</div>
            <p style={{ fontSize: 14, fontWeight: 700, color: C.text, margin: '0 0 2px', textAlign: 'center' }}>
              Sofía Martínez
            </p>
            <p style={{ fontSize: 11, color: C.textMuted, margin: '0 0 7px', textAlign: 'center' }}>
              Grado 2B · Jardín Los Pinos
            </p>
            <span style={{
              fontSize: 9, fontWeight: 600, color: C.success, background: C.successBg,
              borderRadius: 99, padding: '2px 9px', border: `1px solid ${C.successBorder}`,
            }}>ACTIVA</span>
          </div>

          <div style={{ borderTop: `1px solid ${C.border}`, paddingTop: 12, marginBottom: 12 }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 5 }}>
              <p style={{ fontSize: 11, color: C.textMuted, margin: 0 }}>Asistencia mayo</p>
              <p style={{ fontSize: 11, fontWeight: 700, color: C.primary, margin: 0 }}>18/20</p>
            </div>
            <div style={{ height: 4, background: C.bg2, borderRadius: 99, overflow: 'hidden' }}>
              <div style={{ width: '90%', height: '100%', background: C.primary, borderRadius: 99 }} />
            </div>
          </div>

          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 5 }}>
            {['Asistencia', 'Calificaciones', 'Pagos'].map((t) => (
              <span key={t} style={{
                fontSize: 9, color: C.primary, background: C.primaryLight,
                border: `1px solid ${C.primaryBorder}`, borderRadius: 5, padding: '2px 7px',
              }}>{t}</span>
            ))}
          </div>
        </div>
      </div>

      {/* Right */}
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', gap: 12 }}>
        <div style={{
          background: C.white, border: `1px solid ${C.borderMid}`, borderRadius: 14,
          padding: 16, boxShadow: '0 1px 4px rgba(15,23,42,0.04)',
        }}>
          <p style={{ fontSize: 10, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.8, margin: '0 0 10px' }}>
            Calificaciones · 2do Período
          </p>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 7 }}>
            {[
              { subject: 'Matemáticas',       score: 4.5, color: C.blue    },
              { subject: 'Español',           score: 4.3, color: C.primary },
              { subject: 'Ciencias Nat.',     score: 3.8, color: C.warning },
              { subject: 'Arte y Cultura',    score: 4.8, color: C.purple  },
            ].map((g) => (
              <div key={g.subject} style={{ display: 'flex', alignItems: 'center', gap: 9 }}>
                <p style={{ flex: 1, fontSize: 12, color: C.text, margin: 0 }}>{g.subject}</p>
                <div style={{ width: 100, height: 3, background: C.bg2, borderRadius: 99, overflow: 'hidden' }}>
                  <div style={{ width: `${(g.score / 5) * 100}%`, height: '100%', background: g.color, borderRadius: 99 }} />
                </div>
                <p style={{ fontSize: 12, fontWeight: 700, color: g.color, margin: 0, width: 28, textAlign: 'right' }}>
                  {g.score}
                </p>
              </div>
            ))}
          </div>
        </div>

        <div style={{
          background: C.white, border: `1px solid ${C.borderMid}`, borderRadius: 14,
          padding: 16, display: 'flex', justifyContent: 'space-between', alignItems: 'center',
        }}>
          <div>
            <p style={{ fontSize: 10, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.8, margin: '0 0 3px' }}>
              Pensión Escolar
            </p>
            <p style={{ fontSize: 14, fontWeight: 700, color: C.text, margin: 0 }}>Mayo 2026</p>
            <p style={{ fontSize: 11, color: C.textMuted, margin: '1px 0 0' }}>Vence: 15 de mayo</p>
          </div>
          <span style={{
            fontSize: 10, fontWeight: 600, color: C.success, background: C.successBg,
            borderRadius: 7, padding: '4px 10px', border: `1px solid ${C.successBorder}`,
          }}>AL DÍA</span>
        </div>

        <div style={{
          background: C.white, border: `1px solid ${C.borderMid}`, borderRadius: 14, padding: 16,
        }}>
          <p style={{ fontSize: 10, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.8, margin: '0 0 9px' }}>
            Último registro de clase
          </p>
          <div style={{ display: 'flex', gap: 9 }}>
            <div style={{
              width: 32, height: 32, borderRadius: 7, background: C.blueBg,
              border: `1px solid ${C.blueBorder}`, flexShrink: 0,
              display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 15,
            }}>📝</div>
            <div>
              <p style={{ fontSize: 12, fontWeight: 600, color: C.text, margin: '0 0 1px' }}>Matemáticas — Fracciones</p>
              <p style={{ fontSize: 11, color: C.textMuted, margin: 0 }}>Logros alcanzados · ayer · Profa. Laura</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

// ——— Comunicaciones ———

const NOTICES = [
  { icon: '📢', from: 'Dirección Académica', subject: 'Jornada pedagógica — 16 de mayo', preview: 'El viernes 16 no hay clases por jornada pedagógica docente. Los estudiantes...', time: 'Hace 2 h', color: C.primary, bg: C.primaryLight },
  { icon: '📝', from: 'Profa. Laura Vargas',  subject: 'Tarea Ciencias — Ecosistemas',   preview: 'Queridos acudientes, esta semana trabajamos ecosistemas. La tarea es un dibujo...', time: 'Ayer',     color: C.blue,    bg: C.blueBg },
  { icon: '💳', from: 'Tesorería',            subject: 'Recordatorio — Pensión mayo',    preview: 'Recuerde que el plazo para el pago de la pensión del mes de mayo vence el 15...', time: 'Hace 2 d', color: C.warning, bg: C.warningBg },
  { icon: '🎭', from: 'Coordinación',         subject: 'Acto cultural — Día de la madre', preview: 'Invitamos a todas las familias al acto cultural por el Día de la Madre...', time: 'Hace 3 d', color: C.purple,  bg: C.purpleBg },
];

function ComunicacionesContent() {
  return (
    <div style={{ padding: '16px 24px', overflowY: 'auto', height: CONTENT_H, boxSizing: 'border-box' }}>
      <p style={{ fontSize: 10, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.8, margin: '0 0 12px' }}>
        Comunicaciones del colegio
      </p>
      <div style={{ display: 'flex', flexDirection: 'column', gap: 9 }}>
        {NOTICES.map((n, i) => (
          <div key={i} style={{
            background: C.white, border: `1px solid ${C.borderMid}`, borderRadius: 14,
            padding: '14px 16px', display: 'flex', gap: 12, alignItems: 'flex-start',
          }}>
            <div style={{
              width: 36, height: 36, borderRadius: 9, background: n.bg,
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontSize: 17, flexShrink: 0,
            }}>{n.icon}</div>
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 1 }}>
                <p style={{ fontSize: 10, fontWeight: 600, color: n.color, margin: 0 }}>{n.from}</p>
                <p style={{ fontSize: 10, color: C.textLight, margin: 0, flexShrink: 0 }}>{n.time}</p>
              </div>
              <p style={{ fontSize: 12, fontWeight: 700, color: C.text, margin: '0 0 2px' }}>{n.subject}</p>
              <p style={{ fontSize: 11, color: C.textMuted, margin: 0, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                {n.preview}
              </p>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

// ——— Cobros ———

const PAYMENT_ROWS = [
  { name: 'Ana García',      pension: 'Mayo 2026', amount: '$150,000', status: 'paid',    due: '15 mayo'  },
  { name: 'Carlos López',    pension: 'Mayo 2026', amount: '$150,000', status: 'pending', due: '15 mayo'  },
  { name: 'María Rodríguez', pension: 'Mayo 2026', amount: '$150,000', status: 'paid',    due: '15 mayo'  },
  { name: 'Juan Martínez',   pension: 'Abr 2026',  amount: '$150,000', status: 'overdue', due: '1 mayo'   },
  { name: 'Sofía Hernández', pension: 'Mayo 2026', amount: '$150,000', status: 'paid',    due: '15 mayo'  },
  { name: 'Diego Torres',    pension: 'Abr 2026',  amount: '$150,000', status: 'overdue', due: '1 mayo'   },
  { name: 'Valentina Gómez', pension: 'Mayo 2026', amount: '$150,000', status: 'pending', due: '15 mayo'  },
  { name: 'Santiago Díaz',   pension: 'Mayo 2026', amount: '$150,000', status: 'paid',    due: '15 mayo'  },
];

const STATUS_MAP = {
  paid:    { label: 'AL DÍA',   color: C.success, bg: C.successBg, border: C.successBorder },
  pending: { label: 'PENDIENTE', color: C.warning, bg: C.warningBg, border: C.warningBorder },
  overdue: { label: 'VENCIDO',  color: C.danger,  bg: C.dangerBg,  border: C.dangerBorder  },
};

function CobrosContent() {
  const paid    = PAYMENT_ROWS.filter((r) => r.status === 'paid').length;
  const pending = PAYMENT_ROWS.filter((r) => r.status === 'pending').length;
  const overdue = PAYMENT_ROWS.filter((r) => r.status === 'overdue').length;

  return (
    <div style={{ height: CONTENT_H, display: 'flex', flexDirection: 'column', overflow: 'hidden' }}>
      {/* Summary strip */}
      <div style={{
        display: 'flex', gap: 10, padding: '10px 20px',
        background: C.white, borderBottom: `1px solid ${C.border}`, flexShrink: 0,
      }}>
        <div style={{
          flex: 1, borderRadius: 10, padding: '10px 14px',
          background: C.successBg, border: `1px solid ${C.successBorder}`,
        }}>
          <p style={{ fontSize: 9, fontWeight: 700, color: C.success, textTransform: 'uppercase', letterSpacing: 0.7, margin: '0 0 2px' }}>Recaudado</p>
          <p style={{ fontSize: 16, fontWeight: 800, color: C.success, margin: 0 }}>$900,000</p>
          <p style={{ fontSize: 10, color: C.success, margin: '1px 0 0' }}>{paid} de {PAYMENT_ROWS.length}</p>
        </div>
        <div style={{
          flex: 1, borderRadius: 10, padding: '10px 14px',
          background: C.warningBg, border: `1px solid ${C.warningBorder}`,
        }}>
          <p style={{ fontSize: 9, fontWeight: 700, color: C.warning, textTransform: 'uppercase', letterSpacing: 0.7, margin: '0 0 2px' }}>Pendiente</p>
          <p style={{ fontSize: 16, fontWeight: 800, color: C.warning, margin: 0 }}>$300,000</p>
          <p style={{ fontSize: 10, color: C.warning, margin: '1px 0 0' }}>{pending} estudiantes</p>
        </div>
        <div style={{
          flex: 1, borderRadius: 10, padding: '10px 14px',
          background: C.dangerBg, border: `1px solid ${C.dangerBorder}`,
        }}>
          <p style={{ fontSize: 9, fontWeight: 700, color: C.danger, textTransform: 'uppercase', letterSpacing: 0.7, margin: '0 0 2px' }}>Vencido</p>
          <p style={{ fontSize: 16, fontWeight: 800, color: C.danger, margin: 0 }}>$300,000</p>
          <p style={{ fontSize: 10, color: C.danger, margin: '1px 0 0' }}>{overdue} estudiantes</p>
        </div>
      </div>

      {/* Table */}
      <div style={{ flex: 1, overflowY: 'auto', background: C.bg }}>
        {/* Header row */}
        <div style={{
          display: 'grid', gridTemplateColumns: '180px 1fr 100px 110px 90px',
          padding: '7px 20px', borderBottom: `1px solid ${C.border}`,
          background: C.white, position: 'sticky', top: 0,
        }}>
          {['Estudiante', 'Pensión', 'Monto', 'Estado', 'Vence'].map((col) => (
            <span key={col} style={{ fontSize: 9, fontWeight: 700, color: C.textLight, textTransform: 'uppercase', letterSpacing: 0.7 }}>
              {col}
            </span>
          ))}
        </div>

        {/* Data rows */}
        <div style={{ padding: '4px 20px' }}>
          {PAYMENT_ROWS.map((row, i) => {
            const s = STATUS_MAP[row.status as keyof typeof STATUS_MAP];
            return (
              <div key={i} style={{
                display: 'grid', gridTemplateColumns: '180px 1fr 100px 110px 90px',
                padding: '9px 0', borderBottom: `1px solid ${C.border}`,
                alignItems: 'center',
              }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                  <div style={{
                    width: 24, height: 24, borderRadius: 6, background: C.primaryLight,
                    border: `1px solid ${C.primaryBorder}`,
                    display: 'flex', alignItems: 'center', justifyContent: 'center',
                    fontSize: 8, fontWeight: 700, color: C.primary, flexShrink: 0,
                  }}>
                    {row.name.split(' ').map(w => w[0]).join('').slice(0, 2)}
                  </div>
                  <span style={{ fontSize: 12, color: C.text, fontWeight: 500 }}>{row.name}</span>
                </div>
                <span style={{ fontSize: 12, color: C.textMuted }}>{row.pension}</span>
                <span style={{ fontSize: 12, fontWeight: 600, color: C.text }}>{row.amount}</span>
                <span style={{
                  fontSize: 9, fontWeight: 700, padding: '2px 7px', borderRadius: 5,
                  color: s.color, background: s.bg, border: `1px solid ${s.border}`,
                  display: 'inline-block', letterSpacing: 0.3,
                }}>{s.label}</span>
                <span style={{ fontSize: 12, color: C.textMuted }}>{row.due}</span>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}

// ——— Root ———

interface JardinSimulationProps {
  screen?: string;
}

const SCREEN_LABELS: Record<string, string> = {
  asistencia:     'Asistencia',
  calificaciones: 'Calificaciones',
  perfil:         'Perfil Estudiante',
  comunicaciones: 'Comunicaciones',
  cobros:         'Cobros',
};

export function JardinSimulation({ screen = 'asistencia' }: JardinSimulationProps) {
  return (
    <div style={{
      width: BROWSER_W, height: BROWSER_H,
      fontFamily: 'system-ui, -apple-system, "Segoe UI", sans-serif',
      background: C.bg, display: 'flex', flexDirection: 'column', overflow: 'hidden',
    }}>
      {/* Top nav (no tabs — controlled externally) */}
      <div style={{
        height: NAV_H, display: 'flex', alignItems: 'center',
        justifyContent: 'space-between', padding: '0 24px',
        background: C.white, borderBottom: `1px solid ${C.border}`, flexShrink: 0,
      }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
          <div style={{
            width: 24, height: 24, borderRadius: 7, background: C.primary,
            display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 13,
          }}>🌱</div>
          <p style={{ fontSize: 13, fontWeight: 700, color: C.text, margin: 0 }}>Jardín</p>
          <span style={{ fontSize: 10, color: C.textLight, margin: '0 0 0 2px' }}>/</span>
          <p style={{ fontSize: 13, color: C.textMuted, margin: 0 }}>
            {SCREEN_LABELS[screen] ?? screen}
          </p>
        </div>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
          <p style={{ fontSize: 11, color: C.textMuted, margin: 0 }}>Colegio San José</p>
          <div style={{
            width: 26, height: 26, borderRadius: 7, background: C.primaryLight,
            border: `1px solid ${C.primaryBorder}`,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 11, fontWeight: 700, color: C.primary,
          }}>L</div>
        </div>
      </div>

      {/* Content */}
      <div style={{ flex: 1, overflow: 'hidden' }}>
        {screen === 'asistencia'     && <AsistenciaContent />}
        {screen === 'calificaciones' && <CalificacionesContent />}
        {screen === 'perfil'         && <PerfilContent />}
        {screen === 'comunicaciones' && <ComunicacionesContent />}
        {screen === 'cobros'         && <CobrosContent />}
      </div>
    </div>
  );
}
