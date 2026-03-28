import 'package:flutter/material.dart';
import '../views/shared/sand_manager_theme.dart';

class SandManagerClientsSimulation extends StatelessWidget {
  final bool showAppBar;
  const SandManagerClientsSimulation({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesignSystem.backgroundVariant(context),
      appBar: showAppBar
          ? AppBar(
              title: const Text(
                'CLIENTES',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              backgroundColor: AppDesignSystem.pureWhite(context),
              foregroundColor: AppDesignSystem.deepBlack(context),
              elevation: 0,
              actions: [
                IconButton(icon: const Icon(Icons.search), onPressed: () {}),
                IconButton(icon: const Icon(Icons.add), onPressed: () {}),
              ],
            )
          : null,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _mockClients.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final client = _mockClients[index];
          return ImpactCard(
            backgroundColor: AppDesignSystem.pureWhite(context),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: AppDesignSystem.deepBlack(context),
                child: Text(
                  client.name.substring(0, 1),
                  style: TextStyle(
                    color: AppDesignSystem.pureWhite(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                client.name,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: AppDesignSystem.deepBlack(context),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Tel: ${client.phone}'),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'DEUDA',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${client.debt}',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: client.debt > 0
                          ? AppDesignSystem.statusError
                          : AppDesignSystem.statusSuccess,
                      fontSize: 16,
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

class _MockClient {
  final String name;
  final String phone;
  final double debt;
  _MockClient(this.name, this.phone, this.debt);
}

final _mockClients = [
  _MockClient('Constructora Alfa S.A.S', '3001234567', 1500000),
  _MockClient('Juan Pérez (Independiente)', '3109876543', 0),
  _MockClient('Público General', 'N/A', 0),
  _MockClient('Ferretería El Tornillo', '3205554433', 450000),
];
