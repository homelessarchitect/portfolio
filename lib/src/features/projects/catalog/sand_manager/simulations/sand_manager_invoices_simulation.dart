import 'package:flutter/material.dart';
import '../views/shared/sand_manager_theme.dart';

class SandManagerInvoicesSimulation extends StatelessWidget {
  const SandManagerInvoicesSimulation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesignSystem.backgroundVariant,
      appBar: AppBar(
        title: const Text('FACTURACIÓN', style: TextStyle(fontWeight: FontWeight.w900)),
        backgroundColor: AppDesignSystem.pureWhite,
        foregroundColor: AppDesignSystem.deepBlack,
        elevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _mockInvoices.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final invoice = _mockInvoices[index];
          return ImpactCard(
            backgroundColor: AppDesignSystem.pureWhite,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Icon(
                invoice.isIssued ? Icons.receipt_long : Icons.pending_actions,
                color: invoice.isIssued ? AppDesignSystem.statusSuccess : AppDesignSystem.impactOrange,
                size: 32,
              ),
              title: Text(
                'FACTURA #${invoice.number}',
                style: const TextStyle(fontWeight: FontWeight.w900, color: AppDesignSystem.deepBlack),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(invoice.clientName),
                  Text(invoice.date.substring(0, 10)),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${invoice.total}',
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppDesignSystem.deepBlack),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    color: invoice.isIssued ? AppDesignSystem.statusSuccess : AppDesignSystem.backgroundVariant,
                    child: Text(
                      invoice.isIssued ? 'EMITIDA' : 'PENDIENTE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: invoice.isIssued ? AppDesignSystem.pureWhite : AppDesignSystem.deepBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppDesignSystem.deepBlack,
        foregroundColor: AppDesignSystem.pureWhite,
        shape: const RoundedRectangleBorder(),
        icon: const Icon(Icons.flash_on),
        label: const Text('EMITIR DIAN', style: TextStyle(fontWeight: FontWeight.w900)),
      ),
    );
  }
}

class _MockInvoice {
  final String number;
  final String clientName;
  final double total;
  final String date;
  final bool isIssued;
  _MockInvoice(this.number, this.clientName, this.total, this.date, this.isIssued);
}

final _mockInvoices = [
  _MockInvoice('1045', 'Constructora Alfa S.A.S', 2500000, '2024-03-22T10:00', true),
  _MockInvoice('1046', 'Juan Pérez', 450000, '2024-03-22T11:30', true),
  _MockInvoice('1047', 'Público General', 120000, '2024-03-22T14:15', false),
  _MockInvoice('1048', 'Ferretería El Tornillo', 850000, '2024-03-22T15:00', false),
];
