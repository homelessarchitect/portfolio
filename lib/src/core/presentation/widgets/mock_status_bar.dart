import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MockStatusBar extends StatelessWidget {
  final Color color;
  final bool isDark;

  const MockStatusBar({
    super.key,
    this.color = Colors.transparent,
    this.isDark = true,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = isDark ? Colors.white : Colors.black;
    final time = DateFormat('HH:mm').format(DateTime.now());

    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.signal_cellular_4_bar, color: textColor, size: 14),
              const SizedBox(width: 4),
              Icon(Icons.wifi, color: textColor, size: 14),
              const SizedBox(width: 4),
              Icon(Icons.battery_full, color: textColor, size: 14),
            ],
          ),
        ],
      ),
    );
  }
}
