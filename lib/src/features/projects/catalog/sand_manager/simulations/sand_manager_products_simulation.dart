import 'package:flutter/material.dart';
import '../views/shared/sand_manager_theme.dart';

class SandManagerProductsSimulation extends StatelessWidget {
  final bool showAppBar;
  const SandManagerProductsSimulation({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesignSystem.backgroundVariant(context),
      appBar: showAppBar
          ? AppBar(
              title: const Text(
                'MATERIALES',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              backgroundColor: AppDesignSystem.pureWhite(context),
              foregroundColor: AppDesignSystem.deepBlack(context),
              elevation: 0,
              actions: [
                IconButton(icon: const Icon(Icons.add), onPressed: () {}),
              ],
            )
          : null,
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: _mockProducts.length,
        itemBuilder: (context, index) {
          final product = _mockProducts[index];
          return ImpactCard(
            backgroundColor: AppDesignSystem.pureWhite(context),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: AppDesignSystem.backgroundVariant(context),
                      child: Center(
                        child: Icon(
                          Icons.landscape,
                          size: 48,
                          color: AppDesignSystem.deepBlack(context),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: AppDesignSystem.deepBlack(context),
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price} / ${product.unit}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppDesignSystem.impactOrange,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MockProduct {
  final String name;
  final double price;
  final String unit;
  _MockProduct(this.name, this.price, this.unit);
}

final _mockProducts = [
  _MockProduct('Arena Fina Lavada', 45000, 'm³'),
  _MockProduct('Arena Gruesa', 38000, 'm³'),
  _MockProduct('Gravilla 1/2', 55000, 'm³'),
  _MockProduct('Piedra Filtro', 40000, 'm³'),
  _MockProduct('Base Granular', 35000, 'm³'),
  _MockProduct('Recebo', 25000, 'm³'),
];
