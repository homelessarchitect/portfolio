import 'package:flutter/material.dart';

class SandManagerWebHomeView extends StatelessWidget {
  const SandManagerWebHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Static "foto viva" for the Web Admin Dashboard
    return Material(
      child: IgnorePointer(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Sand Manager — Admin Dashboard'),
            elevation: 2,
            actions: [
              IconButton(icon: const Icon(Icons.add_business), onPressed: () {}),
              IconButton(icon: const Icon(Icons.list_alt), onPressed: () {}),
              const SizedBox(width: 8),
            ],
          ),
          body: const Row(
            children: [
              SizedBox(width: 350, child: _StaticBusinessListPanel()),
              VerticalDivider(width: 1),
              Expanded(child: _StaticBusinessDetailPanel()),
            ],
          ),
        ),
      ),
    );
  }
}

class _StaticBusinessListPanel extends StatelessWidget {
  const _StaticBusinessListPanel();

  @override
  Widget build(BuildContext context) {
    final businesses = [
      {
        'id': '1',
        'name': 'Ferretería El Tornillo',
        'ownerEmail': 'admin@eltornillo.co',
      },
      {
        'id': '2',
        'name': 'Materiales La 50',
        'ownerEmail': 'gerencia@la50.com',
      },
      {'id': '3', 'name': 'Constructora XYZ', 'ownerEmail': 'admin@xyz.com'},
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search businesses...',
              prefixIcon: const Icon(Icons.search),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: businesses.length,
            separatorBuilder: (_, i) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final b = businesses[index];
              return ListTile(
                leading: CircleAvatar(child: Text(b['name']![0])),
                title: Text(b['name']!),
                subtitle: Text('Owner: ${b['ownerEmail']}'),
                selected: b['id'] == '1', // El Tornillo is selected
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StaticBusinessDetailPanel extends StatelessWidget {
  const _StaticBusinessDetailPanel();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Business License Details',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          const Text(
            'Business ID: b_eltornillo_10293',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 32),
          _buildLicenseCard(context),
          const SizedBox(height: 48),
          _buildEmployeeSection(context),
          const SizedBox(height: 48),
          _buildActionsSection(context),
          const SizedBox(height: 48),
          _buildPaymentHistorySection(context),
        ],
      ),
    );
  }

  Widget _buildLicenseCard(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(
        context,
      ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildInfoRow(
              context,
              'Status',
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.green),
                ),
                child: const Text(
                  'ACTIVE',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const Divider(height: 32),
            _buildInfoRow(
              context,
              'Valid Until',
              const Text(
                '2025-12-31 23:59',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 32),
            _buildInfoRow(
              context,
              'Last Updated',
              const Text('2024-03-20 10:15'),
            ),
            const Divider(height: 32),
            _buildInfoRow(
              context,
              'Max Devices',
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '5',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 18),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeSection(BuildContext context) {
    final employees = [
      {'name': 'Carlos Perez', 'email': 'carlos@eltornillo.co'},
      {'name': 'Ana Gomez', 'email': 'ana@eltornillo.co'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Employees / Cashiers',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.person_add_alt),
              label: const Text('Add Employee'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: employees.length,
            separatorBuilder: (_, i) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final emp = employees[index];
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(emp['name']!),
                subtitle: Text(emp['email']!),
                trailing: const Icon(Icons.chevron_right),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Administrative Actions',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.payments_outlined),
              label: const Text('Record Payment'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.block_flipped),
              label: const Text('Block Account'),
              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentHistorySection(BuildContext context) {
    final payments = [
      {
        'amount': '50.00',
        'method': 'STRIPE',
        'notes': 'Annual Subscription',
        'date': 'Mar 20, 2024',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Payment History', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: payments.length,
            separatorBuilder: (_, i) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final p = payments[index];
              return ListTile(
                leading: const Icon(Icons.receipt_long, color: Colors.green),
                title: Text('\$${p['amount']} — ${p['method']}'),
                subtitle: Text(p['notes']!),
                trailing: Text(p['date']!),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, Widget value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        value,
      ],
    );
  }
}
