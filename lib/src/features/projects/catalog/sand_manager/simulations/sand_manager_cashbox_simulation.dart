import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../views/shared/sand_manager_theme.dart';
import '../state/sand_manager_state.dart';

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

/// Dashboard screen showing live transactions — shown in its own device mockup (Web/Admin style).
class CashboxDashboardScreen extends ConsumerWidget {
  const CashboxDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(watchCashFlowSummaryProvider(const CashFlowParams()));
    final transactionsAsync = ref.watch(watchCashTransactionsProvider(const CashFlowParams()));
    
    final currencyFormat = NumberFormat.currency(locale: 'es_CO', symbol: '\$', decimalDigits: 0);
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      backgroundColor: AppDesignSystem.backgroundVariant,
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: AppDesignSystem.deepBlack,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'SAND MANAGER\nADMIN',
                    style: TextStyle(
                      color: AppDesignSystem.pureWhite,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _buildSidebarItem(Icons.dashboard, 'DASHBOARD', true),
                _buildSidebarItem(Icons.payments, 'FLUJO DE CAJA', false),
                _buildSidebarItem(Icons.shopping_cart, 'VENTAS', false),
                _buildSidebarItem(Icons.inventory_2, 'INVENTARIO', false),
                _buildSidebarItem(Icons.people, 'CLIENTES', false),
                const Spacer(),
                _buildSidebarItem(Icons.settings, 'AJUSTES', false),
                _buildSidebarItem(Icons.logout, 'SALIR', false),
                const SizedBox(height: 24),
              ],
            ),
          ),
          
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Topbar
                Container(
                  height: 70,
                  color: AppDesignSystem.pureWhite,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: const Row(
                    children: [
                      Text(
                        'Resumen Financiero',
                        style: TextStyle(
                          color: AppDesignSystem.deepBlack,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.search, color: AppDesignSystem.deepBlack),
                      SizedBox(width: 16),
                      Icon(Icons.notifications_none, color: AppDesignSystem.deepBlack),
                      SizedBox(width: 24),
                      CircleAvatar(
                        backgroundColor: AppDesignSystem.impactOrange,
                        child: Text('AD', style: TextStyle(fontWeight: FontWeight.bold, color: AppDesignSystem.deepBlack)),
                      ),
                    ],
                  ),
                ),
                // Dashboard Body
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // KPIs
                        summaryAsync.when(
                          data: (summary) => Row(
                            children: [
                              Expanded(child: _buildKpiCard('BALANCE NETO', summary.netFlow, AppDesignSystem.impactOrange, currencyFormat)),
                              const SizedBox(width: 16),
                              Expanded(child: _buildKpiCard('INGRESOS', summary.totalPaidIncome, AppDesignSystem.statusSuccess, currencyFormat)),
                              const SizedBox(width: 16),
                              Expanded(child: _buildKpiCard('EGRESOS', summary.totalPaidExpense, AppDesignSystem.statusError, currencyFormat)),
                            ],
                          ),
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (_, _) => const SizedBox(),
                        ),
                        
                        const SizedBox(height: 32),
                        const Text(
                          'ÚLTIMAS TRANSACCIONES',
                          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppDesignSystem.deepBlack),
                        ),
                        const SizedBox(height: 16),
                        
                        // Transactions Table
                        transactionsAsync.when(
                          data: (transactions) => ImpactCard(
                            backgroundColor: AppDesignSystem.pureWhite,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: transactions.length,
                              separatorBuilder: (_, _) => const Divider(height: 1, color: AppDesignSystem.backgroundVariant),
                              itemBuilder: (context, index) {
                                final t = transactions[index];
                                final isIncome = t.type == CashTransactionType.income;
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: isIncome ? AppDesignSystem.statusSuccess.withValues(alpha: 0.1) : AppDesignSystem.statusError.withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          isIncome ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                                          color: isIncome ? AppDesignSystem.statusSuccess : AppDesignSystem.statusError,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          t.description.toUpperCase(),
                                          style: const TextStyle(fontWeight: FontWeight.w900, color: AppDesignSystem.deepBlack),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          dateFormat.format(t.date),
                                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          t.methodName ?? 'N/A',
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                        currencyFormat.format(t.amount),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,
                                          color: isIncome ? AppDesignSystem.statusSuccess : AppDesignSystem.statusError,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (_, _) => const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(IconData icon, String label, bool isSelected) {
    return Container(
      color: isSelected ? AppDesignSystem.impactOrange : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: isSelected ? AppDesignSystem.deepBlack : AppDesignSystem.pureWhite, size: 20),
          const SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? AppDesignSystem.deepBlack : AppDesignSystem.pureWhite,
              fontWeight: FontWeight.w900,
              fontSize: 12,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiCard(String title, double amount, Color brandColor, NumberFormat currencyFormat) {
    return ImpactCard(
      backgroundColor: AppDesignSystem.pureWhite,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 12,
                color: AppDesignSystem.deepBlack.withValues(alpha: 0.6),
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 16),
            FittedBox(
              child: Text(
                currencyFormat.format(amount),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                  color: brandColor == AppDesignSystem.impactOrange ? AppDesignSystem.deepBlack : brandColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
