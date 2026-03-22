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
    // Exact sizing to fit a 390x844 mobile screen perfectly
    return SizedBox(
      width: width,
      height: height,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          width: 390 + 24, // 12px horizontal bezel
          height: 844 + 24, // 12px vertical bezel
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1E),
            borderRadius: BorderRadius.circular(55),
            border: Border.all(color: const Color(0xFF2C2C2C), width: 4),
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
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(44), // Inner screen corners
                  child: SizedBox(
                    width: 390,
                    height: 844,
                    child: child,
                  ),
                ),
              ),
              // Dynamic Island / Notch
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: const EdgeInsets.only(top: 24),
                  width: 120, // Island width
                  height: 35, // Island height
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
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

class _TabletFrame extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;

  const _TabletFrame({required this.width, required this.height, required this.child});

  @override
  Widget build(BuildContext context) {
    // Exact sizing to fit a 810x1080 tablet screen perfectly
    return SizedBox(
      width: width,
      height: height,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          width: 810 + 48, // 24px horizontal bezels
          height: 1080 + 48, // 24px vertical bezels
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(36),
            border: Border.all(color: const Color(0xFF2C2C2C), width: 6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: 810,
                height: 1080,
                child: child,
              ),
            ),
          ),
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
    // Exact sizing to fit a 1440x900 laptop screen perfectly
    return SizedBox(
      width: width,
      height: height,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 1440 + 32, // 16px lateral bezels
              height: 900 + 44, // 28px top bezel, 16px bottom bezel
              decoration: BoxDecoration(
                color: const Color(0xFF1C1E1C),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                border: Border.all(color: const Color(0xFF333333), width: 3),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    width: 1440,
                    height: 900,
                    child: child,
                  ),
                ),
              ),
            ),
            // Laptop base
            Container(
              width: 1440 + 32 + 80, // Slightly wider base
              height: 16,
              decoration: const BoxDecoration(
                color: Color(0xFF333333),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
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
    // Exact sizing to fit a 1920x1080 monitor screen perfectly
    return SizedBox(
      width: width,
      height: height,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 1920 + 48, // 24px lateral bezels
              height: 1080 + 48 + 32, // 24px top bezel, 56px bottom bezel
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF333333), width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 50,
                    offset: const Offset(0, 25),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 56),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    width: 1920,
                    height: 1080,
                    child: child,
                  ),
                ),
              ),
            ),
            // Monitor stand neck
            Container(
              width: 120,
              height: 80,
              color: const Color(0xFF2C2C2C),
            ),
            // Monitor stand base
            Container(
              width: 400,
              height: 12,
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
