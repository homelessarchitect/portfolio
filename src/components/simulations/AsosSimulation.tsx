'use client';

import { useState } from 'react';
import { BROWSER_W, BROWSER_H } from '@/components/ui/BrowserSimulationMockup';

const C = {
  bg: '#FFFFFF',
  sidebarBg: '#FAFAFA',
  border: '#E8E8F0',
  primary: '#1A1A3E',
  primaryFg: '#FFFFFF',
  text: '#0F172A',
  textMuted: '#475569',
  textLight: '#94A3B8',
  card: '#FFFFFF',
  muted: '#F1F5F9',
  success: '#166534',
  successBg: '#DCFCE7',
  danger: '#991B1B',
  dangerBg: '#FEE2E2',
  amber: '#92400E',
  amberBg: '#FEF3C7',
};

const SIDEBAR_W = 200;
const CONTENT_W = BROWSER_W - SIDEBAR_W;

type View = 'overview' | 'leads' | 'projects';

const NAV_ITEMS: { id: View; icon: string; label: string }[] = [
  { id: 'overview', icon: '◫', label: 'Overview' },
  { id: 'leads', icon: '◎', label: 'Leads' },
  { id: 'projects', icon: '⊡', label: 'Projects' },
];

// ——— Overview ———

function OverviewContent() {
  const metrics = [
    { label: 'Total Leads', value: '24', icon: '◎', delta: '+3 this week' },
    { label: 'Active Projects', value: '3', icon: '⊡', delta: 'All running' },
    { label: 'Pending Tasks', value: '8', icon: '☐', delta: '2 due today' },
  ];

  return (
    <div style={{ padding: 28, overflowY: 'auto', height: '100%', boxSizing: 'border-box' }}>
      <h1 style={{ fontSize: 24, fontWeight: 700, color: C.text, margin: '0 0 4px', letterSpacing: -0.5 }}>
        Overview
      </h1>
      <p style={{ fontSize: 14, color: C.textMuted, margin: '0 0 24px' }}>
        Here's what's happening in your pipeline.
      </p>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 16, marginBottom: 28 }}>
        {metrics.map((m) => (
          <div key={m.label} style={{
            background: C.card, border: `1px solid ${C.border}`,
            borderRadius: 12, padding: '20px 18px',
            boxShadow: '0 1px 3px rgba(0,0,0,0.04)',
          }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 12 }}>
              <p style={{ fontSize: 13, fontWeight: 600, color: C.textMuted, margin: 0 }}>{m.label}</p>
              <span style={{ fontSize: 18, color: C.textLight }}>{m.icon}</span>
            </div>
            <p style={{ fontSize: 28, fontWeight: 700, color: C.text, margin: '0 0 4px', letterSpacing: -0.5 }}>
              {m.value}
            </p>
            <p style={{ fontSize: 12, color: C.textLight, margin: 0 }}>{m.delta}</p>
          </div>
        ))}
      </div>

      <div style={{ display: 'flex', gap: 10 }}>
        <button style={{
          background: C.primary, color: C.primaryFg, border: 'none',
          borderRadius: 8, padding: '9px 18px', fontSize: 13, fontWeight: 600,
          cursor: 'pointer', fontFamily: 'inherit',
        }}>
          Manage Leads
        </button>
        <button style={{
          background: 'transparent', color: C.text,
          border: `1px solid ${C.border}`, borderRadius: 8,
          padding: '9px 18px', fontSize: 13, fontWeight: 600,
          cursor: 'pointer', fontFamily: 'inherit',
        }}>
          View Projects
        </button>
      </div>
    </div>
  );
}

// ——— Leads ———

const LEADS = [
  { business: 'TechCorp SAS', industry: 'Technology', status: 'contacted', score: 78 },
  { business: 'Muebles López', industry: 'Retail', status: 'new', score: 45 },
  { business: 'Consultora ABC', industry: 'Services', status: 'converted', score: 92 },
  { business: 'Distribuciones Gómez', industry: 'Distribution', status: 'rejected', score: 23 },
  { business: 'Software del Norte', industry: 'Technology', status: 'contacted', score: 67 },
];

const STATUS_STYLE: Record<string, { bg: string; color: string }> = {
  new: { bg: C.muted, color: C.textMuted },
  contacted: { bg: C.primary + '15', color: C.primary },
  converted: { bg: C.successBg, color: C.success },
  rejected: { bg: C.dangerBg, color: C.danger },
};

function LeadsContent() {
  return (
    <div style={{ padding: 28, overflowY: 'auto', height: '100%', boxSizing: 'border-box' }}>
      <h1 style={{ fontSize: 24, fontWeight: 700, color: C.text, margin: '0 0 4px', letterSpacing: -0.5 }}>
        Leads
      </h1>
      <p style={{ fontSize: 14, color: C.textMuted, margin: '0 0 20px' }}>
        {LEADS.length} leads in the database.
      </p>

      <div style={{ background: C.card, border: `1px solid ${C.border}`, borderRadius: 12, overflow: 'hidden', boxShadow: '0 1px 3px rgba(0,0,0,0.04)' }}>
        {/* Table header */}
        <div style={{
          display: 'grid', gridTemplateColumns: '2fr 1.5fr 1fr 80px',
          padding: '12px 18px', borderBottom: `1px solid ${C.border}`,
          background: C.muted,
        }}>
          {['Business', 'Industry', 'Status', 'Score'].map((h) => (
            <p key={h} style={{ fontSize: 11, fontWeight: 600, color: C.textMuted, margin: 0, textTransform: 'uppercase', letterSpacing: 0.6 }}>
              {h}
            </p>
          ))}
        </div>
        {/* Rows */}
        {LEADS.map((l, i) => {
          const s = STATUS_STYLE[l.status] || STATUS_STYLE.new;
          return (
            <div
              key={i}
              style={{
                display: 'grid', gridTemplateColumns: '2fr 1.5fr 1fr 80px',
                padding: '14px 18px',
                borderBottom: i < LEADS.length - 1 ? `1px solid ${C.border}` : 'none',
                alignItems: 'center',
              }}
            >
              <p style={{ fontSize: 14, fontWeight: 600, color: C.text, margin: 0 }}>{l.business}</p>
              <p style={{ fontSize: 13, color: C.textMuted, margin: 0 }}>{l.industry}</p>
              <div>
                <span style={{
                  fontSize: 11, fontWeight: 600, padding: '3px 8px',
                  borderRadius: 6, background: s.bg, color: s.color,
                  textTransform: 'capitalize',
                }}>
                  {l.status}
                </span>
              </div>
              <p style={{ fontSize: 13, fontWeight: 700, fontFamily: 'monospace', color: C.text, margin: 0 }}>
                {l.score}
              </p>
            </div>
          );
        })}
      </div>
    </div>
  );
}

// ——— Projects ———

const PROJECTS = [
  { name: 'Claude Code', badge: 'Active', leads: 12, tasks: 5 },
  { name: 'FleetView', badge: 'Active', leads: 8, tasks: 3 },
  { name: 'Claude.ai Pro', badge: 'Active', leads: 4, tasks: 0 },
];

function ProjectsContent() {
  return (
    <div style={{ padding: 28, overflowY: 'auto', height: '100%', boxSizing: 'border-box' }}>
      <h1 style={{ fontSize: 24, fontWeight: 700, color: C.text, margin: '0 0 4px', letterSpacing: -0.5 }}>
        Projects
      </h1>
      <p style={{ fontSize: 14, color: C.textMuted, margin: '0 0 20px' }}>
        The 3 products ASOS sells on your behalf.
      </p>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 16 }}>
        {PROJECTS.map((p) => (
          <div key={p.name} style={{
            background: C.card, border: `1px solid ${C.border}`,
            borderRadius: 12, padding: 20, boxShadow: '0 1px 3px rgba(0,0,0,0.04)',
          }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: 16 }}>
              <p style={{ fontSize: 15, fontWeight: 700, color: C.text, margin: 0 }}>{p.name}</p>
              <span style={{
                fontSize: 10, fontWeight: 600, color: C.success, background: C.successBg,
                borderRadius: 6, padding: '2px 8px',
              }}>
                {p.badge}
              </span>
            </div>
            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: 12 }}>
              <div>
                <p style={{ fontSize: 22, fontWeight: 700, color: C.text, margin: '0 0 2px' }}>{p.leads}</p>
                <p style={{ fontSize: 11, color: C.textMuted, margin: 0 }}>Leads</p>
              </div>
              <div>
                <p style={{ fontSize: 22, fontWeight: 700, color: C.text, margin: '0 0 2px' }}>{p.tasks}</p>
                <p style={{ fontSize: 11, color: C.textMuted, margin: 0 }}>Pending tasks</p>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

// ——— Root ———

export function AsosSimulation() {
  const [view, setView] = useState<View>('overview');

  return (
    <div style={{
      width: BROWSER_W, height: BROWSER_H,
      fontFamily: 'system-ui, -apple-system, "Segoe UI", sans-serif',
      display: 'flex', overflow: 'hidden',
    }}>
      {/* Sidebar */}
      <div style={{
        width: SIDEBAR_W, height: BROWSER_H, flexShrink: 0,
        background: C.sidebarBg, borderRight: `1px solid ${C.border}`,
        display: 'flex', flexDirection: 'column',
      }}>
        {/* Brand */}
        <div style={{ padding: '20px 16px 16px', borderBottom: `1px solid ${C.border}` }}>
          <p style={{ fontSize: 16, fontWeight: 800, color: C.text, margin: '0 0 2px', letterSpacing: -0.3 }}>ASOS</p>
          <p style={{ fontSize: 11, color: C.textLight, margin: 0 }}>CRM for Claude Code</p>
        </div>

        {/* Nav items */}
        <nav style={{ flex: 1, padding: '12px 8px' }}>
          {NAV_ITEMS.map((item) => {
            const active = view === item.id;
            return (
              <button
                key={item.id}
                onClick={() => setView(item.id)}
                style={{
                  width: '100%', display: 'flex', alignItems: 'center', gap: 10,
                  padding: '9px 10px', borderRadius: 8, border: 'none',
                  cursor: 'pointer', fontFamily: 'inherit',
                  background: active ? C.primary : 'transparent',
                  color: active ? C.primaryFg : C.textMuted,
                  fontSize: 13, fontWeight: active ? 600 : 500,
                  marginBottom: 2, textAlign: 'left',
                  transition: 'all 0.15s',
                }}
              >
                <span style={{ fontSize: 16 }}>{item.icon}</span>
                {item.label}
              </button>
            );
          })}

          {/* Extra items (non-interactive) */}
          {[
            { icon: '☐', label: 'Tasks', badge: '8' },
            { icon: '✓', label: 'Approvals', badge: '2' },
            { icon: '◈', label: 'Interactions' },
          ].map((item) => (
            <button
              key={item.label}
              style={{
                width: '100%', display: 'flex', alignItems: 'center', gap: 10,
                padding: '9px 10px', borderRadius: 8, border: 'none',
                cursor: 'default', fontFamily: 'inherit',
                background: 'transparent', color: C.textMuted,
                fontSize: 13, fontWeight: 500, marginBottom: 2,
                justifyContent: 'space-between',
              }}
            >
              <span style={{ display: 'flex', alignItems: 'center', gap: 10 }}>
                <span style={{ fontSize: 16 }}>{item.icon}</span>
                {item.label}
              </span>
              {item.badge && (
                <span style={{
                  fontSize: 10, fontWeight: 600, color: C.textLight,
                  background: C.muted, borderRadius: 999, padding: '1px 6px',
                }}>
                  {item.badge}
                </span>
              )}
            </button>
          ))}
        </nav>

        {/* Footer */}
        <div style={{ padding: '12px 16px', borderTop: `1px solid ${C.border}` }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
            <div style={{
              width: 28, height: 28, borderRadius: 8, background: C.primary,
              display: 'flex', alignItems: 'center', justifyContent: 'center',
              fontSize: 12, color: '#fff', fontWeight: 700,
            }}>
              D
            </div>
            <div>
              <p style={{ fontSize: 12, fontWeight: 600, color: C.text, margin: 0 }}>Darien H.</p>
              <p style={{ fontSize: 10, color: C.textLight, margin: 0 }}>v0.0.1</p>
            </div>
          </div>
        </div>
      </div>

      {/* Main content */}
      <div style={{ width: CONTENT_W, height: BROWSER_H, background: C.bg, overflow: 'hidden' }}>
        {view === 'overview' && <OverviewContent />}
        {view === 'leads' && <LeadsContent />}
        {view === 'projects' && <ProjectsContent />}
      </div>
    </div>
  );
}
