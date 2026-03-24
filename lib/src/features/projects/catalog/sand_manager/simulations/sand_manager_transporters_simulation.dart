import 'package:flutter/material.dart';
import '../views/shared/sand_manager_theme.dart';

class SandManagerTransportersSimulation extends StatelessWidget {
  const SandManagerTransportersSimulation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesignSystem.backgroundVariant,
      appBar: AppBar(
        title: const Text('TRANSPORTADORES', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        backgroundColor: AppDesignSystem.pureWhite,
        foregroundColor: AppDesignSystem.deepBlack,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _mockTransporters.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final transporter = _mockTransporters[index];
          return ImpactCard(
            backgroundColor: AppDesignSystem.pureWhite,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Icon(
                Icons.local_shipping,
                size: 32,
                color: transporter.isAvailable ? AppDesignSystem.statusSuccess : AppDesignSystem.impactOrange,
              ),
              title: Text(
                transporter.truckPlate,
                style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: AppDesignSystem.deepBlack),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Conductor: ${transporter.driverName}'),
                  Text('Capacidad: ${transporter.capacity} m³'),
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                color: transporter.isAvailable ? AppDesignSystem.statusSuccess.withValues(alpha: 0.1) : AppDesignSystem.impactOrange.withValues(alpha: 0.1),
                child: Text(
                  transporter.isAvailable ? 'DISPONIBLE' : 'EN RUTA',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: transporter.isAvailable ? AppDesignSystem.statusSuccess : AppDesignSystem.impactOrange,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MockTransporter {
  final String truckPlate;
  final String driverName;
  final double capacity;
  final bool isAvailable;

  _MockTransporter(this.truckPlate, this.driverName, this.capacity, this.isAvailable);
}

final _mockTransporters = [
  _MockTransporter('XYZ-123', 'Carlos Gómez', 15, true),
  _MockTransporter('ABC-987', 'Pedro Martínez', 7, false),
  _MockTransporter('DEF-456', 'Luis Rodríguez', 14, true),
];
