import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:therules/src/providers/shared_preferences_provider.dart';

final isDarkModeProvider = StateProvider<bool>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  return sharedPreferences.getBool("is_dark_mode") ?? false;
});

final accentColorProvider = StateProvider<Color>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  final String? savedColor = sharedPreferences.getString("accent_color");
  Color currentColor = savedColor != null ? Color(int.parse(savedColor, radix: 16)) : Colors.amber;
  return currentColor;
});
