'use client';

import { SandManagerSimulation } from './SandManagerSimulation';
import { NoPreguntesSimulation } from './NoPreguntesSimulation';
import { ArcinusSimulation } from './ArcinusSimulation';
import { AsosSimulation } from './AsosSimulation';
import { JardinSimulation } from './JardinSimulation';

const SIMULATIONS: Record<string, React.ComponentType> = {
  'sand-manager': SandManagerSimulation,
  'no-preguntes': NoPreguntesSimulation,
  'arcinus': ArcinusSimulation,
  'asos': AsosSimulation,
  'jardin': JardinSimulation,
};

export function SimulationWrapper({ projectId }: { projectId: string }) {
  const Simulation = SIMULATIONS[projectId];
  if (!Simulation) return null;
  return <Simulation />;
}
