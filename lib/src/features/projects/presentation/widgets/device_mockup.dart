import 'package:flutter/material.dart';

enum DeviceType { phone, tablet, laptop, monitor }

class DeviceMockup extends StatelessWidget {
  final Widget child;
  final DeviceType type;
  final double? width;
  final double? height;

  const DeviceMockup({
    super.key,
    required this.child,
    required this.type,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case DeviceType.phone:
        return _PhoneFrame(width: width ?? 375, height: height ?? 750, child: child);
      case DeviceType.tablet:
        return _TabletFrame(width: width ?? 768, height: height ?? 1024, child: child);
      case DeviceType.laptop:
        return _LaptopFrame(width: width ?? 1000, height: height ?? 650, child: child);
      case DeviceType.monitor:
        return _MonitorFrame(width: width ?? 1200, height: height ?? 800, child: child);
    }
  }
}

class _PhoneFrame extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const _PhoneFrame({required this.width, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(width * 0.12),
        border: Border.all(color: const Color(0xFF2C2C2C), width: 8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(width * 0.1),
              child: child,
            ),
          ),
          // Dynamic Island / Notch
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 12),
              width: width * 0.25,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabletFrame extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const _TabletFrame({required this.width, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF2C2C2C), width: 12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: child,
        ),
      ),
    );
  }
}

class _LaptopFrame extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const _LaptopFrame({required this.width, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width,
          height: height * 0.9,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            border: Border.all(color: const Color(0xFF2C2C2C), width: 10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: child,
            ),
          ),
        ),
        Container(
          width: width * 1.05,
          height: 12,
          decoration: const BoxDecoration(
            color: Color(0xFF333333),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
          ),
        ),
      ],
    );
  }
}

class _MonitorFrame extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const _MonitorFrame({required this.width, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF2C2C2C), width: 14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 50,
                offset: const Offset(0, 25),
              ),
            ],
          ),
          child: child,
        ),
        Container(
          width: 120,
          height: 60,
          color: const Color(0xFF2C2C2C),
        ),
        Container(
          width: 240,
          height: 10,
          decoration: BoxDecoration(
            color: const Color(0xFF2C2C2C),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }
}
