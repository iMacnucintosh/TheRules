import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:therules/src/models/rule.dart';
import 'package:therules/src/providers/shared_preferences_provider.dart';

class CustomRule {
  final String id;
  final String name;
  final String description;
  final String imageBase64;
  final bool enabled;

  CustomRule({required this.id, required this.name, required this.description, required this.imageBase64, this.enabled = true});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'imageBase64': imageBase64, 'enabled': enabled};
  }

  factory CustomRule.fromJson(Map<String, dynamic> json) {
    return CustomRule(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageBase64: json['imageBase64'],
      enabled: json['enabled'] ?? true,
    );
  }

  Rule toRule() {
    return Rule(
      id: id,
      imagePath: '', // No se usa para reglas personalizadas
      name: name,
      description: description,
      enabled: enabled,
    );
  }
}

class CustomRulesNotifier extends StateNotifier<List<CustomRule>> {
  CustomRulesNotifier(this.ref) : super([]) {
    _loadCustomRules();
  }

  final Ref ref;

  void _loadCustomRules() {
    final sharedPreferences = ref.read(sharedPreferencesProvider);
    final customRulesJson = sharedPreferences.getStringList('custom_rules') ?? [];

    final customRules = customRulesJson.map((jsonString) => CustomRule.fromJson(jsonDecode(jsonString))).toList();

    state = customRules;
  }

  void _saveCustomRules() {
    final sharedPreferences = ref.read(sharedPreferencesProvider);
    final customRulesJson = state.map((rule) => jsonEncode(rule.toJson())).toList();

    sharedPreferences.setStringList('custom_rules', customRulesJson);
  }

  void addCustomRule(String name, String description, String imageBase64) {
    final newRule = CustomRule(id: 'custom_${DateTime.now().millisecondsSinceEpoch}', name: name, description: description, imageBase64: imageBase64);

    final updatedRules = List<CustomRule>.from(state)..add(newRule);
    state = updatedRules;
    _saveCustomRules();
  }

  void toggleCustomRule(String id) {
    final updatedRules = state.map((rule) {
      if (rule.id == id) {
        return CustomRule(id: rule.id, name: rule.name, description: rule.description, imageBase64: rule.imageBase64, enabled: !rule.enabled);
      }
      return rule;
    }).toList();

    state = updatedRules;
    _saveCustomRules();
  }

  void deleteCustomRule(String id) {
    final updatedRules = state.where((rule) => rule.id != id).toList();
    state = updatedRules;
    _saveCustomRules();
  }

  List<Rule> getCustomRulesAsRules() {
    return state.map((customRule) => customRule.toRule()).toList();
  }
}

final customRulesProvider = StateNotifierProvider<CustomRulesNotifier, List<CustomRule>>((ref) {
  return CustomRulesNotifier(ref);
});
