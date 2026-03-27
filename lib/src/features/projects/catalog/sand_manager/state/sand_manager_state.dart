import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- MOCK DOMAIN MODELS ---

enum CashTransactionType { income, expense }

class PaymentMethod {
  final int id;
  final String name;

  const PaymentMethod({required this.id, required this.name});
}

class CashTransaction {
  final CashTransactionType type;
  final String description;
  final DateTime date;
  final String? methodName;
  final double amount;

  const CashTransaction({
    required this.type,
    required this.description,
    required this.date,
    this.methodName,
    required this.amount,
  });
}

class CashFlowSummary {
  final double netFlow;
  final double totalPaidIncome;
  final double totalPendingIncome;
  final double totalPaidExpense;
  final double totalPendingExpense;

  const CashFlowSummary({
    required this.netFlow,
    required this.totalPaidIncome,
    required this.totalPendingIncome,
    required this.totalPaidExpense,
    required this.totalPendingExpense,
  });
}

// --- MOCK REPOS / PROVIDERS ---

// Dummy Payment Methods
final _mockMethods = <PaymentMethod>[
  const PaymentMethod(id: 1, name: 'Bancolombia'),
  const PaymentMethod(id: 2, name: 'Efectivo'),
];

final paymentMethodsStreamProvider = StreamProvider<List<PaymentMethod>>((
  ref,
) async* {
  yield _mockMethods;
});

class CashFlowParams {
  final DateTime? since;
  final DateTime? until;
  final int? methodId;

  const CashFlowParams({this.since, this.until, this.methodId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CashFlowParams &&
          runtimeType == other.runtimeType &&
          since == other.since &&
          until == other.until &&
          methodId == other.methodId;

  @override
  int get hashCode => since.hashCode ^ until.hashCode ^ methodId.hashCode;
}

// Interactive State Notifier for Transactions
class MockTransactionsNotifier extends Notifier<List<CashTransaction>> {
  @override
  List<CashTransaction> build() {
    return [
      CashTransaction(
        type: CashTransactionType.income,
        description: 'Venta de Arena de Peña',
        date: DateTime.now().subtract(const Duration(minutes: 30)),
        methodName: 'Bancolombia',
        amount: 1500000,
      ),
      CashTransaction(
        type: CashTransactionType.expense,
        description: 'Pago Combustible',
        date: DateTime.now().subtract(const Duration(hours: 2)),
        methodName: 'Efectivo',
        amount: 250000,
      ),
      CashTransaction(
        type: CashTransactionType.income,
        description: 'Viaje Recebo',
        date: DateTime.now().subtract(const Duration(hours: 5)),
        methodName: 'Bancolombia',
        amount: 800000,
      ),
    ];
  }

  void addTransaction(CashTransaction transaction) {
    state = [transaction, ...state];
  }
}

final mockTransactionsNotifierProvider =
    NotifierProvider<MockTransactionsNotifier, List<CashTransaction>>(() {
      return MockTransactionsNotifier();
    });

final watchCashTransactionsProvider =
    StreamProvider.family<List<CashTransaction>, CashFlowParams>((
      ref,
      params,
    ) async* {
      yield ref.watch(mockTransactionsNotifierProvider);
    });

final watchCashFlowSummaryProvider =
    StreamProvider.family<CashFlowSummary, CashFlowParams>((
      ref,
      params,
    ) async* {
      final transactions = ref.watch(mockTransactionsNotifierProvider);

      double totalPaidIncome = 0;
      double totalPaidExpense = 0;

      for (final t in transactions) {
        if (t.type == CashTransactionType.income) {
          totalPaidIncome += t.amount;
        } else {
          totalPaidExpense += t.amount;
        }
      }

      yield CashFlowSummary(
        netFlow: totalPaidIncome - totalPaidExpense,
        totalPaidIncome: totalPaidIncome,
        totalPendingIncome: 0,
        totalPaidExpense: totalPaidExpense,
        totalPendingExpense: 0,
      );
    });

// --- MOCK SALES MODELS & STATE ---

enum MockSaleStatus { paid, credit, partial, cancelled }

class MockSale {
  final String id;
  final String clientName;
  final DateTime date;
  final double total;
  final MockSaleStatus status;

  const MockSale({
    required this.id,
    required this.clientName,
    required this.date,
    required this.total,
    required this.status,
  });
}

class MockSalesNotifier extends Notifier<List<MockSale>> {
  @override
  List<MockSale> build() {
    return [
      MockSale(
        id: '1004',
        clientName: 'Ferretería El Cóndor',
        date: DateTime.now().subtract(const Duration(minutes: 15)),
        total: 1200000,
        status: MockSaleStatus.paid,
      ),
      MockSale(
        id: '1003',
        clientName: 'Constructora Beta',
        date: DateTime.now().subtract(const Duration(hours: 1)),
        total: 4500000,
        status: MockSaleStatus.credit,
      ),
      MockSale(
        id: '1002',
        clientName: 'Público General',
        date: DateTime.now().subtract(const Duration(hours: 3)),
        total: 500000,
        status: MockSaleStatus.paid,
      ),
    ];
  }

  void addSale(MockSale sale) {
    state = [sale, ...state];
  }
}

final mockSalesNotifierProvider =
    NotifierProvider<MockSalesNotifier, List<MockSale>>(() {
      return MockSalesNotifier();
    });
