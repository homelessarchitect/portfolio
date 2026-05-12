'use client';

import { useState } from 'react';
import { SIMULATION_DIMS } from '@/components/ui/DeviceMockup';

const { w: W, h: H } = SIMULATION_DIMS;

const C = {
  bg: '#F5F4F0',
  black: '#0A0A0A',
  white: '#FFFFFF',
  orange: '#F97316',
  blue: '#3B82F6',
  purple: '#8B5CF6',
  green: '#22C55E',
  teal: '#14B8A6',
  indigo: '#6366F1',
  amber: '#F59E0B',
  muted: 'rgba(10,10,10,0.5)',
  error: '#EF4444',
  success: '#22C55E',
};

function impactCard(bg = C.white): React.CSSProperties {
  return {
    backgroundColor: bg,
    border: `2px solid ${C.black}`,
    boxShadow: `3px 3px 0 ${C.black}`,
    borderRadius: 0,
  };
}

const MENU_ITEMS = [
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
  { title: 'MÉTODOS DE PAGO', sub: 'Configurar cuentas y bancos', color: '#64748B', icon: '🏦' },
  { section: 'SISTEMA' },
  { title: 'SINCRONIZAR', sub: 'Manual a la nube', color: C.error, icon: '☁️' },
] as const;

type MenuItem = (typeof MENU_ITEMS)[number];

const SALE_LINES = [
  { name: 'ARENA FINA', qty: '15 m³', price: '$45.000', subtotal: '$675.000' },
  { name: 'TRITURADO 3/4', qty: '8 m³', price: '$52.000', subtotal: '$416.000' },
];

const INVENTORY_ITEMS = [
  { name: 'ARENA FINA', stock: '28.50 M³', ok: true },
  { name: 'ARENA GRUESA', stock: '12.00 M³', ok: true },
  { name: 'TRITURADO 3/4', stock: '5.25 M³', ok: false },
  { name: 'GRAVILLA', stock: '34.80 M³', ok: true },
];

function ScrollArea({ children }: { children: React.ReactNode }) {
  return (
    <div
      style={{ flex: 1, overflowY: 'auto', scrollbarWidth: 'none' }}
    >
      <style>{`div::-webkit-scrollbar { display: none; }`}</style>
      {children}
    </div>
  );
}

function MenuView() {
  return (
    <ScrollArea>
      <div style={{ padding: '20px 20px 24px' }}>
        {MENU_ITEMS.map((item: MenuItem, i) => {
          if ('section' in item) {
            return (
              <p
                key={i}
                style={{
                  fontSize: 13,
                  fontWeight: 900,
                  letterSpacing: 2,
                  color: C.muted,
                  margin: i === 0 ? '0 0 16px' : '24px 0 16px',
                }}
              >
                {item.section}
              </p>
            );
          }
          return (
            <div
              key={i}
              style={{
                ...impactCard(),
                display: 'flex',
                alignItems: 'center',
                padding: '12px 14px',
                gap: 14,
                marginBottom: 12,
                cursor: 'pointer',
              }}
            >
              <div
                style={{
                  width: 48,
                  height: 48,
                  backgroundColor: item.color,
                  border: `2px solid ${C.black}`,
                  boxShadow: `2px 2px 0 ${C.black}`,
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  fontSize: 22,
                  flexShrink: 0,
                  borderRadius: 0,
                }}
              >
                {item.icon}
              </div>
              <div style={{ flex: 1, minWidth: 0 }}>
                <p style={{ fontSize: 15, fontWeight: 900, letterSpacing: -0.3, margin: 0, color: C.black }}>
                  {item.title}
                </p>
                <p style={{ fontSize: 12, fontWeight: 500, margin: 0, color: C.muted }}>
                  {item.sub}
                </p>
              </div>
              <span style={{ fontSize: 14, color: C.black, flexShrink: 0 }}>›</span>
            </div>
          );
        })}
      </div>
    </ScrollArea>
  );
}

function SaleView() {
  return (
    <ScrollArea>
      <div style={{ padding: '20px 20px 32px' }}>
        {/* Client */}
        <p style={{ fontSize: 13, fontWeight: 900, letterSpacing: 1, color: C.black, margin: '0 0 10px' }}>
          CLIENTE
        </p>
        <div
          style={{
            ...impactCard(),
            display: 'flex',
            alignItems: 'center',
            padding: '14px 16px',
            gap: 12,
            marginBottom: 24,
            cursor: 'pointer',
          }}
        >
          <span style={{ fontSize: 20 }}>👤</span>
          <p style={{ fontSize: 13, fontWeight: 700, flex: 1, margin: 0, color: C.black }}>
            CONSTRUCTORA EL PINO S.A.S
          </p>
          <span style={{ fontSize: 16, color: C.black }}>▾</span>
        </div>

        {/* Products */}
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 12 }}>
          <p style={{ fontSize: 13, fontWeight: 900, letterSpacing: 1, margin: 0, color: C.black }}>
            PRODUCTOS
          </p>
          <span style={{ fontSize: 13, fontWeight: 900, color: C.orange, cursor: 'pointer' }}>
            + AGREGAR
          </span>
        </div>
        {SALE_LINES.map((line, i) => (
          <div key={i} style={{ ...impactCard(), padding: '12px 14px', marginBottom: 10 }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 4 }}>
              <p style={{ fontSize: 14, fontWeight: 900, margin: 0, color: C.black }}>{line.name}</p>
              <p style={{ fontSize: 14, fontWeight: 900, margin: 0, color: C.orange }}>{line.subtotal}</p>
            </div>
            <p style={{ fontSize: 12, fontWeight: 600, margin: 0, color: C.muted }}>
              {line.qty} × {line.price}
            </p>
          </div>
        ))}

        {/* Divider */}
        <div style={{ borderTop: `2px solid ${C.black}`, margin: '16px 0' }} />

        {/* Payment toggle */}
        <p style={{ fontSize: 13, fontWeight: 900, letterSpacing: 1, color: C.black, margin: '0 0 10px' }}>
          TIPO DE PAGO
        </p>
        <div style={{ border: `2px solid ${C.black}`, display: 'flex', marginBottom: 24 }}>
          <div style={{ flex: 1, backgroundColor: C.black, padding: '12px', textAlign: 'center' }}>
            <p style={{ fontSize: 13, fontWeight: 900, color: C.white, margin: 0, letterSpacing: 1 }}>
              CONTADO
            </p>
          </div>
          <div style={{ width: 2, backgroundColor: C.black }} />
          <div style={{ flex: 1, backgroundColor: C.white, padding: '12px', textAlign: 'center', opacity: 0.45 }}>
            <p style={{ fontSize: 13, fontWeight: 900, color: C.black, margin: 0, letterSpacing: 1 }}>
              CRÉDITO
            </p>
          </div>
        </div>

        {/* Total */}
        <div
          style={{
            backgroundColor: C.black,
            border: `2px solid ${C.black}`,
            boxShadow: `3px 3px 0 ${C.black}`,
            padding: '16px 18px',
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            marginBottom: 14,
          }}
        >
          <p style={{ fontSize: 13, fontWeight: 900, color: C.white, margin: 0, letterSpacing: 0.5 }}>
            TOTAL A PAGAR
          </p>
          <p style={{ fontSize: 22, fontWeight: 900, color: C.orange, margin: 0 }}>$1.091.000</p>
        </div>

        {/* CTA */}
        <div
          style={{
            backgroundColor: C.orange,
            border: `2px solid ${C.black}`,
            boxShadow: `3px 3px 0 ${C.black}`,
            padding: '16px',
            textAlign: 'center',
            cursor: 'pointer',
          }}
        >
          <p style={{ fontSize: 15, fontWeight: 900, color: C.black, margin: 0, letterSpacing: 1 }}>
            CONFIRMAR VENTA
          </p>
        </div>
      </div>
    </ScrollArea>
  );
}

function InventoryView() {
  return (
    <ScrollArea>
      <div style={{ padding: '20px 20px 32px' }}>
        {INVENTORY_ITEMS.map((item, i) => (
          <div key={i} style={{ ...impactCard(), padding: '16px 18px', marginBottom: 12 }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 10, marginBottom: 12 }}>
              <span style={{ fontSize: 18 }}>📦</span>
              <p style={{ fontSize: 15, fontWeight: 900, margin: 0, color: C.black, flex: 1 }}>
                {item.name}
              </p>
            </div>
            <div style={{ borderTop: `3px solid ${C.black}`, paddingTop: 12, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <div>
                <p style={{ fontSize: 11, fontWeight: 900, letterSpacing: 0.5, color: C.muted, margin: '0 0 4px' }}>
                  STOCK TEÓRICO (ESTIMADO)
                </p>
                <p style={{ fontSize: 28, fontWeight: 900, color: item.ok ? C.orange : C.error, margin: 0 }}>
                  {item.stock}
                </p>
              </div>
              <div
                style={{
                  border: `2px solid ${C.black}`,
                  padding: '8px 14px',
                  cursor: 'pointer',
                  display: 'flex',
                  alignItems: 'center',
                  gap: 6,
                }}
              >
                <span style={{ fontSize: 13 }}>⚙️</span>
                <p style={{ fontSize: 12, fontWeight: 900, margin: 0, letterSpacing: 0.5 }}>AJUSTAR</p>
              </div>
            </div>
          </div>
        ))}
      </div>
    </ScrollArea>
  );
}

type Tab = 'menu' | 'sale' | 'inventory';

const TABS: { id: Tab; label: string; icon: string }[] = [
  { id: 'menu', label: 'MENÚ', icon: '≡' },
  { id: 'sale', label: 'VENTA', icon: '+' },
  { id: 'inventory', label: 'STOCK', icon: '◈' },
];

export function SandManagerSimulation() {
  const [tab, setTab] = useState<Tab>('menu');

  const APPBAR_H = 60;
  const TABNAV_H = 52;
  const CONTENT_H = H - APPBAR_H - TABNAV_H;

  const titles: Record<Tab, string> = {
    menu: 'HERRAMIENTAS',
    sale: 'NUEVA VENTA',
    inventory: 'INVENTARIO TEÓRICO',
  };

  return (
    <div
      style={{
        width: W,
        height: H,
        fontFamily: 'system-ui, -apple-system, "Helvetica Neue", sans-serif',
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
          padding: '0 20px',
          backgroundColor: C.bg,
          borderBottom: `2px solid ${C.black}`,
          display: 'flex',
          alignItems: 'flex-end',
          paddingBottom: 10,
          flexShrink: 0,
        }}
      >
        <p style={{ fontSize: 18, fontWeight: 900, letterSpacing: -0.5, margin: 0, color: C.black }}>
          {titles[tab]}
        </p>
        {tab === 'sale' && (
          <p style={{ fontSize: 14, fontWeight: 900, color: C.orange, margin: '0 0 0 auto', cursor: 'pointer' }}>
            FINALIZAR
          </p>
        )}
      </div>

      {/* Content */}
      <div style={{ height: CONTENT_H, overflow: 'hidden', display: 'flex', flexDirection: 'column' }}>
        {tab === 'menu' && <MenuView />}
        {tab === 'sale' && <SaleView />}
        {tab === 'inventory' && <InventoryView />}
      </div>

      {/* Bottom tab bar */}
      <div
        style={{
          height: TABNAV_H,
          display: 'flex',
          backgroundColor: C.white,
          borderTop: `2px solid ${C.black}`,
          flexShrink: 0,
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
              backgroundColor: tab === t.id ? C.black : C.white,
              color: tab === t.id ? C.white : C.muted,
              fontSize: 11,
              fontWeight: 900,
              letterSpacing: 0.5,
              fontFamily: 'inherit',
              display: 'flex',
              flexDirection: 'column',
              alignItems: 'center',
              justifyContent: 'center',
              gap: 2,
              transition: 'background-color 0.15s',
            }}
          >
            <span style={{ fontSize: 16 }}>{t.icon}</span>
            {t.label}
          </button>
        ))}
      </div>
    </div>
  );
}
