'use client';

import { SIMULATION_DIMS } from '@/components/ui/DeviceMockup';

const { w: W, h: H } = SIMULATION_DIMS;

const C = {
  bg: '#EAE6E1',
  coffee: '#3E2723',      // real AppTheme.primaryCoffee
  coffeeMid: '#6F4E37',   // mid-tone for accents
  gold: '#D4AF37',        // real AppTheme.accentGold
  cream: '#F5F0E6',       // real AppTheme.secondaryCream
  text: '#2C2C2C',        // real AppTheme.textDark
  textLight: '#757575',   // real AppTheme.textLight
  white: '#FFFFFF',
  red: '#EF4444',
};

function neuCard(): React.CSSProperties {
  return {
    backgroundColor: C.bg,
    borderRadius: 20,
    boxShadow: `6px 6px 12px rgba(0,0,0,0.13), -4px -4px 10px rgba(255,255,255,0.85)`,
    padding: '14px 16px',
  };
}

function Scroll({ children }: { children: React.ReactNode }) {
  return (
    <div style={{ flex: 1, overflowY: 'auto', scrollbarWidth: 'none' }}>
      {children}
    </div>
  );
}

// ——— DashboardView ———

const ORDERS = [
  { name: 'Carolina Mejía', phone: '310 555 0142', day: 'Sábado', price: '$85.000' },
  { name: 'Andrés Ospina',  phone: '315 444 0198', day: 'Domingo', price: '$120.000' },
  { name: 'Laura Ríos',     phone: '301 667 0234', day: 'Sábado', price: '$65.000' },
  { name: 'Felipe Torres',  phone: '320 889 0011', day: 'Domingo', price: '$95.000' },
];

function StatCard({ title, reserved, total }: { title: string; reserved: number; total: number }) {
  const pct = total > 0 ? reserved / total : 0;
  const full = pct >= 0.9;
  return (
    <div style={{ ...neuCard(), flex: 1 }}>
      <p style={{ fontSize: 12, fontWeight: 600, color: C.textLight, margin: '0 0 6px', textAlign: 'center', fontStyle: 'italic' }}>
        {title}
      </p>
      <p style={{ fontSize: 28, fontWeight: 800, color: full ? C.red : C.coffee, margin: '0 0 10px', textAlign: 'center' }}>
        {reserved}<span style={{ fontSize: 14, color: C.textLight, fontWeight: 600 }}> / {total}</span>
      </p>
      <div style={{ height: 6, backgroundColor: 'rgba(255,255,255,0.7)', borderRadius: 4, overflow: 'hidden' }}>
        <div style={{ width: `${Math.min(pct * 100, 100)}%`, height: '100%', backgroundColor: full ? C.red : C.coffee, borderRadius: 4 }} />
      </div>
    </div>
  );
}

function DashboardView() {
  return (
    <Scroll>
      <div style={{ padding: '16px 20px 32px' }}>
        <p style={{ fontSize: 14, fontWeight: 700, color: C.text, marginBottom: 14, fontStyle: 'italic' }}>Estado de Capacidad</p>
        <div style={{ display: 'flex', gap: 12, marginBottom: 28 }}>
          <StatCard title="Sábado" reserved={8} total={20} />
          <StatCard title="Domingo" reserved={18} total={20} />
        </div>

        <p style={{ fontSize: 14, fontWeight: 700, color: C.text, marginBottom: 14, fontStyle: 'italic' }}>Pedidos Recientes</p>
        <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
          {ORDERS.map((r, i) => (
            <div key={i} style={neuCard()}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div>
                  <p style={{ fontSize: 14, fontWeight: 700, color: C.text, margin: '0 0 3px' }}>{r.name}</p>
                  <p style={{ fontSize: 11, color: C.textLight, margin: 0 }}>{r.phone} · {r.day}</p>
                </div>
                <p style={{ fontSize: 14, fontWeight: 800, color: C.coffee, margin: 0 }}>{r.price}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </Scroll>
  );
}

// ——— ReservasView ———

interface Reservation {
  name: string; date: string; time: string; guests: number;
  status: 'confirmed' | 'pending'; price: string;
}

const RESERVATIONS: Reservation[] = [
  { name: 'Mesa Rodríguez', date: 'Sáb 17 May', time: '12:00 PM', guests: 4, status: 'confirmed', price: '$85.000' },
  { name: 'Familia Gómez', date: 'Sáb 17 May', time: '1:30 PM', guests: 6, status: 'pending', price: '$120.000' },
  { name: 'Pareja Vargas', date: 'Dom 18 May', time: '11:30 AM', guests: 2, status: 'confirmed', price: '$65.000' },
  { name: 'Grupo Restrepo', date: 'Dom 18 May', time: '12:30 PM', guests: 8, status: 'confirmed', price: '$190.000' },
  { name: 'Carolina Mejía', date: 'Sáb 24 May', time: '1:00 PM', guests: 3, status: 'pending', price: '$75.000' },
];

function ReservasView() {
  const tabs = ['Pendientes', 'Completadas'];
  const days = ['Todas', 'Sábado', 'Domingo'];
  return (
    <>
      {/* Tabs */}
      <div style={{ display: 'flex', borderBottom: `1px solid rgba(0,0,0,0.07)`, flexShrink: 0 }}>
        {tabs.map((t, i) => (
          <div key={t} style={{
            flex: 1, textAlign: 'center' as const, padding: '10px 0',
            fontSize: 13, fontWeight: i === 0 ? 700 : 500,
            color: i === 0 ? C.coffee : C.textLight,
            borderBottom: i === 0 ? `2.5px solid ${C.coffee}` : '2.5px solid transparent',
            cursor: 'pointer',
          }}>
            {t}
          </div>
        ))}
      </div>
      {/* Day filters */}
      <div style={{ display: 'flex', gap: 8, padding: '10px 20px 4px', flexShrink: 0 }}>
        {days.map((d, i) => (
          <div key={d} style={{
            flex: 1, textAlign: 'center' as const, padding: '6px 0',
            fontSize: 12, fontWeight: 600,
            borderRadius: 8,
            backgroundColor: i === 0 ? C.coffee : 'transparent',
            color: i === 0 ? C.white : C.textLight,
            border: `1px solid ${i === 0 ? C.coffee : 'rgba(0,0,0,0.12)'}`,
            cursor: 'pointer',
          }}>
            {d}
          </div>
        ))}
      </div>
      {/* List */}
      <Scroll>
        <div style={{ padding: '8px 20px 32px', display: 'flex', flexDirection: 'column', gap: 10 }}>
          {RESERVATIONS.map((r, i) => (
            <div key={i} style={neuCard()}>
              <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 6 }}>
                <p style={{ fontSize: 14, fontWeight: 700, color: C.text, margin: 0 }}>{r.name}</p>
                <span style={{
                  fontSize: 11, fontWeight: 700,
                  color: r.status === 'confirmed' ? C.coffee : C.gold,
                  backgroundColor: r.status === 'confirmed' ? `${C.coffee}15` : `${C.gold}20`,
                  borderRadius: 100, padding: '2px 9px',
                }}>
                  {r.status === 'confirmed' ? 'Confirmado' : 'Pendiente'}
                </span>
              </div>
              <div style={{ display: 'flex', gap: 14, alignItems: 'center' }}>
                <p style={{ fontSize: 11, color: C.textLight, margin: 0 }}>📅 {r.date}</p>
                <p style={{ fontSize: 11, color: C.textLight, margin: 0 }}>🕐 {r.time}</p>
                <p style={{ fontSize: 11, color: C.textLight, margin: 0 }}>👥 {r.guests}</p>
                <p style={{ fontSize: 13, fontWeight: 700, color: C.coffeeMid, margin: '0 0 0 auto' }}>{r.price}</p>
              </div>
            </div>
          ))}
        </div>
      </Scroll>
    </>
  );
}

// ——— ClientesView ———

interface Customer { name: string; phone: string; orders: number; lastOrder: string; spent: string; }

const CUSTOMERS: Customer[] = [
  { name: 'Carolina Mejía', phone: '310 555 0142', orders: 7, lastOrder: 'Sáb 10 May', spent: '$595.000' },
  { name: 'Andrés Ospina', phone: '315 444 0198', orders: 4, lastOrder: 'Dom 11 May', spent: '$480.000' },
  { name: 'Laura Ríos', phone: '301 667 0234', orders: 12, lastOrder: 'Sáb 17 May', spent: '$780.000' },
  { name: 'Felipe Torres', phone: '320 889 0011', orders: 3, lastOrder: 'Dom 4 May', spent: '$285.000' },
  { name: 'Manuela Castro', phone: '313 220 0456', orders: 9, lastOrder: 'Sáb 17 May', spent: '$855.000' },
  { name: 'Diego Herrera', phone: '317 331 0789', orders: 2, lastOrder: 'Dom 27 Abr', spent: '$150.000' },
];

function ClientesView() {
  return (
    <Scroll>
      <div style={{ padding: '12px 20px 32px' }}>
        {/* Search */}
        <div style={{
          ...neuCard(),
          display: 'flex', alignItems: 'center', gap: 8,
          padding: '10px 14px', marginBottom: 16,
        }}>
          <span style={{ fontSize: 14, color: C.textLight }}>⌕</span>
          <span style={{ fontSize: 13, color: C.textLight, fontStyle: 'italic' }}>Buscar cliente...</span>
        </div>

        {/* Customer list */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
          {CUSTOMERS.map((c, i) => (
            <div key={i} style={neuCard()}>
              <div style={{ display: 'flex', alignItems: 'center', gap: 12 }}>
                {/* Avatar */}
                <div style={{
                  width: 44, height: 44, borderRadius: 12,
                  backgroundColor: `${C.coffee}18`,
                  border: `1.5px solid ${C.coffee}30`,
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  flexShrink: 0, fontSize: 16, fontWeight: 800, color: C.coffee,
                }}>
                  {c.name[0]}
                </div>
                {/* Info */}
                <div style={{ flex: 1, minWidth: 0 }}>
                  <p style={{ margin: '0 0 2px', fontSize: 14, fontWeight: 700, color: C.text }}>{c.name}</p>
                  <p style={{ margin: 0, fontSize: 11, color: C.textLight }}>{c.phone}</p>
                </div>
                {/* Stats */}
                <div style={{ textAlign: 'right' as const, flexShrink: 0 }}>
                  <p style={{ margin: '0 0 2px', fontSize: 13, fontWeight: 700, color: C.coffee }}>{c.spent}</p>
                  <p style={{ margin: 0, fontSize: 10, color: C.textLight }}>{c.orders} pedidos</p>
                </div>
              </div>
              <div style={{ marginTop: 8, paddingTop: 8, borderTop: '1px solid rgba(0,0,0,0.06)', display: 'flex', justifyContent: 'space-between' }}>
                <p style={{ margin: 0, fontSize: 11, color: C.textLight, fontStyle: 'italic' }}>Último: {c.lastOrder}</p>
                <span style={{ fontSize: 14, color: C.coffeeMid }}>›</span>
              </div>
            </div>
          ))}
        </div>
      </div>
    </Scroll>
  );
}

// ——— MenuView ———

interface Category { name: string; price: number; products: string[]; }

const CATEGORIES: Category[] = [
  { name: 'Desayunos', price: 25000, products: ['Calentado especial', 'Changua con queso', 'Arepas con huevo'] },
  { name: 'Almuerzos', price: 35000, products: ['Bandeja Paisa', 'Sancocho de gallina', 'Cazuela de fríjoles'] },
  { name: 'Bebidas', price: 8000, products: ['Jugo natural', 'Limonada de coco', 'Agua de panela'] },
];

function MenuView() {
  return (
    <Scroll>
      <div style={{ padding: '12px 20px 32px' }}>
        {CATEGORIES.map((cat, i) => (
          <div key={i} style={{ ...neuCard(), marginBottom: 14 }}>
            {/* Header */}
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
              <div>
                <p style={{ margin: 0, fontSize: 16, fontWeight: 700, color: C.text }}>{cat.name}</p>
                <p style={{ margin: '2px 0 0', fontSize: 12, color: C.textLight, fontStyle: 'italic' }}>
                  Precio base: ${cat.price.toLocaleString('es-CO')}
                </p>
              </div>
              <div style={{ display: 'flex', gap: 10 }}>
                <span style={{ fontSize: 16, color: C.textLight }}>🗑</span>
                <span style={{ fontSize: 16, color: C.text }}>▾</span>
              </div>
            </div>
            {/* Products */}
            <div style={{ borderTop: '1px solid rgba(0,0,0,0.07)', paddingTop: 10 }}>
              {cat.products.map((p, j) => (
                <div key={j} style={{
                  display: 'flex', alignItems: 'center', justifyContent: 'space-between',
                  padding: '7px 0',
                  borderBottom: j < cat.products.length - 1 ? '1px solid rgba(0,0,0,0.05)' : 'none',
                }}>
                  <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                    <div style={{ width: 6, height: 6, borderRadius: '50%', backgroundColor: C.coffeeMid, flexShrink: 0 }} />
                    <p style={{ margin: 0, fontSize: 13, color: C.text }}>{p}</p>
                  </div>
                  <span style={{ fontSize: 16, color: C.textLight, cursor: 'pointer' }}>−</span>
                </div>
              ))}
              {/* Add product */}
              <div style={{
                marginTop: 10, display: 'flex', alignItems: 'center', gap: 6,
                border: `1.5px solid ${C.coffeeMid}`, borderRadius: 8,
                padding: '7px 12px', cursor: 'pointer', color: C.coffeeMid,
              }}>
                <span style={{ fontSize: 16, fontWeight: 700 }}>+</span>
                <p style={{ margin: 0, fontSize: 13, fontWeight: 600 }}>Añadir Producto</p>
              </div>
            </div>
          </div>
        ))}
      </div>
    </Scroll>
  );
}

// ——— Root ———

type TabId = 'dashboard' | 'reservas' | 'clientes' | 'menu';

interface TabDef { id: TabId; icon: string; label: string; }

const TABS: TabDef[] = [
  { id: 'dashboard', icon: '◈', label: 'Overview' },
  { id: 'reservas',  icon: '📅', label: 'Reservas' },
  { id: 'clientes',  icon: '◉', label: 'Clientes' },
  { id: 'menu',      icon: '☰', label: 'Menú' },
];

const TITLES: Record<TabId, string> = {
  dashboard: 'Overview',
  reservas:  'Reservas',
  clientes:  'Clientes',
  menu:      'Editar Menú',
};

const APP_H = 56;
const TAB_H = 60;

export function NoPreguntesSimulation({ screen }: { screen?: string }) {
  const active = (screen ?? 'dashboard') as TabId;

  return (
    <div style={{
      width: W, height: H,
      fontFamily: '"Playfair Display", Georgia, "Times New Roman", serif',
      backgroundColor: C.bg,
      display: 'flex', flexDirection: 'column', overflow: 'hidden',
    }}>
      {/* AppBar */}
      <div style={{
        height: APP_H, flexShrink: 0,
        display: 'flex', alignItems: 'center', justifyContent: 'center',
        backgroundColor: C.bg, borderBottom: '1px solid rgba(0,0,0,0.07)',
      }}>
        <p style={{ fontSize: 18, fontWeight: 700, color: C.text, margin: 0 }}>
          {TITLES[active] ?? 'No Preguntes'}
        </p>
      </div>

      {/* Content */}
      <div style={{ flex: 1, overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
        {active === 'dashboard' && <DashboardView />}
        {active === 'reservas'  && <ReservasView />}
        {active === 'clientes'  && <ClientesView />}
        {active === 'menu'      && <MenuView />}
      </div>

      {/* Tab bar */}
      <div style={{
        height: TAB_H, flexShrink: 0,
        display: 'flex',
        backgroundColor: 'rgba(255,255,255,0.7)',
        borderTop: '1px solid rgba(0,0,0,0.07)',
        backdropFilter: 'blur(12px)',
      }}>
        {TABS.map((t) => {
          const isActive = t.id === active;
          return (
            <div key={t.id} style={{
              flex: 1,
              display: 'flex', flexDirection: 'column',
              alignItems: 'center', justifyContent: 'center',
              gap: 2, paddingBottom: 4,
              color: isActive ? C.coffee : C.textLight,
              fontSize: 10, fontWeight: isActive ? 700 : 500,
              borderBottom: isActive ? `2.5px solid ${C.coffee}` : '2.5px solid transparent',
            }}>
              <span style={{ fontSize: 18 }}>{t.icon}</span>
              <span style={{ fontFamily: '"Inter", system-ui, sans-serif' }}>{t.label}</span>
            </div>
          );
        })}
      </div>
    </div>
  );
}
