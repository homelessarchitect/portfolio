'use client';

import { SIMULATION_DIMS } from '@/components/ui/DeviceMockup';

const { w: W, h: H } = SIMULATION_DIMS;

const C = {
  bg: '#E8E8E8',
  black: '#000000',
  white: '#FFFFFF',
  orange: '#E84C1C',
  blue: '#3B82F6',
  purple: '#8B5CF6',
  green: '#22C55E',
  teal: '#14B8A6',
  indigo: '#6366F1',
  amber: '#F59E0B',
  muted: 'rgba(0,0,0,0.54)',
  mutedDark: 'rgba(255,255,255,0.5)',
  error: '#EF4444',
};

function card(bg = C.white): React.CSSProperties {
  return {
    backgroundColor: bg,
    border: `2px solid ${C.black}`,
    boxShadow: `4px 4px 0 ${C.black}`,
    borderRadius: 0,
  };
}

function Scroll({ children }: { children: React.ReactNode }) {
  return (
    <div style={{ flex: 1, overflowY: 'auto', scrollbarWidth: 'none' }}>
      {children}
    </div>
  );
}

// ——— VentasView ———

interface Sale {
  client: string;
  products: string;
  total: string;
  date: string;
  status: 'PAGADA' | 'CRÉDITO' | 'PARCIAL';
}

const STATUS_COLOR: Record<string, string> = {
  PAGADA: C.green,
  CRÉDITO: C.blue,
  PARCIAL: C.amber,
};

const SALES: Sale[] = [
  { client: 'CONSTRUCTORA EL PINO', products: 'Arena fina 15m³ + Triturado 3/4 8m³', total: '$1.091.000', date: '12 may', status: 'PAGADA' },
  { client: 'OBRAS CIVILES REYES', products: 'Arena gruesa 20m³', total: '$840.000', date: '11 may', status: 'CRÉDITO' },
  { client: 'FINCA LA ESPERANZA', products: 'Gravilla 10m³ + Arena fina 5m³', total: '$622.000', date: '10 may', status: 'PARCIAL' },
  { client: 'INMOBILIARIA DEL NORTE', products: 'Triturado 3/4 30m³', total: '$1.560.000', date: '09 may', status: 'PAGADA' },
  { client: 'TALLER MÉNDEZ E HIJOS', products: 'Arena gruesa 8m³', total: '$336.000', date: '08 may', status: 'CRÉDITO' },
];

function VentasView() {
  const tabs = ['TODAS', 'PAGADAS', 'CRÉDITO', 'PARCIAL'];
  return (
    <>
      {/* Status tabs */}
      <div style={{
        display: 'flex', borderBottom: `2px solid ${C.black}`,
        overflowX: 'auto', scrollbarWidth: 'none', flexShrink: 0,
      }}>
        {tabs.map((t, i) => (
          <div key={t} style={{
            padding: '10px 16px', flexShrink: 0,
            fontSize: 12, fontWeight: 900, letterSpacing: 0.5,
            color: i === 0 ? C.black : C.muted,
            borderBottom: i === 0 ? `4px solid ${C.orange}` : '4px solid transparent',
            cursor: 'pointer',
          }}>
            {t}
          </div>
        ))}
      </div>
      {/* Search */}
      <div style={{ padding: '12px 16px 8px', flexShrink: 0 }}>
        <div style={{
          ...card(C.white),
          boxShadow: 'none',
          display: 'flex', alignItems: 'center', gap: 8,
          padding: '10px 14px',
        }}>
          <span style={{ fontSize: 14, color: C.muted }}>⌕</span>
          <span style={{ fontSize: 13, fontWeight: 700, color: C.muted }}>BUSCAR POR CLIENTE...</span>
        </div>
      </div>
      {/* List */}
      <Scroll>
        <div style={{ padding: '4px 16px 32px', display: 'flex', flexDirection: 'column', gap: 10 }}>
          {SALES.map((s, i) => {
            const sc = STATUS_COLOR[s.status];
            return (
              <div key={i} style={{ ...card(), padding: '14px 16px' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 6 }}>
                  <p style={{ margin: 0, fontSize: 13, fontWeight: 900, color: C.black, flex: 1, paddingRight: 8 }}>
                    {s.client}
                  </p>
                  <span style={{
                    fontSize: 9, fontWeight: 900, color: sc,
                    border: `2px solid ${sc}`, padding: '2px 6px',
                    flexShrink: 0, letterSpacing: 0.5,
                  }}>
                    {s.status}
                  </span>
                </div>
                <p style={{ margin: '0 0 8px', fontSize: 11, color: C.muted }}>{s.products}</p>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderTop: `1px solid ${C.black}`, paddingTop: 8 }}>
                  <span style={{ fontSize: 11, fontWeight: 700, color: C.muted }}>{s.date}</span>
                  <span style={{ fontSize: 16, fontWeight: 900, color: C.orange }}>{s.total}</span>
                </div>
              </div>
            );
          })}
        </div>
      </Scroll>
    </>
  );
}

// ——— ClientesView ———

interface Client { name: string; detail: string; balance: string; inDebt: boolean; }

const CLIENTS: Client[] = [
  { name: 'CONSTRUCTORA EL PINO S.A.S', detail: 'NIT 900.123.456', balance: '$0', inDebt: false },
  { name: 'OBRAS CIVILES REYES', detail: 'NIT 800.987.321', balance: '-$840.000', inDebt: true },
  { name: 'FINCA LA ESPERANZA', detail: 'Manizales · Persona natural', balance: '-$311.000', inDebt: true },
  { name: 'INMOBILIARIA DEL NORTE', detail: 'NIT 901.456.789', balance: '$0', inDebt: false },
  { name: 'TALLER MÉNDEZ E HIJOS', detail: 'NIT 820.654.987', balance: '-$336.000', inDebt: true },
  { name: 'CONCRETOS ARAUCA LTDA', detail: 'NIT 830.111.222', balance: '$0', inDebt: false },
];

function ClientesView() {
  return (
    <>
      {/* Search */}
      <div style={{ padding: '12px 16px 8px', flexShrink: 0 }}>
        <div style={{
          ...card(C.white),
          boxShadow: 'none',
          display: 'flex', alignItems: 'center', gap: 8,
          padding: '10px 14px',
        }}>
          <span style={{ fontSize: 14, color: C.muted }}>⌕</span>
          <span style={{ fontSize: 13, fontWeight: 700, color: C.muted }}>BUSCAR POR NOMBRE O NIT...</span>
        </div>
      </div>
      {/* List */}
      <Scroll>
        <div style={{ padding: '4px 16px 32px', display: 'flex', flexDirection: 'column', gap: 10 }}>
          {CLIENTS.map((c, i) => (
            <div key={i} style={{
              ...card(),
              display: 'flex', alignItems: 'center',
              padding: '14px 16px', gap: 12,
            }}>
              {/* Icon */}
              <div style={{
                width: 44, height: 44, flexShrink: 0,
                backgroundColor: C.orange, border: `2px solid ${C.black}`,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 18, fontWeight: 900, color: C.white,
              }}>
                {c.name[0]}
              </div>
              {/* Info */}
              <div style={{ flex: 1, minWidth: 0 }}>
                <p style={{ margin: '0 0 2px', fontSize: 13, fontWeight: 900, color: C.black, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                  {c.name}
                </p>
                <p style={{ margin: 0, fontSize: 11, fontWeight: 600, color: C.muted }}>{c.detail}</p>
              </div>
              {/* Balance */}
              <div style={{ textAlign: 'right' as const, flexShrink: 0 }}>
                <p style={{ margin: 0, fontSize: 13, fontWeight: 900, color: c.inDebt ? C.error : C.green }}>
                  {c.balance}
                </p>
                <span style={{ fontSize: 14, color: C.black }}>›</span>
              </div>
            </div>
          ))}
        </div>
      </Scroll>
    </>
  );
}

// ——— CajaView ———

interface Transaction { desc: string; detail: string; amount: string; date: string; isIncome: boolean; }

const TRANSACTIONS: Transaction[] = [
  { desc: 'CONSTRUCTORA EL PINO', detail: 'Venta #1048 · Arena fina', amount: '+$1.091.000', date: 'hoy', isIncome: true },
  { desc: 'INMOBILIARIA DEL NORTE', detail: 'Venta #1047 · Triturado', amount: '+$1.560.000', date: 'ayer', isIncome: true },
  { desc: 'COMBUSTIBLE VOLQUETA', detail: 'Gasto operacional', amount: '-$280.000', date: '10 may', isIncome: false },
  { desc: 'FINCA LA ESPERANZA', detail: 'Abono venta #1045', amount: '+$311.000', date: '10 may', isIncome: true },
  { desc: 'MANTENIMIENTO PLANTA', detail: 'Gasto operacional', amount: '-$150.000', date: '09 may', isIncome: false },
];

function CajaView() {
  return (
    <Scroll>
      <div style={{ padding: '16px 16px 32px' }}>
        {/* Summary cards */}
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: 10, marginBottom: 24 }}>
          {[
            { label: 'INGRESOS', value: '$4.073.000', color: C.green },
            { label: 'EGRESOS', value: '$430.000', color: C.error },
            { label: 'NETO', value: '$3.643.000', color: C.orange },
          ].map((stat) => (
            <div key={stat.label} style={{ ...card(), padding: '12px 10px' }}>
              <p style={{ margin: '0 0 6px', fontSize: 9, fontWeight: 900, letterSpacing: 1, color: C.muted }}>{stat.label}</p>
              <p style={{ margin: 0, fontSize: 15, fontWeight: 900, color: stat.color, letterSpacing: -0.5 }}>
                {stat.value}
              </p>
            </div>
          ))}
        </div>

        {/* Section header */}
        <p style={{ fontSize: 13, fontWeight: 900, letterSpacing: 1.5, color: C.muted, margin: '0 0 12px' }}>
          TRANSACCIONES
        </p>

        {/* Transaction list */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: 10 }}>
          {TRANSACTIONS.map((t, i) => (
            <div key={i} style={{
              ...card(),
              display: 'flex', alignItems: 'center', gap: 12,
              padding: '12px 14px',
            }}>
              {/* Type icon */}
              <div style={{
                width: 40, height: 40, flexShrink: 0,
                backgroundColor: t.isIncome ? C.green : C.error,
                border: `2px solid ${C.black}`,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 16, fontWeight: 900, color: C.white,
              }}>
                {t.isIncome ? '+' : '−'}
              </div>
              {/* Description */}
              <div style={{ flex: 1, minWidth: 0 }}>
                <p style={{ margin: '0 0 2px', fontSize: 12, fontWeight: 900, color: C.black, whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
                  {t.desc}
                </p>
                <p style={{ margin: 0, fontSize: 11, color: C.muted }}>{t.detail}</p>
              </div>
              {/* Amount */}
              <div style={{ textAlign: 'right' as const, flexShrink: 0 }}>
                <p style={{ margin: 0, fontSize: 13, fontWeight: 900, color: t.isIncome ? C.green : C.error }}>{t.amount}</p>
                <p style={{ margin: 0, fontSize: 10, fontWeight: 600, color: C.muted }}>{t.date}</p>
              </div>
            </div>
          ))}
        </div>
      </div>
    </Scroll>
  );
}

// ——— MenuView ———

interface MenuSection { section: string; }
interface MenuEntry { title: string; sub: string; color: string; icon: string; }
type MenuRow = MenuSection | MenuEntry;

const MENU_ROWS: MenuRow[] = [
  { section: 'GESTIÓN COMERCIAL' },
  { title: 'CLIENTES', sub: 'Directorio y saldos', color: C.blue, icon: '👥' },
  { title: 'PRODUCTOS', sub: 'Catálogo y precios', color: C.orange, icon: '📦' },
  { title: 'PROVEEDORES', sub: 'Directorio de proveedores', color: C.purple, icon: '🏢' },
  { title: 'COMPRAS', sub: 'Registro de compras', color: C.green, icon: '🛒' },
  { section: 'UTILIDADES' },
  { title: 'CUBICACIÓN', sub: 'Calculadora de m³', color: C.teal, icon: '📐' },
  { title: 'INVENTARIO', sub: 'Stock y movimientos', color: C.indigo, icon: '📊' },
  { title: 'CAJA', sub: 'Flujo de efectivo', color: C.amber, icon: '💰' },
  { section: 'CONFIGURACIÓN' },
  { title: 'PERFIL', sub: 'Información del negocio', color: '#06B6D4', icon: '👤' },
  { title: 'MÉTODOS DE PAGO', sub: 'Configurar cuentas', color: '#64748B', icon: '🏦' },
];

function MenuView() {
  return (
    <Scroll>
      <div style={{ padding: '16px 16px 32px' }}>
        {MENU_ROWS.map((row, i) => {
          if ('section' in row) {
            return (
              <p key={i} style={{
                fontSize: 13, fontWeight: 900, letterSpacing: 1.5,
                color: C.muted, margin: i === 0 ? '4px 0 14px' : '20px 0 14px',
              }}>
                {row.section}
              </p>
            );
          }
          return (
            <div key={i} style={{
              ...card(),
              display: 'flex', alignItems: 'center',
              padding: '12px 14px', gap: 14, marginBottom: 10,
            }}>
              <div style={{
                width: 44, height: 44, backgroundColor: row.color,
                border: `2px solid ${C.black}`, boxShadow: `2px 2px 0 ${C.black}`,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                fontSize: 20, flexShrink: 0,
              }}>
                {row.icon}
              </div>
              <div style={{ flex: 1, minWidth: 0 }}>
                <p style={{ margin: 0, fontSize: 14, fontWeight: 900, letterSpacing: -0.3, color: C.black }}>{row.title}</p>
                <p style={{ margin: 0, fontSize: 12, fontWeight: 500, color: C.muted }}>{row.sub}</p>
              </div>
              <span style={{ fontSize: 16, color: C.black, flexShrink: 0 }}>›</span>
            </div>
          );
        })}
      </div>
    </Scroll>
  );
}

// ——— Root ———

type TabId = 'ventas' | 'clientes' | 'caja' | 'menu';

interface TabDef { id: TabId; label: string; icon: string; }

const TABS: TabDef[] = [
  { id: 'ventas', label: 'VENTAS', icon: '◧' },
  { id: 'clientes', label: 'CLIENTES', icon: '◉' },
  { id: 'caja', label: 'CAJA', icon: '◈' },
  { id: 'menu', label: 'MENÚ', icon: '≡' },
];

const TITLES: Record<TabId, string> = {
  ventas: 'VENTAS',
  clientes: 'CLIENTES',
  caja: 'CAJA / FINANZAS',
  menu: 'HERRAMIENTAS',
};

const APP_H = 60;
const TAB_H = 72;

export function SandManagerSimulation({ screen }: { screen?: string }) {
  const active = (screen ?? 'ventas') as TabId;

  return (
    <div style={{
      width: W, height: H,
      fontFamily: '"Inter", system-ui, -apple-system, sans-serif',
      backgroundColor: C.bg,
      display: 'flex', flexDirection: 'column', overflow: 'hidden',
    }}>
      {/* AppBar */}
      <div style={{
        height: APP_H, flexShrink: 0,
        padding: '0 20px',
        backgroundColor: C.bg, borderBottom: `2px solid ${C.black}`,
        display: 'flex', alignItems: 'flex-end', paddingBottom: 10,
      }}>
        <p style={{ margin: 0, fontSize: 18, fontWeight: 900, letterSpacing: -0.5, color: C.black }}>
          {TITLES[active] ?? 'SAND MANAGER'}
        </p>
        {active === 'ventas' && (
          <div style={{
            marginLeft: 'auto',
            backgroundColor: C.orange, border: `2px solid ${C.black}`,
            padding: '4px 12px', boxShadow: `2px 2px 0 ${C.black}`,
          }}>
            <span style={{ fontSize: 11, fontWeight: 900, color: C.white, letterSpacing: 0.5 }}>+ NUEVA</span>
          </div>
        )}
      </div>

      {/* Content */}
      <div style={{ flex: 1, overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
        {active === 'ventas' && <VentasView />}
        {active === 'clientes' && <ClientesView />}
        {active === 'caja' && <CajaView />}
        {active === 'menu' && <MenuView />}
      </div>

      {/* Tab bar — deepBlack bg, orange indicator */}
      <div style={{
        height: TAB_H, flexShrink: 0,
        display: 'flex', backgroundColor: C.black,
      }}>
        {TABS.map((t) => {
          const isActive = t.id === active;
          return (
            <div key={t.id} style={{
              flex: 1,
              display: 'flex', flexDirection: 'column',
              alignItems: 'center', justifyContent: 'center',
              gap: 4, paddingBottom: 4,
            }}>
              <div style={{
                backgroundColor: isActive ? C.orange : 'transparent',
                padding: '3px 18px',
                display: 'flex', alignItems: 'center', justifyContent: 'center',
              }}>
                <span style={{ fontSize: 18, color: isActive ? C.black : C.mutedDark }}>{t.icon}</span>
              </div>
              <span style={{
                fontSize: 9, fontWeight: isActive ? 900 : 500,
                letterSpacing: 0.5, color: isActive ? C.white : C.mutedDark,
              }}>
                {t.label}
              </span>
            </div>
          );
        })}
      </div>
    </div>
  );
}
