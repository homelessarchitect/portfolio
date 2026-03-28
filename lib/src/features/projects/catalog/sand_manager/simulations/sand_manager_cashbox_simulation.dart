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
      backgroundColor: AppDesignSystem.pureWhite(context),
      appBar: AppBar(
        backgroundColor: AppDesignSystem.pureWhite(context),
        elevation: 0,
        title: Text(
          'NUEVO GASTO',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: AppDesignSystem.deepBlack(context),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: _MockExpenseForm(),
      ),
    );
  }
}

/// Dashboard screen showing live transactions — now mobile-styled for the app.
class CashboxMobileDashboardScreen extends ConsumerWidget {
  const CashboxMobileDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryAsync = ref.watch(
      watchCashFlowSummaryProvider(const CashFlowParams()),
    );
    final transactionsAsync = ref.watch(
      watchCashTransactionsProvider(const CashFlowParams()),
    );

    final currencyFormat = NumberFormat.currency(
      locale: 'es_CO',
      symbol: '\$',
      decimalDigits: 0,
    );
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Scaffold(
      backgroundColor: AppDesignSystem.backgroundVariant(context),
      appBar: AppBar(
        backgroundColor: AppDesignSystem.pureWhite(context),
        elevation: 0,
        centerTitle: false,
        title: Text(
          'RESUMEN FINANCIERO',
          style: TextStyle(
            color: AppDesignSystem.deepBlack(context),
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppDesignSystem.deepBlack(context)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: AppDesignSystem.deepBlack(context),
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KPIs
            summaryAsync.when(
              data: (summary) => Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildKpiCard(
                    context,
                    'BALANCE NETO',
                    summary.netFlow,
                    AppDesignSystem.impactOrange,
                    currencyFormat,
                    isFullWidth: true,
                  ),
                  _buildKpiCard(
                    context,
                    'INGRESOS',
                    summary.totalPaidIncome,
                    AppDesignSystem.statusSuccess,
                    currencyFormat,
                  ),
                  _buildKpiCard(
                    context,
                    'EGRESOS',
                    summary.totalPaidExpense,
                    AppDesignSystem.statusError,
                    currencyFormat,
                  ),
                ],
              ),
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (_, _) => const SizedBox(),
            ),

            const SizedBox(height: 32),
            Text(
              'ÚLTIMAS TRANSACCIONES',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 16,
                color: AppDesignSystem.deepBlack(context),
              ),
            ),
            const SizedBox(height: 16),

            // Transactions List
            transactionsAsync.when(
              data: (transactions) => ImpactCard(
                backgroundColor: AppDesignSystem.pureWhite(context),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  separatorBuilder: (_, _) => Divider(
                    height: 1,
                    color: AppDesignSystem.backgroundVariant(context),
                  ),
                  itemBuilder: (context, index) {
                    final t = transactions[index];
                    final isIncome =
                        t.type == CashTransactionType.income;
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: isIncome
                              ? AppDesignSystem.statusSuccess
                                    .withValues(alpha: 0.1)
                              : AppDesignSystem.statusError
                                    .withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isIncome
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_up,
                          color: isIncome
                              ? AppDesignSystem.statusSuccess
                              : AppDesignSystem.statusError,
                        ),
                      ),
                      title: Text(
                        t.description.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: AppDesignSystem.deepBlack(context),
                          fontSize: 13,
                        ),
                      ),
                      subtitle: Text(
                        '${dateFormat.format(t.date)} • ${t.methodName ?? "N/A"}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: Text(
                        currencyFormat.format(t.amount),
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 14,
                          color: isIncome
                              ? AppDesignSystem.statusSuccess
                              : AppDesignSystem.statusError,
                        ),
                      ),
                    );
                  },
                ),
              ),
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (_, _) => const SizedBox(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard(
    BuildContext context,
    String title,
    double amount,
    Color brandColor,
    NumberFormat currencyFormat, {
    bool isFullWidth = false,
  }) {
    return SizedBox(
      width: isFullWidth
          ? double.infinity
          : (MediaQuery.of(context).size.width - 44) / 2,
      child: ImpactCard(
        backgroundColor: AppDesignSystem.pureWhite(context),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 10,
                  color: AppDesignSystem.deepBlack(context).withValues(alpha: 0.6),
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 12),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  currencyFormat.format(amount),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 24,
                    color: brandColor == AppDesignSystem.impactOrange
                        ? AppDesignSystem.deepBlack(context)
                        : brandColor,
                  ),
                ),
              ),
            ],
          ),
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
      backgroundColor: AppDesignSystem.pureWhite(context),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "NUEVO GASTO RECURRENTE",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  color: AppDesignSystem.deepBlack(context),
                ),
              ),
              const SizedBox(height: 24),
              _buildTextField(
                context,
                controller: _totalController,
                label: 'MONTO (COP)',
                icon: Icons.payments,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                context,
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
                    context,
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
                    foregroundColor: AppDesignSystem.pureWhite(context),
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      side: BorderSide(
                        color: AppDesignSystem.deepBlack(context),
                        width: 4,
                      ),
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

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 12,
            letterSpacing: 1.0,
            color: AppDesignSystem.deepBlack(context),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          cursorColor: AppDesignSystem.deepBlack(context),
          style: const TextStyle(fontWeight: FontWeight.bold),
          validator: (v) => v!.isEmpty ? "Requerido" : null,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppDesignSystem.deepBlack(context)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppDesignSystem.deepBlack(context),
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
            fillColor: AppDesignSystem.backgroundVariant(context),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
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
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 12,
            letterSpacing: 1.0,
            color: AppDesignSystem.deepBlack(context),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<PaymentMethod>(
          isExpanded: true,
          initialValue: value,
          icon: Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: AppDesignSystem.deepBlack(context),
          ),
          items: items
              .map(
                (m) => DropdownMenuItem(
                  value: m,
                  child: Text(m.name.toUpperCase()),
                ),
              )
              .toList(),
          onChanged: onChanged,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppDesignSystem.deepBlack(context),
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppDesignSystem.deepBlack(context),
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
            fillColor: AppDesignSystem.backgroundVariant(context),
          ),
        ),
      ],
    );
  }
}
