import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DrawerLevel { closed, main, sub }

class DrawerState {
  final DrawerLevel level;
  final String? selectedCategory;

  const DrawerState({this.level = DrawerLevel.closed, this.selectedCategory});

  DrawerState copyWith({DrawerLevel? level, String? selectedCategory}) {
    return DrawerState(
      level: level ?? this.level,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class DrawerNotifier extends Notifier<DrawerState> {
  @override
  DrawerState build() => const DrawerState();

  void toggleDrawer() {
    if (state.level == DrawerLevel.closed) {
      state = state.copyWith(level: DrawerLevel.main);
    } else {
      state = const DrawerState(level: DrawerLevel.closed);
    }
  }

  void openSubDrawer(String category) {
    state = state.copyWith(level: DrawerLevel.sub, selectedCategory: category);
  }

  void backToMain() {
    state = state.copyWith(level: DrawerLevel.main);
  }

  void close() {
    state = const DrawerState(level: DrawerLevel.closed);
  }
}

final drawerStateProvider = NotifierProvider<DrawerNotifier, DrawerState>(
  DrawerNotifier.new,
);
