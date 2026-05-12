'use client';

import { useState } from 'react';
import { SIMULATION_DIMS } from '@/components/ui/DeviceMockup';

const { w: W, h: H } = SIMULATION_DIMS;

const C = {
  bg: '#1A1A1A',
  card: '#262626',
  card2: '#3D3D3D',
  border: '#4D4D4D',
  primary: '#E53935',
  fg0: '#FAFAFA',
  fg1: '#CCCCCC',
  fg2: '#9E9E9E',
  fg3: '#757575',
  success: '#4CAF50',
  warning: '#FFB300',
  info: '#29B6F6',
};

function ScrollArea({ children }: { children: React.ReactNode }) {
  return (
    <div style={{ flex: 1, overflowY: 'auto', scrollbarWidth: 'none' }}>
      {children}
    </div>
  );
}

// ——— Inicio ———

function InicioView() {
  return (
    <ScrollArea>
      <div style={{ padding: '20px 16px 32px' }}>
        <p style={{ fontSize: 22, fontWeight: 800, color: C.fg0, letterSpacing: -0.55, margin: '0 0 4px' }}>
          Hola, Carlos 👋
        </p>
        <p style={{ fontSize: 13, color: C.fg2, margin: '0 0 24px' }}>
          Club Deportivo Rojo · Administrador
        </p>

        {/* Alert */}
        <div style={{
          background: `${C.primary}18`,
          border: `1px solid ${C.primary}40`,
          borderRadius: 12,
          padding: '12px 14px',
          display: 'flex',
          alignItems: 'center',
          gap: 10,
          marginBottom: 20,
        }}>
          <span style={{ fontSize: 18 }}>⚠️</span>
          <div>
            <p style={{ fontSize: 13, fontWeight: 700, color: C.primary, margin: 0 }}>3 pagos vencidos</p>
            <p style={{ fontSize: 11, color: C.fg2, margin: 0 }}>Diego L., María G., Tomás R.</p>
          </div>
        </div>

        {/* Tools grid */}
        <p style={{ fontSize: 10, fontWeight: 700, color: C.fg3, letterSpacing: 1.4, textTransform: 'uppercase', margin: '0 0 12px' }}>
          Herramientas
        </p>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 10, marginBottom: 24 }}>
          {[
            { icon: '👥', label: 'Miembros', sub: '47 activos' },
            { icon: '💳', label: 'Pagos', sub: '3 vencidos' },
            { icon: '🏃', label: 'Grupos', sub: '6 grupos' },
            { icon: '📅', label: 'Agenda', sub: '2 eventos hoy' },
          ].map((t) => (
            <div key={t.label} style={{
              background: C.card,
              border: `1px solid ${C.border}`,
              borderRadius: 16,
              padding: '14px 12px',
            }}>
              <span style={{ fontSize: 24 }}>{t.icon}</span>
              <p style={{ fontSize: 14, fontWeight: 700, color: C.fg0, margin: '8px 0 2px' }}>{t.label}</p>
              <p style={{ fontSize: 12, color: C.fg2, margin: 0 }}>{t.sub}</p>
            </div>
          ))}
        </div>

        {/* Recent activity */}
        <p style={{ fontSize: 10, fontWeight: 700, color: C.fg3, letterSpacing: 1.4, textTransform: 'uppercase', margin: '0 0 12px' }}>
          Actividad Reciente
        </p>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 8 }}>
          {[
            { icon: '✅', text: 'Pago recibido · Sergio R.', time: 'Hace 5 min', color: C.success },
            { icon: '👤', text: 'Nuevo miembro · Ana Martínez', time: 'Hace 1 h', color: C.info },
            { icon: '⚠️', text: 'Pago vencido · Diego López', time: 'Hace 3 h', color: C.warning },
            { icon: '📅', text: 'Entrenamiento Grupo A · Mañana 8am', time: 'Hace 6 h', color: C.fg2 },
          ].map((item, i) => (
            <div key={i} style={{
              background: C.card,
              border: `1px solid ${C.border}`,
              borderRadius: 12,
              padding: '12px 14px',
              display: 'flex',
              justifyContent: 'space-between',
              alignItems: 'center',
            }}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                <span style={{ fontSize: 18 }}>{item.icon}</span>
                <p style={{ fontSize: 13, color: C.fg1, margin: 0 }}>{item.text}</p>
              </div>
              <p style={{ fontSize: 11, color: C.fg3, margin: 0, flexShrink: 0, marginLeft: 8 }}>{item.time}</p>
            </div>
          ))}
        </div>
      </div>
    </ScrollArea>
  );
}

// ——— Miembros ———

const MEMBERS = [
  { name: 'Sergio Rodríguez', email: 'sergio@gmail.com', role: 'SOCIO', status: 'al día', statusColor: '#4CAF50' },
  { name: 'María González', email: 'maria@gmail.com', role: 'ATLETA', status: 'vencido', statusColor: '#E53935' },
  { name: 'Carlos Pérez', email: 'carlos@gmail.com', role: 'TUTOR', status: 'por vencer', statusColor: '#FFB300' },
  { name: 'Ana Martínez', email: 'ana@gmail.com', role: 'ATLETA', status: 'al día', statusColor: '#4CAF50' },
  { name: 'Diego López', email: 'diego@gmail.com', role: 'SOCIO', status: 'vencido', statusColor: '#E53935' },
];

function MiembrosView() {
  return (
    <>
      <div style={{ padding: '12px 16px 0' }}>
        <div style={{
          background: C.card,
          border: `1px solid ${C.border}`,
          borderRadius: 16,
          padding: '10px 14px',
          display: 'flex',
          alignItems: 'center',
          gap: 8,
        }}>
          <span style={{ fontSize: 16, color: C.fg3 }}>🔍</span>
          <span style={{ fontSize: 14, color: C.fg3 }}>Buscar miembros...</span>
        </div>
      </div>
      <ScrollArea>
        <div style={{ padding: '12px 16px 32px', display: 'flex', flexDirection: 'column', gap: 8 }}>
          {MEMBERS.map((m, i) => (
            <div key={i} style={{
              background: C.card,
              border: `1px solid ${C.border}`,
              borderRadius: 12,
              padding: '12px 14px',
              display: 'flex',
              alignItems: 'center',
              gap: 12,
            }}>
              <div style={{
                width: 42, height: 42, borderRadius: 12, background: C.card2,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                flexShrink: 0, fontSize: 16, fontWeight: 800, color: C.primary,
              }}>
                {m.name[0]}
              </div>
              <div style={{ flex: 1, minWidth: 0 }}>
                <p style={{ fontSize: 14, fontWeight: 700, color: C.fg0, margin: '0 0 2px', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                  {m.name}
                </p>
                <p style={{ fontSize: 10, fontFamily: 'monospace', color: C.fg3, margin: 0 }}>{m.email}</p>
              </div>
              <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-end', gap: 4 }}>
                <span style={{
                  fontSize: 9, fontWeight: 700, color: C.primary,
                  background: `${C.primary}20`, border: `1px solid ${C.primary}40`,
                  borderRadius: 6, padding: '2px 6px', textTransform: 'uppercase',
                }}>
                  {m.role}
                </span>
                <span style={{
                  fontSize: 9, fontWeight: 700, color: m.statusColor,
                  background: `${m.statusColor}15`, borderRadius: 6, padding: '2px 6px',
                }}>
                  {m.status}
                </span>
              </div>
            </div>
          ))}
        </div>
      </ScrollArea>
    </>
  );
}

// ——— Productos ———

const PRODUCTS = [
  { icon: '🎽', name: 'Mensualidad Básica', price: '$80.000', active: true },
  { icon: '🏋️', name: 'Clase Individual', price: '$45.000', active: true },
  { icon: '📅', name: 'Plan Semestral', price: '$420.000', active: true },
  { icon: '🎟️', name: 'Inscripción', price: '$150.000', active: false },
];

function ProductosView() {
  return (
    <ScrollArea>
      <div style={{ padding: '16px 16px 32px' }}>
        <div style={{
          display: 'flex', padding: '8px 12px',
          borderTop: `1px solid ${C.border}`, borderBottom: `1px solid ${C.border}`,
          marginBottom: 8,
        }}>
          <p style={{ flex: 1, fontSize: 10, fontFamily: 'monospace', color: C.fg3, margin: 0, textTransform: 'uppercase', letterSpacing: 1.4 }}>
            Nombre
          </p>
          <p style={{ width: 90, fontSize: 10, fontFamily: 'monospace', color: C.fg3, margin: 0, textTransform: 'uppercase', letterSpacing: 1.4, textAlign: 'right' }}>
            Precio
          </p>
          <p style={{ width: 70, fontSize: 10, fontFamily: 'monospace', color: C.fg3, margin: 0, textTransform: 'uppercase', letterSpacing: 1.4, textAlign: 'right' }}>
            Estado
          </p>
        </div>
        {PRODUCTS.map((p, i) => (
          <div key={i} style={{
            display: 'flex', alignItems: 'center',
            padding: '12px', background: C.card,
            border: `1px solid ${C.border}`, borderRadius: 12, marginBottom: 8,
          }}>
            <div style={{
              width: 36, height: 36, borderRadius: 8,
              background: `${C.primary}20`, display: 'flex', alignItems: 'center',
              justifyContent: 'center', marginRight: 12, flexShrink: 0, fontSize: 18,
            }}>
              {p.icon}
            </div>
            <p style={{ flex: 1, fontSize: 14, fontWeight: 600, color: C.fg0, margin: 0 }}>{p.name}</p>
            <p style={{ width: 90, fontSize: 14, fontWeight: 700, color: C.fg1, margin: 0, textAlign: 'right' }}>{p.price}</p>
            <div style={{ width: 70, display: 'flex', justifyContent: 'flex-end' }}>
              <span style={{
                fontSize: 9, fontWeight: 700,
                color: p.active ? C.success : C.fg3,
                background: p.active ? `${C.success}15` : `${C.fg3}15`,
                borderRadius: 6, padding: '3px 7px',
              }}>
                {p.active ? 'ACTIVO' : 'INACTIVO'}
              </span>
            </div>
          </div>
        ))}
        <div style={{
          border: `1.5px dashed ${C.border}`, borderRadius: 12,
          padding: '14px 16px', display: 'flex', alignItems: 'center', gap: 8,
        }}>
          <span style={{ fontSize: 20, color: C.fg3 }}>+</span>
          <p style={{ fontSize: 14, color: C.fg3, margin: 0 }}>Nuevo producto o plan</p>
        </div>
      </div>
    </ScrollArea>
  );
}

// ——— Root ———

type Tab = 'inicio' | 'miembros' | 'productos';

const TABS: { id: Tab; icon: string; label: string }[] = [
  { id: 'inicio', icon: '⌂', label: 'Inicio' },
  { id: 'miembros', icon: '👥', label: 'Miembros' },
  { id: 'productos', icon: '⊞', label: 'Productos' },
];

const TITLES: Record<Tab, string> = {
  inicio: 'ARCINUS',
  miembros: 'MIEMBROS',
  productos: 'PRODUCTOS',
};

export function ArcinusSimulation() {
  const [tab, setTab] = useState<Tab>('inicio');

  const APPBAR_H = 56;
  const TABNAV_H = 60;
  const CONTENT_H = H - APPBAR_H - TABNAV_H;

  return (
    <div style={{
      width: W, height: H,
      fontFamily: '"Inter", system-ui, sans-serif',
      backgroundColor: C.bg,
      display: 'flex', flexDirection: 'column', overflow: 'hidden',
    }}>
      {/* AppBar */}
      <div style={{
        height: APPBAR_H, display: 'flex', alignItems: 'center',
        justifyContent: 'space-between', padding: '0 20px',
        backgroundColor: C.bg, borderBottom: `1px solid ${C.border}`, flexShrink: 0,
      }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
          <div style={{ width: 28, height: 28, borderRadius: 8, background: C.primary, display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
            <span style={{ fontSize: 14, color: '#fff' }}>◈</span>
          </div>
          <p style={{ fontSize: 16, fontWeight: 800, color: C.fg0, margin: 0, letterSpacing: -0.3 }}>
            {TITLES[tab]}
          </p>
        </div>
        <div style={{
          width: 32, height: 32, borderRadius: 10, background: C.card2,
          display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: 16,
        }}>
          🔔
        </div>
      </div>

      {/* Content */}
      <div style={{ height: CONTENT_H, overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
        {tab === 'inicio' && <InicioView />}
        {tab === 'miembros' && <MiembrosView />}
        {tab === 'productos' && <ProductosView />}
      </div>

      {/* Tab bar */}
      <div style={{
        height: TABNAV_H, display: 'flex',
        backgroundColor: C.card, borderTop: `1px solid ${C.border}`, flexShrink: 0,
      }}>
        {TABS.map((t) => (
          <button
            key={t.id}
            onClick={() => setTab(t.id)}
            style={{
              flex: 1, border: 'none', cursor: 'pointer', backgroundColor: 'transparent',
              color: tab === t.id ? C.primary : C.fg2,
              fontSize: 11, fontWeight: tab === t.id ? 700 : 500, fontFamily: 'inherit',
              display: 'flex', flexDirection: 'column', alignItems: 'center',
              justifyContent: 'center', gap: 3, paddingBottom: 4,
              borderBottom: tab === t.id ? `2.5px solid ${C.primary}` : '2.5px solid transparent',
              transition: 'all 0.15s',
            }}
          >
            <span style={{ fontSize: 20 }}>{t.icon}</span>
            <span>{t.label}</span>
          </button>
        ))}
      </div>
    </div>
  );
}
