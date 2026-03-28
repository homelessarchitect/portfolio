import 'package:flutter/material.dart';
import '../views/shared/sand_manager_theme.dart';

class SandManagerCubicateSimulation extends StatelessWidget {
  const SandManagerCubicateSimulation({super.key});

  @override
  Widget build(BuildContext context) {
    return _MockCubicateScreen();
  }
}

enum CalculationMode { capacity, height }

class _MockCubicateScreen extends StatefulWidget {
  const _MockCubicateScreen();

  @override
  State<_MockCubicateScreen> createState() => _MockCubicateScreenState();
}

class _MockCubicateScreenState extends State<_MockCubicateScreen> {
  final _lengthCtrl = TextEditingController(text: "6");
  final _widthCtrl = TextEditingController(text: "2.5");
  final _heightCtrl = TextEditingController(text: "1.2");
  final _capacityCtrl = TextEditingController(text: "18");

  CalculationMode _mode = CalculationMode.capacity;
  double? _result;

  @override
  void initState() {
    super.initState();
    _calculate();
  }

  void _calculate() {
    final l = double.tryParse(_lengthCtrl.text) ?? 0;
    final w = double.tryParse(_widthCtrl.text) ?? 0;

    if (_mode == CalculationMode.capacity) {
      final h = double.tryParse(_heightCtrl.text) ?? 0;
      if (l > 0 && w > 0 && h > 0) {
        setState(() {
          _result = l * w * h;
        });
      } else {
        setState(() {
          _result = null;
        });
      }
    } else {
      final targetCapacity = double.tryParse(_capacityCtrl.text) ?? 0;
      if (l > 0 && w > 0 && targetCapacity > 0) {
        setState(() {
          _result = targetCapacity / (l * w);
        });
      } else {
        setState(() {
          _result = null;
        });
      }
    }
  }

  void _reset() {
    _lengthCtrl.clear();
    _widthCtrl.clear();
    _heightCtrl.clear();
    _capacityCtrl.clear();
    setState(() {
      _result = null;
    });
  }

  @override
  void dispose() {
    _lengthCtrl.dispose();
    _widthCtrl.dispose();
    _heightCtrl.dispose();
    _capacityCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppDesignSystem.backgroundVariant(context),
      appBar: AppBar(
        title: const Text(
          'CALCULADORA DE MEDIDAS',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: AppDesignSystem.backgroundVariant(context),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SegmentedButton<CalculationMode>(
              style: SegmentedButton.styleFrom(
                selectedForegroundColor: AppDesignSystem.deepBlack(context),
                selectedBackgroundColor: AppDesignSystem.impactOrange,
              ),
              segments: const [
                ButtonSegment(
                  value: CalculationMode.capacity,
                  label: Text(
                    'CAPACIDAD',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  icon: Icon(Icons.straighten),
                ),
                ButtonSegment(
                  value: CalculationMode.height,
                  label: Text(
                    'ALTURA',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  icon: Icon(Icons.height),
                ),
              ],
              selected: {_mode},
              onSelectionChanged: (Set<CalculationMode> newSelection) {
                setState(() {
                  _mode = newSelection.first;
                  _calculate();
                });
              },
            ),
            const SizedBox(height: 24),
            ImpactCard(
              backgroundColor: AppDesignSystem.pureWhite(context),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildTextField(
                      controller: _lengthCtrl,
                      label: 'LARGO (MTS)',
                      icon: Icons.straighten,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      controller: _widthCtrl,
                      label: 'ANCHO (MTS)',
                      icon: Icons.space_bar,
                    ),
                    const SizedBox(height: 16),
                    if (_mode == CalculationMode.capacity)
                      _buildTextField(
                        controller: _heightCtrl,
                        label: 'ALTO (MTS)',
                        icon: Icons.height,
                      )
                    else
                      _buildTextField(
                        controller: _capacityCtrl,
                        label: 'CAPACIDAD ESPERADA (M³)',
                        icon: Icons.local_shipping,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (_result != null && _result! > 0)
              ImpactCard(
                backgroundColor: AppDesignSystem.deepBlack(context),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Text(
                        _mode == CalculationMode.capacity
                            ? 'VOLUMEN CALCULADO'
                            : 'ALTURA A LLENAR',
                        style: TextStyle(
                          color: AppDesignSystem.pureWhite(context),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _mode == CalculationMode.capacity
                            ? '${_result!.toStringAsFixed(2)} m³'
                            : '${_result!.toStringAsFixed(2)} m',
                        style: const TextStyle(
                          color: AppDesignSystem.impactOrange,
                          fontWeight: FontWeight.w900,
                          fontSize: 48,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _reset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppDesignSystem.pureWhite(context),
                  foregroundColor: AppDesignSystem.deepBlack(context),
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
                  'LIMPIAR DATOS',
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
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 12,
            letterSpacing: 1.0,
            color: AppDesignSystem.deepBlack(context),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          cursorColor: AppDesignSystem.deepBlack(context),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          onChanged: (_) => _calculate(),
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
            suffixText:
                'm', // Default, might be m³ for capacity, but we clarify in label
            suffixStyle: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
