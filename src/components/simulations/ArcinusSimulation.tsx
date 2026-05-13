'use client';

import { SIMULATION_DIMS } from '@/components/ui/DeviceMockup';

const { w: W, h: H } = SIMULATION_DIMS;

// Approximate hex values for AcinusColors OKLCH tokens
// bg0 = oklch(0.16 0.006 260), bg1 = oklch(0.20 0.006 260), etc.
const C = {
  bg0: '#1B1B21',   // screen background
  bg1: '#222229',   // cards, app bar containers
  bg2: '#2A2A32',   // avatars, button bg, slots
  bg3: '#32323C',   // hover/pressed
  fg0: '#FAFAFA',   // text primary
  fg1: '#C8C8CC',   // text secondary
  fg2: '#939398',   // text tertiary
  fg3: '#696970',   // hints, chevrons, placeholders
  line1: '#383840', // card borders, dividers
  line2: '#424248', // avatar borders, hairlines
  accent: '#E85244',  // rojo Acinus — oklch(0.64 0.22 24)
  warning: '#D4A836', // oklch(0.78 0.16 80)
  success: '#47B57A', // oklch(0.74 0.16 152)
  info: '#5299CC',    // oklch(0.72 0.14 235)
};

const STATUS_H = 44;
const APP_H = 56;
const TAB_H = 64;

function Scroll({ children }: { children: React.ReactNode }) {
  return (
    <div style={{ flex: 1, overflowY: 'auto', scrollbarWidth: 'none' }}>
      {children}
    </div>
  );
}

function SectionLabel({ icon, label }: { icon: string; label: string }) {
  return (
    <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 10 }}>
      <span style={{ fontSize: 12, color: C.fg3 }}>{icon}</span>
      <span style={{
        fontSize: 10, fontWeight: 600, color: C.fg3,
        letterSpacing: 1.5, textTransform: 'uppercase' as const,
        fontFamily: 'monospace',
      }}>
        {label}
      </span>
    </div>
  );
}

// ——— InicioView ———

const TOOLS = [
  { label: 'Miembros', icon: '◉', count: '47', hint: 'activos' },
  { label: 'Caja', icon: '◈', count: '$4.2K', hint: 'este mes' },
  { label: 'Productos', icon: '⊞', count: '6', hint: 'disponibles' },
  { label: 'Entrena.', icon: '◎', count: '3', hint: 'esta semana' },
  { label: 'Grupos', icon: '⊕', count: '4', hint: 'activos' },
];

const ACTIVITY = [
  { icon: '✓', text: 'Pago recibido · Sergio R.', time: 'hace 5 min', color: C.success },
  { icon: '+', text: 'Nuevo miembro · Ana Martínez', time: 'hace 1 h', color: C.info },
  { icon: '!', text: 'Pago vencido · Diego López', time: 'hace 3 h', color: C.warning },
  { icon: '○', text: 'Entrena. Grupo A · Mañana 8am', time: 'hace 6 h', color: C.fg3 },
];

function InicioView() {
  return (
    <Scroll>
      <div style={{ padding: '12px 16px 32px' }}>
        {/* Greeting */}
        <div style={{ marginBottom: 18 }}>
          <p style={{
            margin: 0, fontSize: 10, fontWeight: 600, color: C.fg3,
            letterSpacing: 1.5, textTransform: 'uppercase' as const, fontFamily: 'monospace',
          }}>
            Club Deportivo Indalo
          </p>
          <p style={{ margin: '4px 0 0', fontSize: 22, fontWeight: 800, color: C.fg0, letterSpacing: -0.5 }}>
            Hola, Carlos
          </p>
        </div>

        {/* Morosos alert */}
        <div style={{
          background: `${C.warning}1A`,
          border: `1px solid ${C.warning}40`,
          borderRadius: 8,
          padding: '10px 14px',
          display: 'flex', alignItems: 'center', gap: 10,
          marginBottom: 20,
        }}>
          <div style={{
            width: 22, height: 22, borderRadius: 5,
            background: `${C.warning}2A`, border: `1px solid ${C.warning}50`,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 11, fontWeight: 800, color: C.warning, flexShrink: 0,
          }}>!</div>
          <div style={{ flex: 1 }}>
            <p style={{ margin: 0, fontSize: 12, fontWeight: 700, color: C.warning }}>3 pagos vencidos</p>
            <p style={{ margin: 0, fontSize: 10, color: C.fg2 }}>Diego L., María G., Tomás R.</p>
          </div>
          <span style={{ fontSize: 11, color: C.warning, fontWeight: 700 }}>Ver →</span>
        </div>

        {/* Tools grid — 3 columns */}
        <SectionLabel icon="⊞" label="Herramientas" />
        <div style={{
          display: 'grid', gridTemplateColumns: '1fr 1fr 1fr',
          gap: 8, marginBottom: 24,
        }}>
          {TOOLS.map((t) => (
            <div key={t.label} style={{
              background: C.bg1, border: `1px solid ${C.line1}`,
              borderRadius: 8, padding: '12px 10px',
            }}>
              <span style={{ fontSize: 15, color: C.accent }}>{t.icon}</span>
              <p style={{
                margin: '5px 0 2px', fontSize: 17, fontWeight: 800,
                color: C.fg0, letterSpacing: -0.5, fontFamily: 'monospace',
              }}>
                {t.count}
              </p>
              <p style={{ margin: 0, fontSize: 10, fontWeight: 700, color: C.fg1 }}>{t.label}</p>
              <p style={{ margin: '1px 0 0', fontSize: 9, color: C.fg3 }}>{t.hint}</p>
            </div>
          ))}
        </div>

        {/* Recent activity */}
        <SectionLabel icon="○" label="Actividad reciente" />
        <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
          {ACTIVITY.map((item, i) => (
            <div key={i} style={{
              background: C.bg1, border: `1px solid ${C.line1}`,
              borderRadius: 8, padding: '10px 14px',
              display: 'flex', alignItems: 'center', gap: 10,
            }}>
              <div style={{
                width: 24, height: 24, borderRadius: 6,
                background: `${item.color}1A`, border: `1px solid ${item.color}40`,
                display: 'flex', alignItems: 'center', justifyContent: 'center',
                flexShrink: 0, fontSize: 10, fontWeight: 800, color: item.color,
              }}>
                {item.icon}
              </div>
              <p style={{ margin: 0, fontSize: 12, color: C.fg1, flex: 1 }}>{item.text}</p>
              <p style={{ margin: 0, fontSize: 10, color: C.fg3, flexShrink: 0 }}>{item.time}</p>
            </div>
          ))}
        </div>
      </div>
    </Scroll>
  );
}

// ——— MiembrosView ———

type BillingStatus = 'AL DÍA' | 'POR VENCER' | 'VENCIDOS' | 'SIN PLAN';

const BILLING_COLOR: Record<BillingStatus, string> = {
  'AL DÍA': C.success,
  'POR VENCER': C.warning,
  'VENCIDOS': C.accent,
  'SIN PLAN': C.fg3,
};

const MEMBERS = [
  { name: 'Sergio Rodríguez', email: 'sergio@indalo.com', role: 'SOCIO', billing: 'AL DÍA' as BillingStatus },
  { name: 'María González', email: 'maria@indalo.com', role: 'ATLETA', billing: 'VENCIDOS' as BillingStatus },
  { name: 'Ana Martínez', email: 'ana@indalo.com', role: 'ATLETA', billing: 'AL DÍA' as BillingStatus },
  { name: 'Diego López', email: 'diego@indalo.com', role: 'SOCIO', billing: 'VENCIDOS' as BillingStatus },
  { name: 'Tomás Reyes', email: 'tomas@indalo.com', role: 'TUTOR', billing: 'POR VENCER' as BillingStatus },
  { name: 'Lucía Herrera', email: 'lucia@indalo.com', role: 'STAFF', billing: 'AL DÍA' as BillingStatus },
  { name: 'Pablo Vargas', email: 'pablo@indalo.com', role: 'ATLETA', billing: 'SIN PLAN' as BillingStatus },
];

const BILLING_FILTERS: BillingStatus[] = ['AL DÍA', 'POR VENCER', 'VENCIDOS', 'SIN PLAN'];

function MiembrosView() {
  return (
    <>
      {/* Search bar */}
      <div style={{ padding: '10px 16px 6px' }}>
        <div style={{
          background: C.bg1, border: `1px solid ${C.line1}`,
          borderRadius: 8, padding: '9px 12px',
          display: 'flex', alignItems: 'center', gap: 8,
        }}>
          <span style={{ fontSize: 14, color: C.fg3 }}>⌕</span>
          <span style={{ fontSize: 13, color: C.fg3, flex: 1 }}>Buscar miembros...</span>
          <div style={{
            background: C.bg2, border: `1px solid ${C.line2}`,
            borderRadius: 5, padding: '3px 8px',
            fontSize: 9, fontWeight: 700, color: C.fg2, letterSpacing: 0.8,
          }}>
            FILTRAR
          </div>
        </div>
      </div>

      {/* Billing status filter chips */}
      <div style={{
        padding: '0 16px 8px', display: 'flex', gap: 6,
        overflowX: 'auto', scrollbarWidth: 'none',
      }}>
        {BILLING_FILTERS.map((f) => {
          const color = BILLING_COLOR[f];
          const active = f === 'VENCIDOS';
          return (
            <div key={f} style={{
              flexShrink: 0,
              background: active ? `${color}2A` : C.bg1,
              border: `1px solid ${active ? color : C.line1}`,
              borderRadius: 5, padding: '4px 10px',
              fontSize: 9, fontWeight: 700,
              color: active ? color : C.fg2,
            }}>
              {f}
            </div>
          );
        })}
      </div>

      {/* Members list */}
      <Scroll>
        <div style={{ padding: '4px 16px 32px', display: 'flex', flexDirection: 'column', gap: 6 }}>
          {MEMBERS.map((m, i) => {
            const billingColor = BILLING_COLOR[m.billing];
            return (
              <div key={i} style={{
                height: 80, background: C.bg1, border: `1px solid ${C.line1}`,
                borderRadius: 8, padding: '0 14px',
                display: 'flex', alignItems: 'center', gap: 12,
              }}>
                {/* Avatar */}
                <div style={{
                  width: 44, height: 44, borderRadius: 10,
                  background: C.bg2, border: `1px solid ${C.line2}`,
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  flexShrink: 0, fontSize: 16, fontWeight: 800, color: C.accent,
                }}>
                  {m.name[0]}
                </div>
                {/* Name + email + role */}
                <div style={{ flex: 1, minWidth: 0 }}>
                  <p style={{
                    margin: '0 0 2px', fontSize: 13, fontWeight: 700, color: C.fg0,
                    whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis',
                  }}>
                    {m.name}
                  </p>
                  <p style={{ margin: '0 0 6px', fontSize: 10, color: C.fg3, fontFamily: 'monospace' }}>
                    {m.email}
                  </p>
                  <span style={{
                    fontSize: 9, fontWeight: 700, color: C.accent,
                    background: `${C.accent}1A`, border: `1px solid ${C.accent}40`,
                    borderRadius: 4, padding: '2px 6px',
                  }}>
                    {m.role}
                  </span>
                </div>
                {/* Billing status */}
                <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-end', gap: 6 }}>
                  <span style={{
                    fontSize: 9, fontWeight: 700, color: billingColor,
                    background: `${billingColor}1A`, borderRadius: 4, padding: '2px 6px',
                  }}>
                    {m.billing}
                  </span>
                  <span style={{ fontSize: 14, color: C.fg3 }}>›</span>
                </div>
              </div>
            );
          })}
        </div>
      </Scroll>
    </>
  );
}

// ——— CajaView ———

const TRANSACTIONS = [
  { name: 'Sergio Rodríguez', concept: 'Mensualidad Básica', amount: '+$80.000', date: 'hoy', isPago: true },
  { name: 'Ana Martínez', concept: 'Plan Semestral', amount: '+$420.000', date: 'ayer', isPago: true },
  { name: 'María González', concept: 'Mensualidad Básica', amount: '−$80.000', date: '08 may', isPago: false },
  { name: 'Diego López', concept: 'Inscripción', amount: '+$150.000', date: '05 may', isPago: true },
  { name: 'Tomás Reyes', concept: 'Clase Individual', amount: '−$45.000', date: '01 may', isPago: false },
];

function CajaView() {
  return (
    <Scroll>
      <div style={{ padding: '12px 16px 32px' }}>
        {/* Balance card */}
        <div style={{
          background: C.bg1, border: `1px solid ${C.line1}`,
          borderRadius: 8, padding: '16px', marginBottom: 20,
        }}>
          <p style={{
            margin: 0, fontSize: 10, fontWeight: 600, color: C.fg3,
            letterSpacing: 1.5, textTransform: 'uppercase' as const, fontFamily: 'monospace',
          }}>
            Ingresos este mes
          </p>
          <p style={{ margin: '6px 0 16px', fontSize: 28, fontWeight: 800, color: C.success, letterSpacing: -0.5 }}>
            $4.200.000
          </p>
          <div style={{ display: 'flex', gap: 0 }}>
            {[
              { label: 'COBRADO', value: '38 pagos', color: C.fg1 },
              { label: 'PENDIENTE', value: '$480.000', color: C.accent },
              { label: 'VENCIDOS', value: '3 socios', color: C.accent },
            ].map((stat, i, arr) => (
              <div key={stat.label} style={{
                flex: 1,
                borderRight: i < arr.length - 1 ? `1px solid ${C.line1}` : 'none',
                paddingRight: i < arr.length - 1 ? 12 : 0,
                paddingLeft: i > 0 ? 12 : 0,
              }}>
                <p style={{ margin: 0, fontSize: 9, color: C.fg3, fontFamily: 'monospace', letterSpacing: 0.8 }}>{stat.label}</p>
                <p style={{ margin: '3px 0 0', fontSize: 12, fontWeight: 700, color: stat.color }}>{stat.value}</p>
              </div>
            ))}
          </div>
        </div>

        {/* Transaction list */}
        <SectionLabel icon="↕" label="Movimientos" />
        <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
          {TRANSACTIONS.map((t, i) => {
            const color = t.isPago ? C.success : C.accent;
            return (
              <div key={i} style={{
                background: C.bg1, border: `1px solid ${C.line1}`,
                borderRadius: 8, padding: '12px 14px',
                display: 'flex', alignItems: 'center', gap: 12,
              }}>
                <div style={{
                  width: 36, height: 36, borderRadius: 8,
                  background: `${color}1A`, border: `1px solid ${color}40`,
                  display: 'flex', alignItems: 'center', justifyContent: 'center',
                  flexShrink: 0, fontSize: 12, fontWeight: 800, color,
                }}>
                  {t.isPago ? '✓' : '!'}
                </div>
                <div style={{ flex: 1, minWidth: 0 }}>
                  <p style={{
                    margin: 0, fontSize: 12, fontWeight: 700, color: C.fg0,
                    whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis',
                  }}>
                    {t.name}
                  </p>
                  <p style={{ margin: 0, fontSize: 10, color: C.fg3 }}>{t.concept}</p>
                </div>
                <div style={{ textAlign: 'right' as const, flexShrink: 0 }}>
                  <p style={{ margin: 0, fontSize: 13, fontWeight: 800, color }}>{t.amount}</p>
                  <p style={{ margin: 0, fontSize: 10, color: C.fg3 }}>{t.date}</p>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </Scroll>
  );
}

// ——— ProductosView ———

interface Product { label: string; price: string; active: boolean; }

const PRODUCTS: Product[] = [
  { label: 'Mensualidad Básica', price: '$80.000 / mes', active: true },
  { label: 'Plan Semestral', price: '$420.000 / 6 meses', active: true },
  { label: 'Clase Individual', price: '$45.000 / sesión', active: true },
  { label: 'Inscripción', price: '$150.000 único', active: false },
  { label: 'Pack Familiar', price: '$200.000 / mes', active: true },
];

function ProductosView() {
  return (
    <Scroll>
      <div style={{ padding: '12px 16px 32px' }}>
        <SectionLabel icon="⊞" label="Planes y productos" />
        <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
          {PRODUCTS.map((p, i) => {
            const statusColor = p.active ? C.success : C.fg3;
            return (
              <div key={i} style={{
                background: C.bg1, border: `1px solid ${C.line1}`,
                borderRadius: 8, padding: '14px',
                display: 'flex', alignItems: 'center', gap: 12,
              }}>
                <div style={{ flex: 1, minWidth: 0 }}>
                  <p style={{ margin: 0, fontSize: 13, fontWeight: 700, color: C.fg0 }}>{p.label}</p>
                  <p style={{ margin: '3px 0 0', fontSize: 11, color: C.fg3, fontFamily: 'monospace' }}>{p.price}</p>
                </div>
                <span style={{
                  fontSize: 9, fontWeight: 700, color: statusColor,
                  background: `${statusColor}1A`, border: `1px solid ${statusColor}40`,
                  borderRadius: 4, padding: '3px 8px', flexShrink: 0,
                }}>
                  {p.active ? 'ACTIVO' : 'INACTIVO'}
                </span>
              </div>
            );
          })}
          {/* Add new button */}
          <div style={{
            border: `1.5px dashed ${C.line2}`, borderRadius: 8,
            padding: '14px 16px', display: 'flex', alignItems: 'center', gap: 8,
          }}>
            <span style={{ fontSize: 16, color: C.fg3 }}>+</span>
            <p style={{ margin: 0, fontSize: 13, color: C.fg3 }}>Nuevo plan o producto</p>
          </div>
        </div>
      </div>
    </Scroll>
  );
}

// ——— Root ———

type TabId = 'inicio' | 'miembros' | 'caja' | 'productos';

interface TabDef { id: TabId; icon: string; label: string; }

const TABS: TabDef[] = [
  { id: 'inicio', icon: '⌂', label: 'Inicio' },
  { id: 'miembros', icon: '◉', label: 'Miembros' },
  { id: 'caja', icon: '◈', label: 'Caja' },
  { id: 'productos', icon: '⊞', label: 'Productos' },
];

const TAB_TITLES: Record<TabId, string> = {
  inicio: 'ARCINUS',
  miembros: 'MIEMBROS',
  caja: 'CAJA',
  productos: 'PRODUCTOS',
};

export function ArcinusSimulation({ screen }: { screen?: string }) {
  const active = (screen ?? 'inicio') as TabId;

  return (
    <div style={{
      width: W, height: H,
      fontFamily: '"Inter Tight", "Inter", system-ui, sans-serif',
      backgroundColor: C.bg0,
      display: 'flex', flexDirection: 'column', overflow: 'hidden',
    }}>
      {/* Status bar */}
      <div style={{
        height: STATUS_H, flexShrink: 0,
        display: 'flex', alignItems: 'center', justifyContent: 'space-between',
        padding: '0 20px', paddingTop: 10, backgroundColor: C.bg0,
      }}>
        <span style={{ fontSize: 13, fontWeight: 700, color: C.fg0 }}>9:41</span>
        <div style={{ display: 'flex', gap: 4, alignItems: 'center' }}>
          <span style={{ fontSize: 11, color: C.fg0, letterSpacing: -0.5 }}>▂▄█</span>
          <span style={{ fontSize: 10, color: C.fg0 }}>100%</span>
        </div>
      </div>

      {/* App bar */}
      <div style={{
        height: APP_H, flexShrink: 0,
        display: 'flex', alignItems: 'center', justifyContent: 'space-between',
        padding: '0 20px', backgroundColor: C.bg0,
      }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
          <div style={{
            width: 26, height: 26, borderRadius: 6, background: C.accent,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            flexShrink: 0,
          }}>
            <span style={{ fontSize: 12, color: '#fff', fontWeight: 800 }}>◈</span>
          </div>
          <span style={{ fontSize: 16, fontWeight: 800, color: C.fg0, letterSpacing: -0.4 }}>
            {TAB_TITLES[active] ?? 'ARCINUS'}
          </span>
        </div>
        <div style={{
          width: 30, height: 30, borderRadius: 8,
          background: C.bg2, border: `1px solid ${C.line2}`,
          display: 'flex', alignItems: 'center', justifyContent: 'center',
          fontSize: 14,
        }}>
          🔔
        </div>
      </div>

      {/* Content */}
      <div style={{ flex: 1, overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
        {active === 'inicio' && <InicioView />}
        {active === 'miembros' && <MiembrosView />}
        {active === 'caja' && <CajaView />}
        {active === 'productos' && <ProductosView />}
      </div>

      {/* Tab bar */}
      <div style={{
        height: TAB_H, flexShrink: 0,
        display: 'flex',
        backgroundColor: C.bg1, borderTop: `1px solid ${C.line1}`,
      }}>
        {TABS.map((t) => {
          const isActive = t.id === active;
          return (
            <div key={t.id} style={{
              flex: 1,
              display: 'flex', flexDirection: 'column',
              alignItems: 'center', justifyContent: 'center',
              gap: 3, paddingBottom: 6,
              color: isActive ? C.accent : C.fg3,
              fontSize: 10, fontWeight: isActive ? 700 : 500,
              borderTop: `2px solid ${isActive ? C.accent : 'transparent'}`,
            }}>
              <span style={{ fontSize: 18 }}>{t.icon}</span>
              <span>{t.label}</span>
            </div>
          );
        })}
      </div>
    </div>
  );
}
