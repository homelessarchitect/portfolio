import 'package:flutter/material.dart';
import 'shared/sand_manager_theme.dart';

class SandManagerWebAdminWrapper extends StatelessWidget {
  final Widget child;
  final String title;

  const SandManagerWebAdminWrapper({
    super.key,
    required this.child,
    this.title = 'ADMIN DASHBOARD',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesignSystem.backgroundVariant(context),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: AppDesignSystem.deepBlack(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    'SAND MANAGER\nADMIN',
                    style: TextStyle(
                      color: AppDesignSystem.pureWhite(context),
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _buildSidebarItem(
                  context,
                  Icons.dashboard,
                  'DASHBOARD',
                  title == 'ADMIN DASHBOARD',
                ),
                _buildSidebarItem(
                  context,
                  Icons.payments,
                  'FLUJO DE CAJA',
                  title == 'RESUMEN FINANCIERO',
                ),
                _buildSidebarItem(
                  context,
                  Icons.shopping_cart,
                  'VENTAS',
                  title == 'VENTAS',
                ),
                _buildSidebarItem(
                  context,
                  Icons.inventory_2,
                  'INVENTARIO',
                  title == 'INVENTARIO',
                ),
                _buildSidebarItem(
                  context,
                  Icons.people,
                  'CLIENTES',
                  title == 'CLIENTES',
                ),
                _buildSidebarItem(
                  context,
                  Icons.receipt_long,
                  'FACTURACIÓN',
                  title == 'FACTURACIÓN',
                ),
                const Spacer(),
                _buildSidebarItem(context, Icons.settings, 'AJUSTES', false),
                _buildSidebarItem(context, Icons.logout, 'SALIR', false),
                const SizedBox(height: 24),
              ],
            ),
          ),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Topbar
                Container(
                  height: 70,
                  color: AppDesignSystem.pureWhite(context),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: AppDesignSystem.deepBlack(context),
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.search,
                        color: AppDesignSystem.deepBlack(context),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.notifications_none,
                        color: AppDesignSystem.deepBlack(context),
                      ),
                      const SizedBox(width: 24),
                      CircleAvatar(
                        backgroundColor: AppDesignSystem.impactOrange,
                        child: Text(
                          'AD',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppDesignSystem.deepBlack(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(
      BuildContext context, IconData icon, String label, bool isSelected) {
    return Container(
      color: isSelected ? AppDesignSystem.impactOrange : Colors.transparent,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected
                ? AppDesignSystem.deepBlack(context)
                : AppDesignSystem.pureWhite(context),
            size: 20,
          ),
          const SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? AppDesignSystem.deepBlack(context)
                  : AppDesignSystem.pureWhite(context),
              fontWeight: FontWeight.w900,
              fontSize: 12,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
