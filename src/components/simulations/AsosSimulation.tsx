'use client';

import { useState } from 'react';
import { BROWSER_W, BROWSER_H } from '@/components/ui/BrowserSimulationMockup';

// ——— Tokens ———

const C = {
  bg: '#FFFFFF',
  sidebarBg: '#FAFAFA',
  border: '#E5E7EB',
  borderFaint: '#F3F4F6',
  primary: '#0F172A',
  primaryFg: '#FFFFFF',
  text: '#0F172A',
  textMuted: '#64748B',
  textLight: '#94A3B8',
  muted: '#F1F5F9',
  mutedDarker: '#E9EEF4',
  card: '#FFFFFF',
  success: '#059669',
  successBg: '#ECFDF5',
  successBorder: 'rgba(5,150,105,0.25)',
  danger: '#DC2626',
  dangerBg: '#FEF2F2',
  dangerBorder: 'rgba(220,38,38,0.2)',
  amber: '#B45309',
  amberBg: '#FFFBEB',
  amberBorder: 'rgba(217,119,6,0.25)',
};

const SIDEBAR_W = 216;
const CONTENT_W = BROWSER_W - SIDEBAR_W;

// ——— Shared: Chip ———

type ChipVariant = 'default' | 'secondary' | 'outline' | 'destructive' | 'success' | 'amber';

const CHIP_STYLES: Record<ChipVariant, React.CSSProperties> = {
  default:     { background: C.primary, color: C.primaryFg },
  secondary:   { background: C.muted, color: C.textMuted },
  outline:     { background: 'transparent', color: C.text, border: `1px solid ${C.border}` },
  destructive: { background: C.dangerBg, color: C.danger },
  success:     { background: C.successBg, color: C.success },
  amber:       { background: C.amberBg, color: C.amber, border: `1px solid ${C.amberBorder}` },
};

function Chip({ v, children }: { v: ChipVariant; children: React.ReactNode }) {
  return (
    <span style={{
      fontSize: 10, fontWeight: 500, padding: '2px 7px', borderRadius: 5,
      display: 'inline-flex', alignItems: 'center', whiteSpace: 'nowrap',
      ...CHIP_STYLES[v],
    }}>
      {children}
    </span>
  );
}

// ——— Overview ———

function OverviewContent() {
  const metrics = [
    { label: 'Total Leads', value: '24', sub: 'in the database', icon: '👥', warn: false },
    { label: 'Pending Approvals', value: '2', sub: 'emails to review', icon: '✓', warn: true },
    { label: 'Tasks Due', value: '3', sub: '2 today', icon: '☑', warn: false },
  ];

  const funnel = [
    { label: 'New',       count: 5,  bg: C.muted,        fg: C.textMuted },
    { label: 'Enriched',  count: 7,  bg: '#EDE9FE',      fg: '#5B21B6'  },
    { label: 'Contacted', count: 8,  bg: '#DBEAFE',      fg: '#1D4ED8'  },
    { label: 'Replied',   count: 3,  bg: '#D1FAE5',      fg: '#065F46'  },
    { label: 'Converted', count: 1,  bg: C.successBg,    fg: C.success  },
  ];

  return (
    <div style={{ padding: '26px 30px', overflowY: 'auto', height: '100%', boxSizing: 'border-box' }}>
      <h1 style={{ fontSize: 21, fontWeight: 700, color: C.text, margin: '0 0 3px', letterSpacing: -0.4 }}>
        Overview
      </h1>
      <p style={{ fontSize: 13, color: C.textMuted, margin: '0 0 22px' }}>
        Your CRM, accessible to Claude via MCP.
      </p>

      <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: 12, marginBottom: 22 }}>
        {metrics.map((m) => (
          <div key={m.label} style={{
            background: C.card,
            border: `1px solid ${m.warn ? C.amberBorder : C.border}`,
            borderRadius: 9, padding: '16px 15px',
            boxShadow: '0 1px 2px rgba(0,0,0,0.03)',
          }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: 9 }}>
              <p style={{ fontSize: 11, fontWeight: 500, color: C.textMuted, margin: 0 }}>{m.label}</p>
              <span style={{ fontSize: 13, color: C.textLight }}>{m.icon}</span>
            </div>
            <p style={{ fontSize: 24, fontWeight: 700, color: m.warn ? C.amber : C.text, margin: '0 0 2px', letterSpacing: -0.5 }}>
              {m.value}
            </p>
            <p style={{ fontSize: 11, color: C.textLight, margin: 0 }}>{m.sub}</p>
          </div>
        ))}
      </div>

      {/* Funnel */}
      <div style={{ border: `1px solid ${C.border}`, borderRadius: 9, padding: '16px 18px', marginBottom: 18 }}>
        <p style={{ fontSize: 10, fontWeight: 600, color: C.textMuted, margin: '0 0 12px', textTransform: 'uppercase', letterSpacing: '0.09em' }}>
          Lead pipeline
        </p>
        <div style={{ display: 'flex', alignItems: 'center', gap: 5 }}>
          {funnel.map((s, i, arr) => (
            <div key={s.label} style={{ display: 'flex', alignItems: 'center', gap: 5, flex: 1 }}>
              <div style={{ flex: 1, background: s.bg, borderRadius: 6, padding: '7px 8px', textAlign: 'center' }}>
                <p style={{ fontSize: 17, fontWeight: 700, color: s.fg, margin: '0 0 1px' }}>{s.count}</p>
                <p style={{ fontSize: 9, color: s.fg, margin: 0, opacity: 0.75 }}>{s.label}</p>
              </div>
              {i < arr.length - 1 && (
                <span style={{ fontSize: 11, color: C.textLight, flexShrink: 0 }}>→</span>
              )}
            </div>
          ))}
        </div>
      </div>

      <div style={{ display: 'flex', gap: 8 }}>
        <button style={{
          background: C.primary, color: C.primaryFg,
          border: 'none', borderRadius: 7, padding: '8px 15px',
          fontSize: 12, fontWeight: 600, cursor: 'pointer', fontFamily: 'inherit',
        }}>
          🔑 Manage API keys
        </button>
        <button style={{
          background: 'transparent', color: C.text,
          border: `1px solid ${C.border}`, borderRadius: 7, padding: '8px 15px',
          fontSize: 12, fontWeight: 600, cursor: 'pointer', fontFamily: 'inherit',
        }}>
          👥 View leads
        </button>
      </div>
    </div>
  );
}

// ——— Leads ———

type LeadStatus = 'new' | 'enriched' | 'contacted' | 'replied' | 'converted' | 'rejected';

const LEAD_CHIP: Record<LeadStatus, ChipVariant> = {
  new: 'secondary', enriched: 'outline', contacted: 'default',
  replied: 'success', converted: 'success', rejected: 'destructive',
};

const LEADS = [
  { business_name: 'TechCorp SAS',          industry: 'Technology',  instagram: 'techcorpsa',    email: 'hola@techcorp.co',    lead_score: 78, status: 'contacted' as LeadStatus },
  { business_name: 'Consultora ABC',         industry: 'Services',    instagram: null,             email: 'abc@consultora.co',   lead_score: 92, status: 'replied'   as LeadStatus },
  { business_name: 'Muebles López',          industry: 'Retail',      instagram: 'muebleslopez',  email: null,                  lead_score: 45, status: 'enriched'  as LeadStatus },
  { business_name: 'Software del Norte',     industry: 'Technology',  instagram: 'softnorte',     email: null,                  lead_score: 67, status: 'contacted' as LeadStatus },
  { business_name: 'Panadería El Sol',       industry: 'Food & Bev',  instagram: 'panadelsal',    email: null,                  lead_score: 71, status: 'contacted' as LeadStatus },
  { business_name: 'Distribuciones Gómez',  industry: 'Distribution',instagram: 'distgomez',     email: null,                  lead_score: 23, status: 'new'       as LeadStatus },
];

function LeadsContent() {
  const grid: React.CSSProperties = { display: 'grid', gridTemplateColumns: '2fr 1.1fr 1.2fr 1.2fr 58px 1fr' };

  return (
    <div style={{ padding: '26px 30px', overflowY: 'auto', height: '100%', boxSizing: 'border-box' }}>
      <h1 style={{ fontSize: 21, fontWeight: 700, color: C.text, margin: '0 0 3px', letterSpacing: -0.4 }}>Leads</h1>
      <p style={{ fontSize: 13, color: C.textMuted, margin: '0 0 18px' }}>
        {LEADS.length} leads in the database
      </p>

      <div style={{ border: `1px solid ${C.border}`, borderRadius: 9, overflow: 'hidden', boxShadow: '0 1px 2px rgba(0,0,0,0.04)' }}>
        <div style={{ ...grid, padding: '9px 14px', background: C.muted, borderBottom: `1px solid ${C.border}` }}>
          {['Business', 'Industry', 'Instagram', 'Email', 'Score', 'Status'].map((h) => (
            <p key={h} style={{ fontSize: 9.5, fontWeight: 600, color: C.textMuted, margin: 0, textTransform: 'uppercase', letterSpacing: '0.07em' }}>
              {h}
            </p>
          ))}
        </div>
        {LEADS.map((l, i) => (
          <div key={l.business_name} style={{
            ...grid, padding: '11px 14px', alignItems: 'center',
            borderBottom: i < LEADS.length - 1 ? `1px solid ${C.borderFaint}` : 'none',
          }}>
            <p style={{ fontSize: 12, fontWeight: 600, color: C.text, margin: 0 }}>{l.business_name}</p>
            <p style={{ fontSize: 12, color: C.textMuted, margin: 0 }}>{l.industry}</p>
            <p style={{ fontSize: 11, color: C.textMuted, margin: 0, fontFamily: 'monospace' }}>
              {l.instagram ? `@${l.instagram}` : '—'}
            </p>
            <p style={{ fontSize: 11, color: C.textMuted, margin: 0, overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
              {l.email ?? '—'}
            </p>
            <p style={{ fontSize: 12, fontWeight: 700, fontFamily: 'monospace', color: C.text, margin: 0 }}>
              {l.lead_score}
            </p>
            <Chip v={LEAD_CHIP[l.status]}>{l.status}</Chip>
          </div>
        ))}
      </div>
    </div>
  );
}

// ——— Approvals ———

interface EmailDraft {
  id: string;
  to: string;
  subject: string;
  body: string;
  agent: string;
  timeAgo: string;
  leadName: string;
  leadIndustry: string;
}

const DRAFTS: EmailDraft[] = [
  {
    id: 'ap-1',
    to: 'contacto@muebleslopez.co',
    subject: 'Gestión sin planillas — ASOS',
    body: `Hola Juan,

Vi el perfil de Muebles López en Instagram y noté que gestionan su pipeline manualmente.

Con ASOS, tu equipo de ventas podría automatizar el seguimiento de clientes y escalar outreach — sin una sola planilla.

¿Tenés 15 minutos esta semana para una demo?

— Agente ASOS`,
    agent: 'claude-agent',
    timeAgo: '5 min ago',
    leadName: 'Muebles López',
    leadIndustry: 'Retail',
  },
  {
    id: 'ap-2',
    to: '@distgomez (DM)',
    subject: 'Automatizá tu pipeline de ventas',
    body: `Hola María,

Buscando distribuidoras en Bogotá encontré Distribuciones Gómez — impresionante el crecimiento este año.

Me imagino que el equipo comercial hace mucho seguimiento manual. ASOS se encarga de eso.

¿Charlamos?

— Agente ASOS`,
    agent: 'claude-agent',
    timeAgo: '12 min ago',
    leadName: 'Distribuciones Gómez',
    leadIndustry: 'Distribution',
  },
];

type Decision = 'pending' | 'approved' | 'rejected';

function ApprovalsContent() {
  const [decisions, setDecisions] = useState<Record<string, Decision>>({
    'ap-1': 'pending',
    'ap-2': 'pending',
  });

  const decide = (id: string, d: Decision) =>
    setDecisions((prev) => ({ ...prev, [id]: d }));

  const pendingCount = Object.values(decisions).filter((d) => d === 'pending').length;

  return (
    <div style={{ padding: '26px 30px', overflowY: 'auto', height: '100%', boxSizing: 'border-box' }}>
      <h1 style={{ fontSize: 21, fontWeight: 700, color: C.text, margin: '0 0 3px', letterSpacing: -0.4 }}>Approvals</h1>
      <p style={{ fontSize: 13, color: C.textMuted, margin: '0 0 14px' }}>
        {pendingCount > 0
          ? `${pendingCount} email${pendingCount > 1 ? 's' : ''} waiting for your review`
          : 'All caught up — nothing pending.'}
      </p>

      {pendingCount > 0 && (
        <div style={{
          background: C.amberBg, border: `1px solid ${C.amberBorder}`,
          borderRadius: 7, padding: '9px 13px', marginBottom: 16,
          fontSize: 12, color: C.amber, fontWeight: 500,
          display: 'flex', alignItems: 'center', gap: 6,
        }}>
          ⚠ Claude drafted {pendingCount} email{pendingCount > 1 ? 's' : ''} — review before they go out
        </div>
      )}

      <div style={{ display: 'flex', flexDirection: 'column', gap: 13 }}>
        {DRAFTS.map((a) => {
          const d = decisions[a.id];
          return (
            <div key={a.id} style={{
              border: `1px solid ${d === 'approved' ? C.successBorder : d === 'rejected' ? C.dangerBorder : C.border}`,
              borderRadius: 9, padding: '15px 16px',
              background: d === 'approved' ? '#F8FFFE' : d === 'rejected' ? '#FFF8F8' : C.card,
              boxShadow: '0 1px 2px rgba(0,0,0,0.04)',
            }}>
              {/* Header row */}
              <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', marginBottom: 11 }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                  <Chip v="secondary">send_email</Chip>
                  <Chip v={d === 'approved' ? 'success' : d === 'rejected' ? 'destructive' : 'amber'}>{d}</Chip>
                  <span style={{ fontSize: 11, color: C.textLight }}>by {a.agent} · {a.timeAgo}</span>
                </div>
                {d === 'pending' ? (
                  <div style={{ display: 'flex', gap: 6 }}>
                    <button
                      onClick={() => decide(a.id, 'rejected')}
                      style={{
                        background: 'transparent', color: C.text,
                        border: `1px solid ${C.border}`, borderRadius: 6,
                        padding: '5px 11px', fontSize: 11, fontWeight: 600,
                        cursor: 'pointer', fontFamily: 'inherit',
                      }}
                    >
                      ✕ Reject
                    </button>
                    <button
                      onClick={() => decide(a.id, 'approved')}
                      style={{
                        background: C.primary, color: C.primaryFg,
                        border: 'none', borderRadius: 6,
                        padding: '5px 11px', fontSize: 11, fontWeight: 600,
                        cursor: 'pointer', fontFamily: 'inherit',
                      }}
                    >
                      ✓ Approve &amp; send
                    </button>
                  </div>
                ) : (
                  <span style={{ fontSize: 12, fontWeight: 600, color: d === 'approved' ? C.success : C.danger }}>
                    {d === 'approved' ? '✓ Queued for sending' : '✕ Rejected'}
                  </span>
                )}
              </div>

              {/* Email content */}
              <p style={{ fontSize: 11, color: C.textMuted, margin: '0 0 3px' }}>
                To: <span style={{ fontFamily: 'monospace' }}>{a.to}</span>
                <span style={{ marginLeft: 10, color: C.textLight }}>
                  Lead: {a.leadName} · {a.leadIndustry}
                </span>
              </p>
              <p style={{ fontSize: 13, fontWeight: 600, color: C.text, margin: '3px 0 8px' }}>{a.subject}</p>
              <pre style={{
                fontSize: 11, lineHeight: 1.6, color: C.textMuted,
                background: C.muted, padding: '9px 12px', borderRadius: 6,
                margin: 0, whiteSpace: 'pre-wrap', fontFamily: 'inherit',
                maxHeight: 108, overflowY: 'auto',
              }}>
                {a.body}
              </pre>
            </div>
          );
        })}
      </div>
    </div>
  );
}

// ——— Tasks ———

type TaskStatus = 'pending' | 'sent' | 'responded' | 'no_response' | 'skipped';

const TASK_CHIP: Record<TaskStatus, ChipVariant> = {
  pending: 'secondary', sent: 'success', responded: 'success',
  no_response: 'outline', skipped: 'destructive',
};

const CHAN_CHIP: Record<string, ChipVariant> = {
  instagram: 'secondary', email: 'outline', linkedin: 'default',
};

const TASKS = [
  {
    id: 't-1', channel: 'instagram', touch: 1, status: 'pending' as TaskStatus,
    lead: 'Muebles López', handle: 'muebleslopez', due: 'today',
    draft: 'Hola Juan! Vi que Muebles López tiene una tienda increíble en Bogotá. Quería comentarles algo que podría ayudar al equipo de ventas. ¿Tienen 5 min?',
  },
  {
    id: 't-2', channel: 'email', touch: 2, status: 'sent' as TaskStatus,
    lead: 'TechCorp SAS', handle: null, due: null,
    draft: 'Hola equipo TechCorp,\n\nComo seguimiento a mi mensaje de la semana pasada: ¿pudieron revisar la demo de ASOS? Quedo atento.\n\n— Agente ASOS',
  },
  {
    id: 't-3', channel: 'instagram', touch: 1, status: 'pending' as TaskStatus,
    lead: 'Distribuciones Gómez', handle: 'distgomez', due: 'tomorrow',
    draft: 'Hola María, soy el agente de ASOS. Vi que Distribuciones Gómez está creciendo rápido — quería comentarles algo que les puede ayudar con el pipeline de ventas.',
  },
  {
    id: 't-4', channel: 'email', touch: 1, status: 'no_response' as TaskStatus,
    lead: 'Panadería El Sol', handle: 'panadelsal', due: null,
    draft: 'Hola,\n\nLes escribo de parte de ASOS. Notamos que Panadería El Sol tiene presencia activa en redes — ¿han pensado en automatizar el seguimiento de clientes B2B?',
  },
];

function TasksContent() {
  return (
    <div style={{ padding: '26px 30px', overflowY: 'auto', height: '100%', boxSizing: 'border-box' }}>
      <h1 style={{ fontSize: 21, fontWeight: 700, color: C.text, margin: '0 0 3px', letterSpacing: -0.4 }}>Tasks</h1>
      <p style={{ fontSize: 13, color: C.textMuted, margin: '0 0 18px' }}>
        {TASKS.length} outreach tasks
      </p>

      <div style={{ display: 'flex', flexDirection: 'column', gap: 11 }}>
        {TASKS.map((t) => (
          <div key={t.id} style={{
            border: `1px solid ${C.border}`, borderRadius: 9,
            padding: '13px 15px', background: C.card,
            boxShadow: '0 1px 2px rgba(0,0,0,0.03)',
          }}>
            <div style={{ display: 'flex', alignItems: 'center', gap: 6, marginBottom: 7 }}>
              <Chip v={CHAN_CHIP[t.channel] ?? 'outline'}>{t.channel}</Chip>
              <Chip v="outline">touch #{t.touch}</Chip>
              <Chip v={TASK_CHIP[t.status]}>{t.status.replace('_', ' ')}</Chip>
              {t.due && <span style={{ fontSize: 11, color: C.textLight }}>due {t.due}</span>}
            </div>
            <p style={{ fontSize: 13, fontWeight: 600, color: C.text, margin: '0 0 7px' }}>
              {t.lead}
              {t.handle && (
                <span style={{ fontWeight: 400, color: C.textMuted, marginLeft: 5, fontFamily: 'monospace', fontSize: 11 }}>
                  @{t.handle}
                </span>
              )}
            </p>
            <pre style={{
              fontSize: 11, lineHeight: 1.55, color: C.textMuted,
              background: C.muted, padding: '8px 11px', borderRadius: 6,
              margin: 0, whiteSpace: 'pre-wrap', fontFamily: 'inherit',
            }}>
              {t.draft}
            </pre>
          </div>
        ))}
      </div>
    </div>
  );
}

// ——— Sidebar ———

const NAV_ITEMS = [
  { id: 'overview',      label: 'Overview',      icon: '⊞', badge: '' },
  { id: 'projects',      label: 'Projects',      icon: '📁', badge: '' },
  { id: 'leads',         label: 'Leads',         icon: '👥', badge: '' },
  { id: 'tasks',         label: 'Tasks',         icon: '☑',  badge: '' },
  { id: 'approvals',     label: 'Approvals',     icon: '✓',  badge: '2' },
  { id: 'interactions',  label: 'Interactions',  icon: '💬', badge: '' },
  { id: 'api-keys',      label: 'API Keys',      icon: '🔑', badge: '' },
];

function Sidebar({ activeScreen }: { activeScreen: string }) {
  return (
    <div style={{
      width: SIDEBAR_W, height: BROWSER_H, flexShrink: 0,
      background: C.sidebarBg, borderRight: `1px solid ${C.border}`,
      display: 'flex', flexDirection: 'column',
    }}>
      <div style={{ padding: '18px 18px 13px', borderBottom: `1px solid ${C.border}` }}>
        <p style={{ fontSize: 15, fontWeight: 700, color: C.text, margin: '0 0 2px', letterSpacing: -0.3 }}>ASOS</p>
        <p style={{ fontSize: 10, color: C.textLight, margin: 0 }}>CRM for Claude Code</p>
      </div>

      <nav style={{ flex: 1, padding: '9px 7px' }}>
        {NAV_ITEMS.map((item) => {
          const active = activeScreen === item.id;
          return (
            <div key={item.id} style={{
              display: 'flex', alignItems: 'center', gap: 8,
              padding: '7px 9px', borderRadius: 7, marginBottom: 1,
              background: active ? C.mutedDarker : 'transparent',
              cursor: 'default',
            }}>
              <span style={{ fontSize: 13, width: 16, textAlign: 'center', flexShrink: 0 }}>{item.icon}</span>
              <span style={{ flex: 1, fontSize: 12, fontWeight: active ? 600 : 400, color: active ? C.text : C.textMuted }}>
                {item.label}
              </span>
              {item.badge && !active && (
                <span style={{
                  fontSize: 9, fontWeight: 700,
                  background: C.primary, color: C.primaryFg,
                  borderRadius: 999, padding: '1px 5px',
                }}>
                  {item.badge}
                </span>
              )}
            </div>
          );
        })}
      </nav>

      <div style={{ padding: '11px 13px', borderTop: `1px solid ${C.border}`, display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 7 }}>
          <div style={{
            width: 25, height: 25, borderRadius: 7, background: C.primary,
            display: 'flex', alignItems: 'center', justifyContent: 'center',
            fontSize: 10, color: '#fff', fontWeight: 700, flexShrink: 0,
          }}>
            D
          </div>
          <p style={{ fontSize: 11, fontWeight: 600, color: C.text, margin: 0 }}>Darien H.</p>
        </div>
        <span style={{ fontSize: 9.5, color: C.textLight }}>v0.0.1</span>
      </div>
    </div>
  );
}

// ——— Root ———

export function AsosSimulation({ screen = 'overview' }: { screen?: string }) {
  return (
    <div style={{
      width: BROWSER_W, height: BROWSER_H,
      fontFamily: 'system-ui, -apple-system, "Segoe UI", sans-serif',
      display: 'flex', overflow: 'hidden',
    }}>
      <Sidebar activeScreen={screen} />
      <div style={{ width: CONTENT_W, height: BROWSER_H, background: C.bg, overflow: 'hidden' }}>
        {screen === 'leads'     && <LeadsContent />}
        {screen === 'approvals' && <ApprovalsContent />}
        {screen === 'tasks'     && <TasksContent />}
        {!['leads', 'approvals', 'tasks'].includes(screen) && <OverviewContent />}
      </div>
    </div>
  );
}
