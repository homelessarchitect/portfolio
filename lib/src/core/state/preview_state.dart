import 'package:flutter_riverpod/flutter_riverpod.dart';

final devicePreviewStateProvider =
    NotifierProvider<DevicePreviewNotifier, bool>(DevicePreviewNotifier.new);

class DevicePreviewNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void set(bool value) => state = value;
}
