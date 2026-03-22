import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../views/shared/sand_manager_theme.dart';
import '../state/sand_manager_state.dart';
import '../views/sand_manager_mobile_home_view.dart';

/// Form screen for creating expenses — shown in its own device mockup.
class CashboxFormScreen extends StatelessWidget {
  const CashboxFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesignSystem.pureWhite,
      appBar: AppBar(
        backgroundColor: AppDesignSystem.pureWhite,
        elevation: 0,
        title: const Text(
          'NUEVO GASTO',
          style: TextStyle(fontWeight: FontWeight.w900, color: AppDesignSystem.deepBlack),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: _MockExpenseForm(),
      ),
    );
  }
}

/// Dashboard screen showing live transactions — shown in its own device mockup.
class CashboxDashboardScreen extends StatelessWidget {
  const CashboxDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SandManagerMobileHomeView();
  }
}

class _MockExpenseForm extends ConsumerStatefulWidget {
  const _MockExpenseForm();

  @override
  ConsumerState<_MockExpenseForm> createState() => _MockExpenseFormState();
}

class _MockExpenseFormState extends ConsumerState<_MockExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _totalController = TextEditingController(text: "50000");
  final _descController = TextEditingController(text: "Gasto de Prueba");
  PaymentMethod? _selectedMethod;

  @override
  void dispose() {
    _totalController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedMethod == null) return;

    final amount = double.tryParse(_totalController.text) ?? 0.0;
    final desc = _descController.text.trim();

    final tx = CashTransaction(
      type: CashTransactionType.expense,
      description: desc.isEmpty ? 'Gasto Operativo' : desc,
      date: DateTime.now(),
      amount: amount,
      methodName: _selectedMethod!.name,
    );

    ref.read(mockTransactionsNotifierProvider.notifier).addTransaction(tx);

    _totalController.clear();
    _descController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Gasto Registrado Exitosamente"),
        backgroundColor: AppDesignSystem.statusSuccess,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final methodsAsync = ref.watch(paymentMethodsStreamProvider);

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
                "NUEVO GASTO RECURRENTE",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: AppDesignSystem.deepBlack,
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField(
                controller: _totalController,
                label: 'MONTO (COP)',
                icon: Icons.payments,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _descController,
                label: 'DESCRIPCIÓN',
                icon: Icons.notes,
              ),
              const SizedBox(height: 16),
              methodsAsync.when(
                data: (methods) {
                  if (_selectedMethod == null && methods.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _selectedMethod = methods.last;
                      });
                    });
                  }
                  return _buildDropdown(
                    label: 'MÉTODO DE PAGO',
                    value: _selectedMethod,
                    items: methods,
                    onChanged: (val) => setState(() => _selectedMethod = val),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => const Text("Error loading methods"),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppDesignSystem.statusError,
                    foregroundColor: AppDesignSystem.pureWhite,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(color: AppDesignSystem.deepBlack, width: 4),
                    ),
                  ),
                  child: const Text(
                    'REGISTRAR GASTO',
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
          cursorColor: AppDesignSystem.deepBlack,
          style: const TextStyle(fontWeight: FontWeight.bold),
          validator: (v) => v!.isEmpty ? "Requerido" : null,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppDesignSystem.deepBlack),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppDesignSystem.deepBlack, width: 2),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppDesignSystem.impactOrange, width: 3),
              borderRadius: BorderRadius.zero,
            ),
            filled: true,
            fillColor: AppDesignSystem.backgroundVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required PaymentMethod? value,
    required List<PaymentMethod> items,
    required void Function(PaymentMethod?) onChanged,
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
        DropdownButtonFormField<PaymentMethod>(
          isExpanded: true,
          initialValue: value,
          icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: AppDesignSystem.deepBlack),
          items: items.map((m) => DropdownMenuItem(value: m, child: Text(m.name.toUpperCase()))).toList(),
          onChanged: onChanged,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppDesignSystem.deepBlack),
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppDesignSystem.deepBlack, width: 2),
              borderRadius: BorderRadius.zero,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppDesignSystem.impactOrange, width: 3),
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
