import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../state/sand_manager_state.dart';
import 'shared/sand_manager_theme.dart';

class SandManagerMobileHomeView extends ConsumerWidget {
  const SandManagerMobileHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Para la Home View estática (foto viva), leemos los datos mock
    // Usamos IgnorePointer y físicas de scroll nulas para cumplir el standard
    final summaryAsync = ref.watch(
      watchCashFlowSummaryProvider(const CashFlowParams()),
    );
    final transactionsAsync = ref.watch(
      watchCashTransactionsProvider(const CashFlowParams()),
    );
    final methodsAsync = ref.watch(paymentMethodsStreamProvider);

    final currencyFormat = NumberFormat.currency(
      locale: 'es_CO',
      symbol: '\$',
      decimalDigits: 0,
    );
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Material(
      child: IgnorePointer(
        child: Scaffold(
        backgroundColor: AppDesignSystem.backgroundVariant(context),
        appBar: AppBar(
          backgroundColor: AppDesignSystem.backgroundVariant(context),
          elevation: 0,
          title: Text(
            'CAJA / FINANZAS',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 1.5,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.date_range,
                color: AppDesignSystem.deepBlack(context),
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: methodsAsync.when(
                  data: (methods) => _buildAccountSelector(methods),
                  loading: () => const SizedBox.shrink(),
                  error: (_, e) => const SizedBox.shrink(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: summaryAsync.when(
                  data: (summary) => _buildSummaryCards(
                    context,
                    summary,
                    'Histórico Completo',
                    currencyFormat,
                  ),
                  loading: () => const SizedBox(height: 100),
                  error: (err, _) => const SizedBox.shrink(),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: Text(
                  'TRANSACCIONES',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: AppDesignSystem.deepBlack(context).withValues(alpha: 0.6),
                  ),
                ),
              ),
            ),
            transactionsAsync.when(
              data: (transactions) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final t = transactions[index];
                    final isIncome = t.type == CashTransactionType.income;
                    return ImpactCard(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isIncome
                                ? AppDesignSystem.statusSuccess.withValues(
                                    alpha: 0.2,
                                  )
                                : AppDesignSystem.statusError.withValues(
                                    alpha: 0.2,
                                  ),
                            border: Border.all(
                              color: AppDesignSystem.deepBlack(context),
                              width: 2,
                            ),
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
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 13,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dateFormat.format(t.date),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                            if (t.methodName != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  t.methodName!.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 10,
                                    color: AppDesignSystem.deepBlack(context).withValues(
                                      alpha: 0.4,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        trailing: Text(
                          currencyFormat.format(t.amount),
                          style: TextStyle(
                            color: isIncome
                                ? AppDesignSystem.statusSuccess
                                : AppDesignSystem.statusError,
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                    );
                  }, childCount: transactions.length),
                );
              },
              loading: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
              error: (err, _) =>
                  const SliverToBoxAdapter(child: SizedBox.shrink()),
            ),
          ],
        ),
        bottomNavigationBar: const _MockBottomNavBar(),
      ),
    ),
  );
}

  Widget _buildAccountSelector(List<PaymentMethod> methods) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: [
          const _AccountBadge(name: 'TODOS', isSelected: true),
          ...methods.map((m) {
            return Consumer(
              builder: (context, ref, _) {
                final balanceAsync = ref.watch(
                  watchCashFlowSummaryProvider(CashFlowParams(methodId: m.id)),
                );
                return _AccountBadge(
                  name: m.name,
                  isSelected: false,
                  balance: balanceAsync.whenOrNull(data: (s) => s.netFlow),
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(
    BuildContext context,
    CashFlowSummary summary,
    String filterText,
    NumberFormat currencyFormat,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppDesignSystem.deepBlack(context),
              border: Border.all(color: AppDesignSystem.deepBlack(context), width: 2),
            ),
            child: Text(
              filterText.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                color: AppDesignSystem.pureWhite(context),
                fontSize: 12,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ImpactCard(
          backgroundColor: AppDesignSystem.impactOrange,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Text(
                  'DISPONIBLE EN CAJA (NETO)',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                ),
                const SizedBox(height: 8),
                Text(
                  currencyFormat.format(summary.netFlow),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: AppDesignSystem.deepBlack(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'INGRESOS PAGADOS',
                amount: summary.totalPaidIncome,
                color: AppDesignSystem.statusSuccess,
                icon: Icons.check_circle_outline,
                currencyFormat: currencyFormat,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: 'POR COBRAR',
                amount: summary.totalPendingIncome,
                color: AppDesignSystem.impactBlue,
                icon: Icons.pending_actions,
                currencyFormat: currencyFormat,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'EGRESOS PAGADOS',
                amount: summary.totalPaidExpense,
                color: AppDesignSystem.statusError,
                icon: Icons.remove_circle_outline,
                currencyFormat: currencyFormat,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: 'POR PAGAR',
                amount: summary.totalPendingExpense,
                color: AppDesignSystem.impactPurple,
                icon: Icons.history,
                currencyFormat: currencyFormat,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required double amount,
    required Color color,
    required IconData icon,
    required NumberFormat currencyFormat,
  }) {
    return ImpactCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            FittedBox(
              child: Text(
                currencyFormat.format(amount),
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: color,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountBadge extends StatelessWidget {
  final String name;
  final bool isSelected;
  final double? balance;

  const _AccountBadge({
    required this.name,
    required this.isSelected,
    this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppDesignSystem.impactOrange
              : AppDesignSystem.pureWhite(context),
          border: Border.all(color: AppDesignSystem.deepBlack(context), width: 2),
          boxShadow: isSelected
              ? []
              : [
                   BoxShadow(
                    color: AppDesignSystem.deepBlack(context),
                    offset: const Offset(2, 2),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 10,
                color: isSelected
                    ? AppDesignSystem.deepBlack(context)
                    : Colors.grey[700],
              ),
            ),
            if (balance != null) ...[
              const SizedBox(height: 2),
              Text(
                NumberFormat.currency(
                  locale: 'es_CO',
                  symbol: '\$',
                  decimalDigits: 0,
                ).format(balance),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MockBottomNavBar extends StatelessWidget {
  const _MockBottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppDesignSystem.pureWhite(context),
        border: Border(
          top: BorderSide(color: AppDesignSystem.deepBlack(context), width: 3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, Icons.account_balance_wallet, 'CAJA', true),
          _buildNavItem(context, Icons.shopping_cart, 'VENTAS', false),
          _buildNavItem(context, Icons.inventory, 'STOCK', false),
          _buildNavItem(context, Icons.settings, 'AJUSTES', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      BuildContext context, IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected
              ? AppDesignSystem.impactOrange
              : AppDesignSystem.deepBlack(context),
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w900,
            color: isSelected
                ? AppDesignSystem.impactOrange
                : AppDesignSystem.deepBlack(context),
          ),
        ),
      ],
    );
  }
}
