import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamesRulesNotifier extends StateNotifier<List<String>> {
  GamesRulesNotifier() : super(_gameRules);

  static final List<String> _gameRules = ["Hablar con la o", "Cuando Manuel levante la mano el ultimo que la suba bebe"];

  void addGameRule(String rule) {
    final gameRules = List<String>.from(state);
    gameRules.add(rule);
    state = gameRules;
  }

  void removeGameRule(String rule) {
    final gameRules = List<String>.from(state);
    gameRules.remove(rule);
    state = gameRules;
  }
}

final gamesRulesProvider = StateNotifierProvider<GamesRulesNotifier, List<String>>((ref) {
  return GamesRulesNotifier();
});
