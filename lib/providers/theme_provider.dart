import 'package:flutter_riverpod/flutter_riverpod.dart';

final appThemeProvider =
    StateNotifierProvider<AppTheme, bool>((ref) => AppTheme());

class AppTheme extends StateNotifier<bool> {
  AppTheme() : super(true);

  void toggleTheme() {
    state = !state;
  }
}
