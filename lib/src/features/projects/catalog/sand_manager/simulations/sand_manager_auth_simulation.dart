import 'package:flutter/material.dart';
import '../views/shared/sand_manager_theme.dart';

class SandManagerAuthSimulation extends StatefulWidget {
  final bool showAppBar;
  const SandManagerAuthSimulation({super.key, this.showAppBar = true});

  @override
  State<SandManagerAuthSimulation> createState() =>
      _SandManagerAuthSimulationState();
}

class _SandManagerAuthSimulationState extends State<SandManagerAuthSimulation> {
  final _pinController = TextEditingController();
  bool _isLoading = false;
  bool _loggedIn = false;

  void _login() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _isLoading = false;
      _loggedIn = true;
    });
  }

  void _logout() {
    setState(() {
      _loggedIn = false;
      _pinController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loggedIn) {
      return Scaffold(
        backgroundColor: AppDesignSystem.pureWhite(context),
        appBar: widget.showAppBar
            ? AppBar(
                backgroundColor: AppDesignSystem.deepBlack(context),
                foregroundColor: AppDesignSystem.pureWhite(context),
                title: const Text(
                  'BIENVENIDO',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: _logout,
                  ),
                ],
              )
            : null,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 64,
                color: AppDesignSystem.statusSuccess,
              ),
              const SizedBox(height: 16),
              const Text(
                'SESIÓN INICIADA\nROL: ADMINISTRADOR',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppDesignSystem.backgroundVariant(context),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ImpactCard(
            backgroundColor: AppDesignSystem.pureWhite(context),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.security,
                    size: 48,
                    color: AppDesignSystem.deepBlack(context),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'SAND MANAGER AUTH',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: AppDesignSystem.deepBlack(context),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'PIN DE ACCESO',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _pinController,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: 8,
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
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppDesignSystem.deepBlack(context),
                      foregroundColor: AppDesignSystem.pureWhite(context),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(
                          color: AppDesignSystem.deepBlack(context),
                          width: 2,
                        ),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: AppDesignSystem.pureWhite(context),
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            'INGRESAR',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              letterSpacing: 1.5,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
