import 'package:flutter/material.dart';
import '../domain/project.dart';
import 'widgets/device_mockup.dart';
import 'widgets/help_tag_overlay.dart';

class FeatureSimulationView extends StatefulWidget {
  final Project project;
  final ProjectFeature feature;

  const FeatureSimulationView({
    super.key,
    required this.project,
    required this.feature,
  });

  @override
  State<FeatureSimulationView> createState() => _FeatureSimulationViewState();
}

class _FeatureSimulationViewState extends State<FeatureSimulationView> {
  late DeviceType _selectedDevice;
  bool _showHelp = false;

  @override
  void initState() {
    super.initState();
    // Pick default device based on feature's target platform
    if (widget.feature.targetPlatform == FeatureTargetPlatform.web) {
      _selectedDevice = DeviceType.laptop;
    } else {
      _selectedDevice = DeviceType.phone;
    }
  }

  List<DeviceType> get _availableDevices {
    if (widget.feature.targetPlatform == FeatureTargetPlatform.web) {
      return [DeviceType.laptop, DeviceType.monitor];
    } else {
      return [DeviceType.phone, DeviceType.tablet];
    }
  }

  String _deviceLabel(DeviceType type) {
    switch (type) {
      case DeviceType.phone:
        return 'IPHONE';
      case DeviceType.tablet:
        return 'IPAD';
      case DeviceType.laptop:
        return 'MACBOOK';
      case DeviceType.monitor:
        return 'MONITOR';
    }
  }

  IconData _deviceIcon(DeviceType type) {
    switch (type) {
      case DeviceType.phone:
        return Icons.phone_iphone;
      case DeviceType.tablet:
        return Icons.tablet_mac;
      case DeviceType.laptop:
        return Icons.laptop_mac;
      case DeviceType.monitor:
        return Icons.desktop_windows;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screens = widget.feature.simulationScreens;
    final isDualScreen = screens.length >= 2;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.feature.title.toUpperCase(),
          style: theme.textTheme.labelLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Row(
        children: [
          // --- Sidebar ---
          Container(
            width: 320,
            decoration: const BoxDecoration(
              color: Color(0xFF141414),
              border: Border(right: BorderSide(color: Colors.white10, width: 0.5)),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SidebarHeader(label: "DETALLES"),
                  const SizedBox(height: 12),
                  Text(
                    widget.feature.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),
                  
                  const SizedBox(height: 36),
                  
                  _SidebarHeader(label: "GUÍA DE USO"),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      widget.feature.guide ?? "Interactúa con la simulación para probar esta funcionalidad.",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white60,
                        height: 1.8,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 36),
                  
                  // Help tags toggle
                  if (widget.feature.helpSteps.isNotEmpty) ...[
                    _SidebarHeader(label: "AYUDA INTERACTIVA"),
                    const SizedBox(height: 12),
                    _HelpToggleButton(
                      isActive: _showHelp,
                      onTap: () => setState(() => _showHelp = !_showHelp),
                    ),
                    const SizedBox(height: 36),
                  ],
                  
                  _SidebarHeader(label: "DISPOSITIVO"),
                  const SizedBox(height: 12),
                  
                  // Device selection — platform-locked
                  ..._availableDevices.map((device) {
                    final isSelected = _selectedDevice == device;
                    return _ConfigButton(
                      isSelected: isSelected,
                      isSupported: true,
                      icon: _deviceIcon(device),
                      label: _deviceLabel(device),
                      onTap: () => setState(() => _selectedDevice = device),
                    );
                  }),
                ],
              ),
            ),
          ),
          
          // --- Simulation Stage ---
          Expanded(
            child: Container(
              color: const Color(0xFF0D0D0D),
              child: Stack(
                children: [
                  // Device mockups
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: isDualScreen
                          ? _DualDevicePreview(
                              screens: screens,
                              deviceType: _selectedDevice,
                            )
                          : _SingleDevicePreview(
                              screen: screens.isNotEmpty ? screens.first : null,
                              deviceType: _selectedDevice,
                            ),
                    ),
                  ),
                  // Help tag overlay
                  if (_showHelp)
                    Positioned.fill(
                      child: HelpTagOverlay(
                        steps: widget.feature.helpSteps,
                        visible: _showHelp,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Dual Device Preview ---
class _DualDevicePreview extends StatelessWidget {
  final List<SimulationScreen> screens;
  final DeviceType deviceType;

  const _DualDevicePreview({
    required this.screens,
    required this.deviceType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // First device (e.g. form)
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: DeviceMockup(
                    type: deviceType,
                    child: screens[0].builder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _ScreenLabel(label: screens[0].label, theme: theme),
            ],
          ),
        ),
        const SizedBox(width: 40),
        // Second device (e.g. list/dashboard)
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: DeviceMockup(
                    type: deviceType,
                    child: screens[1].builder(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _ScreenLabel(label: screens[1].label, theme: theme),
            ],
          ),
        ),
      ],
    );
  }
}

// --- Single Device Preview ---
class _SingleDevicePreview extends StatelessWidget {
  final SimulationScreen? screen;
  final DeviceType deviceType;

  const _SingleDevicePreview({
    required this.screen,
    required this.deviceType,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: DeviceMockup(
        type: deviceType,
        child: screen != null
            ? screen!.builder()
            : const Center(child: Text("Sin Simulación", style: TextStyle(color: Colors.white54))),
      ),
    );
  }
}

// --- Screen Label ---
class _ScreenLabel extends StatelessWidget {
  final String label;
  final ThemeData theme;

  const _ScreenLabel({required this.label, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white12),
      ),
      child: Text(
        label.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: Colors.white54,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

// --- Help Toggle Button ---
class _HelpToggleButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;

  const _HelpToggleButton({
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive
              ? const Color(0xFFFF6B00).withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.02),
          border: Border.all(
            color: isActive ? const Color(0xFFFF6B00) : Colors.white10,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isActive ? Icons.lightbulb : Icons.lightbulb_outline,
              color: isActive ? const Color(0xFFFF6B00) : Colors.white54,
              size: 18,
            ),
            const SizedBox(width: 12),
            Text(
              isActive ? 'OCULTAR GUÍA' : 'MOSTRAR GUÍA',
              style: TextStyle(
                color: isActive ? const Color(0xFFFF6B00) : Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
            const Spacer(),
            if (isActive)
              const Icon(Icons.close, color: Color(0xFFFF6B00), size: 14),
          ],
        ),
      ),
    );
  }
}

// --- Sidebar Header ---
class _SidebarHeader extends StatelessWidget {
  final String label;
  const _SidebarHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold,
        letterSpacing: 2,
      ),
    );
  }
}

// --- Config Button ---
class _ConfigButton extends StatelessWidget {
  final bool isSelected;
  final bool isSupported;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ConfigButton({
    required this.isSelected,
    required this.isSupported,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: isSupported ? onTap : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected 
                ? theme.colorScheme.primary 
                : Colors.white.withValues(alpha: 0.05),
            ),
            borderRadius: BorderRadius.circular(8),
            color: isSelected 
              ? theme.colorScheme.primary.withValues(alpha: 0.1) 
              : Colors.white.withValues(alpha: 0.02),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSupported ? (isSelected ? theme.colorScheme.primary : Colors.white70) : Colors.white12,
                size: 18,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: isSupported ? (isSelected ? theme.colorScheme.primary : Colors.white70) : Colors.white12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              if (!isSupported)
                Text(
                  "N/A",
                  style: theme.textTheme.labelSmall?.copyWith(color: Colors.white12),
                )
              else if (isSelected)
                Icon(Icons.check_circle_outline, size: 16, color: theme.colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}
