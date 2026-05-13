'use client';

import { SandManagerSimulation } from './SandManagerSimulation';
import { NoPreguntesSimulation } from './NoPreguntesSimulation';
import { ArcinusSimulation } from './ArcinusSimulation';
import { AsosSimulation } from './AsosSimulation';
import { JardinSimulation } from './JardinSimulation';
import { JardinLandingSimulation } from './JardinLandingSimulation';
import { JardinMobileSimulation } from './JardinMobileSimulation';

const SIMULATIONS = {
  'sand-manager': SandManagerSimulation,
  'no-preguntes': NoPreguntesSimulation,
  'arcinus': ArcinusSimulation,
  'asos': AsosSimulation,
  'jardin': JardinSimulation,
  'jardin-app': JardinSimulation,
  'jardin-landing': JardinLandingSimulation,
  'jardin-mobile': JardinMobileSimulation,
} as Record<string, React.ComponentType<{ screen?: string }>>;

interface Props {
  simulationId: string;
  screen?: string;
}

export function SimulationWrapper({ simulationId, screen }: Props) {
  const Simulation = SIMULATIONS[simulationId];
  if (!Simulation) return null;
  return <Simulation screen={screen} />;
}
