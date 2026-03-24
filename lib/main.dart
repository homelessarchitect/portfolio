import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';
import 'src/core/state/preview_state.dart';

import 'src/core/presentation/widgets/mock_status_bar.dart';

void main() {
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (context, ref, _) {
          final isEnabled = ref.watch(devicePreviewStateProvider);
          return DevicePreview(
            enabled: isEnabled,
            isToolbarVisible: true,
            defaultDevice: Devices.ios.iPhoneSE,
            builder: (context) => Column(
              children: [
                if (isEnabled) const MockStatusBar(),
                const Expanded(child: UiLabApp()),
              ],
            ),
          );
        },
      ),
    ),
  );
}
