import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../views/shared/sand_manager_theme.dart';
import '../state/sand_manager_state.dart';

/// Form screen for creating sales — shown in its own device mockup.
class SaleFormScreen extends StatelessWidget {
  const SaleFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesignSystem.backgroundVariant,
      appBar: AppBar(
        backgroundColor: AppDesignSystem.backgroundVariant,
        elevation: 0,
        title: const Text(
          'NUEVA VENTA',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: AppDesignSystem.deepBlack,
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: _MockSaleForm(),
      ),
    );
  }
}

/// List screen showing recent sales — shown in its own device mockup.
class SaleListScreen extends StatelessWidget {
  const SaleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MockSaleListScreen();
  }
}

class _MockSaleForm extends ConsumerStatefulWidget {
  const _MockSaleForm();

  @override
  ConsumerState<_MockSaleForm> createState() => _MockSaleFormState();
}

class _MockSaleFormState extends ConsumerState<_MockSaleForm> {
  final _formKey = GlobalKey<FormState>();
  final _clientController = TextEditingController(text: "Cliente Demo");
  final _totalController = TextEditingController(text: "1500000");
  MockSaleStatus _status = MockSaleStatus.paid;

  @override
  void dispose() {
    _clientController.dispose();
    _totalController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_totalController.text) ?? 0.0;
    final clientName = _clientController.text.trim();

    final sale = MockSale(
      id: (DateTime.now().millisecondsSinceEpoch % 10000).toString(),
      clientName: clientName.isEmpty ? 'PÚBLICO GENERAL' : clientName,
      date: DateTime.now(),
      total: amount,
      status: _status,
    );

    ref.read(mockSalesNotifierProvider.notifier).addSale(sale);

    _totalController.clear();
    _clientController.clear();
    setState(() {
      _status = MockSaleStatus.paid;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Venta Registrada Exitosamente"),
        backgroundColor: AppDesignSystem.statusSuccess,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ImpactCard(
      backgroundColor: AppDesignSystem.pureWhite,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "NUEVA VENTA",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: AppDesignSystem.deepBlack,
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _clientController,
                label: 'CLIENTE',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _totalController,
                label: 'TOTAL (COP)',
                icon: Icons.payments,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildStatusDropdown(),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppDesignSystem.impactOrange,
                    foregroundColor: AppDesignSystem.deepBlack,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(
                        color: AppDesignSystem.deepBlack,
                        width: 4,
                      ),
                    ),
                  ),
                  child: const Text(
                    'REGISTRAR VENTA',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 12,
            letterSpacing: 1.0,
            color: AppDesignSystem.deepBlack,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          cursorColor: AppDesignSystem.deepBlack,
          style: const TextStyle(fontWeight: FontWeight.bold),
          validator: (v) => v!.isEmpty ? "Requerido" : null,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppDesignSystem.deepBlack),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppDesignSystem.deepBlack,
                width: 2,
              ),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppDesignSystem.impactOrange,
                width: 3,
              ),
              borderRadius: BorderRadius.zero,
            ),
            filled: true,
            fillColor: AppDesignSystem.backgroundVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ESTADO',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 12,
            letterSpacing: 1.0,
            color: AppDesignSystem.deepBlack,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<MockSaleStatus>(
          isExpanded: true,
          initialValue: _status,
          icon: const Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: AppDesignSystem.deepBlack,
          ),
          items: MockSaleStatus.values.map((s) {
            String label = '';
            switch (s) {
              case MockSaleStatus.paid:
                label = 'PAGADO (CONTADO)';
                break;
              case MockSaleStatus.credit:
                label = 'CRÉDITO';
                break;
              case MockSaleStatus.partial:
                label = 'PAGO PARCIAL';
                break;
              case MockSaleStatus.cancelled:
                label = 'ANULADO';
                break;
            }
            return DropdownMenuItem(value: s, child: Text(label));
          }).toList(),
          onChanged: (val) {
            if (val != null) setState(() => _status = val);
          },
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppDesignSystem.deepBlack,
          ),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppDesignSystem.deepBlack,
                width: 2,
              ),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppDesignSystem.impactOrange,
                width: 3,
              ),
              borderRadius: BorderRadius.zero,
            ),
            filled: true,
            fillColor: AppDesignSystem.backgroundVariant,
          ),
        ),
      ],
    );
  }
}

class _MockSaleListScreen extends ConsumerWidget {
  const _MockSaleListScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final sales = ref.watch(mockSalesNotifierProvider);

    return Scaffold(
      backgroundColor: AppDesignSystem.backgroundVariant,
      appBar: AppBar(
        backgroundColor: AppDesignSystem.backgroundVariant,
        elevation: 0,
        title: Text(
          'VENTAS RECIENTES',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: sales.length,
        separatorBuilder: (_, i) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final sale = sales[index];
          return _SaleCard(sale: sale);
        },
      ),
    );
  }
}

class _SaleCard extends StatelessWidget {
  final MockSale sale;
  const _SaleCard({required this.sale});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 0,
    );

    return ImpactCard(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                sale.clientName.toUpperCase(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 0.5,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            _StatusChip(status: sale.status),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.receipt_long,
                  size: 14,
                  color: AppDesignSystem.deepBlack,
                ),
                const SizedBox(width: 4),
                Text(
                  '#${sale.id} • ${DateFormat('HH:mm').format(sale.date)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppDesignSystem.deepBlack.withValues(alpha: 0.7),
                  ),
                ),
                const Spacer(),
                Text(
                  currencyFormat.format(sale.total),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppDesignSystem.deepBlack,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final MockSaleStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color color;
    String label;

    switch (status) {
      case MockSaleStatus.paid:
        color = AppDesignSystem.statusSuccess;
        label = 'PAGADO';
        break;
      case MockSaleStatus.credit:
        color = AppDesignSystem.impactOrange;
        label = 'CRÉDITO';
        break;
      case MockSaleStatus.partial:
        color = const Color(0xFF0055FF);
        label = 'PARCIAL';
        break;
      case MockSaleStatus.cancelled:
        color = AppDesignSystem.statusError;
        label = 'ANULADO';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: AppDesignSystem.deepBlack, width: 2),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color == AppDesignSystem.impactOrange
              ? AppDesignSystem.deepBlack
              : AppDesignSystem.pureWhite,
          fontWeight: FontWeight.w900,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
