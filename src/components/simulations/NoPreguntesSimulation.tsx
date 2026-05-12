'use client';

import { useState } from 'react';
import { SIMULATION_DIMS } from '@/components/ui/DeviceMockup';

const { w: W, h: H } = SIMULATION_DIMS;

const C = {
  bg: '#EAE6E1',
  coffee: '#6F4E37',
  coffeeLight: '#9A7559',
  gold: '#D4A853',
  text: '#2D1B0E',
  textLight: '#8B7355',
  white: '#FFFFFF',
  cardBg: '#EAE6E1',
  shadowDark: 'rgba(0,0,0,0.18)',
  shadowLight: 'rgba(255,255,255,0.85)',
  red: '#EF4444',
};

function neuCard(): React.CSSProperties {
  return {
    backgroundColor: C.cardBg,
    borderRadius: 16,
    boxShadow: `5px 5px 10px ${C.shadowDark}, -3px -3px 8px ${C.shadowLight}`,
    padding: '14px 16px',
  };
}

function neuCardInset(): React.CSSProperties {
  return {
    backgroundColor: C.cardBg,
    borderRadius: 12,
    boxShadow: `inset 3px 3px 6px ${C.shadowDark}, inset -2px -2px 5px ${C.shadowLight}`,
    padding: '10px 14px',
  };
}

function ScrollArea({ children }: { children: React.ReactNode }) {
  return (
    <div style={{ flex: 1, overflowY: 'auto', scrollbarWidth: 'none' }}>
      <style>{`.np-scroll::-webkit-scrollbar { display: none; }`}</style>
      <div className="np-scroll">{children}</div>
    </div>
  );
}

// ——— Dashboard ———

const RESERVATIONS = [
  { name: 'Carolina Mejía', phone: '310 555 0142', day: 'Sábado', price: '$85.000' },
  { name: 'Andrés Ospina', phone: '315 444 0198', day: 'Domingo', price: '$120.000' },
  { name: 'Laura Ríos', phone: '301 667 0234', day: 'Sábado', price: '$65.000' },
  { name: 'Felipe Torres', phone: '320 889 0011', day: 'Domingo', price: '$95.000' },
];

function StatCard({ title, reserved, total }: { title: string; reserved: number; total: number }) {
  const pct = total > 0 ? reserved / total : 0;
  const full = pct >= 0.9;
  return (
    <div style={{ ...neuCard(), flex: 1 }}>
      <p style={{ fontSize: 12, fontWeight: 600, color: C.textLight, margin: '0 0 8px', textAlign: 'center', fontStyle: 'italic' }}>
        {title}
      </p>
      <p style={{ fontSize: 26, fontWeight: 800, color: full ? C.red : C.coffee, margin: '0 0 10px', textAlign: 'center', fontFamily: 'inherit' }}>
        {reserved}
        <span style={{ fontSize: 14, color: C.textLight, fontWeight: 600 }}> / {total}</span>
      </p>
      <div style={{ height: 6, backgroundColor: 'rgba(255,255,255,0.7)', borderRadius: 4, overflow: 'hidden' }}>
        <div
          style={{
            width: `${Math.min(pct * 100, 100)}%`,
            height: '100%',
            backgroundColor: full ? C.red : C.coffee,
            borderRadius: 4,
            transition: 'width 0.4s ease',
          }}
        />
      </div>
    </div>
  );
}

function DashboardView() {
  return (
    <ScrollArea>
      <div style={{ padding: '16px 20px 32px' }}>
        <p style={{ fontSize: 14, fontWeight: 700, color: C.text, marginBottom: 14, fontStyle: 'italic' }}>
          Estado de Capacidad
        </p>
        <div style={{ display: 'flex', gap: 12, marginBottom: 28 }}>
          <StatCard title="Sábado" reserved={8} total={20} />
          <StatCard title="Domingo" reserved={18} total={20} />
        </div>

        <p style={{ fontSize: 14, fontWeight: 700, color: C.text, marginBottom: 14, fontStyle: 'italic' }}>
          Pedidos Recientes
        </p>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
          {RESERVATIONS.map((r, i) => (
            <div key={i} style={neuCard()}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div>
                  <p style={{ fontSize: 14, fontWeight: 700, color: C.text, margin: '0 0 3px' }}>{r.name}</p>
                  <p style={{ fontSize: 11, color: C.textLight, margin: 0 }}>
                    {r.phone} · {r.day}
                  </p>
                </div>
                <p style={{ fontSize: 14, fontWeight: 800, color: C.coffee, margin: 0 }}>{r.price}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </ScrollArea>
  );
}

// ——— Menu Editor ———

const CATEGORIES = [
  {
    name: 'Desayunos',
    price: 25000,
    products: ['Calentado especial', 'Changua con queso', 'Arepas con huevo'],
    expanded: true,
  },
  {
    name: 'Almuerzos',
    price: 35000,
    products: ['Bandeja Paisa', 'Sancocho de gallina', 'Cazuela de fríjoles'],
    expanded: false,
  },
  {
    name: 'Bebidas',
    price: 8000,
    products: ['Jugo natural', 'Limonada de coco', 'Agua de panela'],
    expanded: false,
  },
];

function MenuEditorView() {
  const [expanded, setExpanded] = useState<number | null>(0);

  return (
    <ScrollArea>
      <div style={{ padding: '16px 20px 32px' }}>
        {CATEGORIES.map((cat, i) => (
          <div key={i} style={{ ...neuCard(), marginBottom: 12 }}>
            <button
              onClick={() => setExpanded(expanded === i ? null : i)}
              style={{
                width: '100%',
                background: 'none',
                border: 'none',
                cursor: 'pointer',
                padding: 0,
                textAlign: 'left',
                fontFamily: 'inherit',
              }}
            >
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <div>
                  <p style={{ fontSize: 16, fontWeight: 700, color: C.text, margin: '0 0 2px' }}>{cat.name}</p>
                  <p style={{ fontSize: 12, color: C.textLight, margin: 0 }}>
                    Precio base: ${cat.price.toLocaleString('es-CO')}
                  </p>
                </div>
                <div style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                  <span style={{ fontSize: 18, color: C.textLight }}>🗑</span>
                  <span style={{ fontSize: 16, color: C.text, transform: expanded === i ? 'rotate(180deg)' : 'rotate(0deg)', transition: 'transform 0.2s', display: 'inline-block' }}>
                    ▾
                  </span>
                </div>
              </div>
            </button>

            {expanded === i && (
              <div style={{ marginTop: 14 }}>
                {cat.products.map((p, j) => (
                  <div
                    key={j}
                    style={{
                      display: 'flex',
                      alignItems: 'center',
                      justifyContent: 'space-between',
                      padding: '8px 0',
                      borderTop: j === 0 ? `1px solid rgba(0,0,0,0.08)` : 'none',
                    }}
                  >
                    <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                      <div style={{ width: 6, height: 6, borderRadius: '50%', backgroundColor: C.coffee, flexShrink: 0 }} />
                      <p style={{ fontSize: 13, color: C.text, margin: 0 }}>{p}</p>
                    </div>
                    <span style={{ fontSize: 16, color: C.textLight, cursor: 'pointer' }}>−</span>
                  </div>
                ))}
                <div
                  style={{
                    marginTop: 10,
                    border: `1.5px solid ${C.coffeeLight}`,
                    borderRadius: 8,
                    padding: '8px 12px',
                    display: 'flex',
                    alignItems: 'center',
                    gap: 6,
                    cursor: 'pointer',
                    color: C.coffeeLight,
                  }}
                >
                  <span style={{ fontSize: 16, fontWeight: 700 }}>+</span>
                  <p style={{ fontSize: 13, fontWeight: 600, margin: 0 }}>Añadir Producto</p>
                </div>
              </div>
            )}
          </div>
        ))}
      </div>
    </ScrollArea>
  );
}

// ——— Reservations ———

const WEEKENDS = [
  { date: 'Sáb 17 May', time: '12:00 PM', guests: 4, status: 'confirmed', name: 'Mesa Rodríguez' },
  { date: 'Sáb 17 May', time: '1:30 PM', guests: 6, status: 'pending', name: 'Familia Gómez' },
  { date: 'Dom 18 May', time: '11:30 AM', guests: 2, status: 'confirmed', name: 'Pareja Vargas' },
  { date: 'Dom 18 May', time: '12:30 PM', guests: 8, status: 'confirmed', name: 'Grupo Restrepo' },
];

const STATUS_LABEL: Record<string, string> = { confirmed: 'Confirmado', pending: 'Pendiente' };
const STATUS_COLOR: Record<string, string> = { confirmed: C.coffee, pending: C.gold };

function ReservationsView() {
  return (
    <ScrollArea>
      <div style={{ padding: '16px 20px 32px' }}>
        {WEEKENDS.map((r, i) => (
          <div key={i} style={{ ...neuCard(), marginBottom: 12 }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 6 }}>
              <p style={{ fontSize: 13, fontWeight: 700, color: C.text, margin: 0 }}>{r.name}</p>
              <span
                style={{
                  fontSize: 11,
                  fontWeight: 700,
                  color: STATUS_COLOR[r.status],
                  backgroundColor: `${STATUS_COLOR[r.status]}18`,
                  borderRadius: 100,
                  padding: '2px 8px',
                }}
              >
                {STATUS_LABEL[r.status]}
              </span>
            </div>
            <div style={{ display: 'flex', gap: 12 }}>
              <p style={{ fontSize: 12, color: C.textLight, margin: 0 }}>📅 {r.date}</p>
              <p style={{ fontSize: 12, color: C.textLight, margin: 0 }}>🕐 {r.time}</p>
              <p style={{ fontSize: 12, color: C.textLight, margin: 0 }}>👥 {r.guests} personas</p>
            </div>
          </div>
        ))}
      </div>
    </ScrollArea>
  );
}

// ——— Root component ———

type Tab = 'dashboard' | 'menu' | 'reservations';

const TABS: { id: Tab; icon: string; label: string }[] = [
  { id: 'dashboard', icon: '◈', label: 'Overview' },
  { id: 'menu', icon: '☰', label: 'Menú' },
  { id: 'reservations', icon: '📅', label: 'Pedidos' },
];

const TITLES: Record<Tab, string> = {
  dashboard: 'Overview',
  menu: 'Editar Menú',
  reservations: 'Reservaciones',
};

export function NoPreguntesSimulation() {
  const [tab, setTab] = useState<Tab>('dashboard');

  const APPBAR_H = 56;
  const TABNAV_H = 56;
  const CONTENT_H = H - APPBAR_H - TABNAV_H;

  return (
    <div
      style={{
        width: W,
        height: H,
        fontFamily: '"Playfair Display", Georgia, "Times New Roman", serif',
        backgroundColor: C.bg,
        display: 'flex',
        flexDirection: 'column',
        overflow: 'hidden',
      }}
    >
      {/* AppBar */}
      <div
        style={{
          height: APPBAR_H,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          backgroundColor: C.bg,
          borderBottom: '1px solid rgba(0,0,0,0.07)',
          flexShrink: 0,
        }}
      >
        <p style={{ fontSize: 18, fontWeight: 700, color: C.text, margin: 0 }}>{TITLES[tab]}</p>
      </div>

      {/* Content */}
      <div style={{ height: CONTENT_H, overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
        {tab === 'dashboard' && <DashboardView />}
        {tab === 'menu' && <MenuEditorView />}
        {tab === 'reservations' && <ReservationsView />}
      </div>

      {/* Bottom tab bar */}
      <div
        style={{
          height: TABNAV_H,
          display: 'flex',
          backgroundColor: 'rgba(255,255,255,0.7)',
          borderTop: '1px solid rgba(0,0,0,0.07)',
          flexShrink: 0,
          backdropFilter: 'blur(12px)',
        }}
      >
        {TABS.map((t) => (
          <button
            key={t.id}
            onClick={() => setTab(t.id)}
            style={{
              flex: 1,
              border: 'none',
              cursor: 'pointer',
              backgroundColor: 'transparent',
              color: tab === t.id ? C.coffee : C.textLight,
              fontSize: 11,
              fontWeight: tab === t.id ? 700 : 500,
              fontFamily: 'inherit',
              display: 'flex',
              flexDirection: 'column',
              alignItems: 'center',
              justifyContent: 'center',
              gap: 2,
              borderBottom: tab === t.id ? `2.5px solid ${C.coffee}` : '2.5px solid transparent',
              transition: 'all 0.15s',
              paddingBottom: 4,
            }}
          >
            <span style={{ fontSize: 18 }}>{t.icon}</span>
            <span>{t.label}</span>
          </button>
        ))}
      </div>
    </div>
  );
}
