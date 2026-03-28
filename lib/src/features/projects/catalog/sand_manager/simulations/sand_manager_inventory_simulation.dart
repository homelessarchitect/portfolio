import 'package:flutter/material.dart';
import '../views/shared/sand_manager_theme.dart';

class SandManagerInventorySimulation extends StatelessWidget {
  final bool showAppBar;
  const SandManagerInventorySimulation({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesignSystem.backgroundVariant(context),
      appBar: showAppBar
          ? AppBar(
              title: const Text(
                'INVENTARIO',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              backgroundColor: AppDesignSystem.pureWhite(context),
              foregroundColor: AppDesignSystem.deepBlack(context),
              elevation: 0,
            )
          : null,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _mockInventory.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _mockInventory[index];
          return ImpactCard(
            backgroundColor: AppDesignSystem.pureWhite(context),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    color: AppDesignSystem.deepBlack(context),
                    child: Icon(
                      Icons.inventory_2,
                      color: AppDesignSystem.pureWhite(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.product,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: AppDesignSystem.deepBlack(context),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('Bodega: ${item.warehouse}'),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: item.current / item.capacity,
                          backgroundColor: AppDesignSystem.backgroundVariant(context),
                          color: item.current < (item.capacity * 0.2)
                              ? AppDesignSystem.statusError
                              : AppDesignSystem.impactOrange,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'STOCK',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${item.current} m³',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: AppDesignSystem.deepBlack(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {},
        backgroundColor: AppDesignSystem.impactOrange,
        foregroundColor: AppDesignSystem.deepBlack(context),
        shape: const RoundedRectangleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _MockInventoryItem {
  final String product;
  final String warehouse;
  final double current;
  final double capacity;
  _MockInventoryItem(this.product, this.warehouse, this.current, this.capacity);
}

final _mockInventory = [
  _MockInventoryItem('Arena Gruesa', 'Principal', 450, 1000),
  _MockInventoryItem('Arena Fina', 'Principal', 120, 800),
  _MockInventoryItem('Gravilla', 'Patio Sur', 890, 1200),
  _MockInventoryItem('Piedra Filtro', 'Patio Norte', 50, 500),
];
