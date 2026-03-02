import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/state/preview_state.dart';

class WorkbenchScreen extends ConsumerStatefulWidget {
  final Widget child;
  final String title;

  const WorkbenchScreen({super.key, required this.child, required this.title});

  @override
  ConsumerState<WorkbenchScreen> createState() => _WorkbenchScreenState();
}

class _WorkbenchScreenState extends ConsumerState<WorkbenchScreen> {
  @override
  void initState() {
    super.initState();
    // Enable DevicePreview when entering the Workbench
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(devicePreviewStateProvider.notifier).set(true);
    });
  }

  @override
  void dispose() {
    // Disable DevicePreview when leaving (though usually handled by next route, safest to reset)
    // Note: If we navigate to another Workbench, we might flicker.
    // Ideally we check if we are still in a workbench route, but for now this is safe.

    // We defer the disable to allow the exit animation or next route to handle it if needed.
    // However, since GoRouter declarative routing replaces the widget tree,
    // we should simply reset state if we are popping.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(devicePreviewStateProvider.notifier).set(false);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(devicePreviewStateProvider.notifier).set(false);
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Custom workbench action placeholder
            },
          ),
        ],
      ),
      body: widget.child,
    );
  }
}
