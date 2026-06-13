import 'package:flutter/material.dart';

/// Tiny, dependency-free theme state.
///
/// The brief calls for no heavy state management - a [ValueNotifier] driving a
/// [ValueListenableBuilder] at the app root is all the theme toggle needs.
class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController([super.mode = ThemeMode.light]);

  bool get isDark => value == ThemeMode.dark;

  void toggle() =>
      value = value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
}
