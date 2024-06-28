import 'package:flutter_riverpod/flutter_riverpod.dart';

class GamesRulesNotifier extends StateNotifier<List<String>> {
  GamesRulesNotifier() : super(_gameRules);

  static final List<String> _gameRules = [];

  void add(String rule) {
    final gameRules = List<String>.from(state);
    gameRules.add(rule);
    state = gameRules;
  }

  void remove(String rule) {
    final gameRules = List<String>.from(state);
    gameRules.remove(rule);
    state = gameRules;
  }
}

final gamesRulesProvider = StateNotifierProvider<GamesRulesNotifier, List<String>>((ref) {
  return GamesRulesNotifier();
});

class GamesWordsNotifier extends StateNotifier<List<String>> {
  GamesWordsNotifier() : super(_gameWords);

  static final List<String> _gameWords = [];

  void add(String rule) {
    final gameWords = List<String>.from(state);
    gameWords.add(rule);
    state = gameWords;
  }

  void remove(String rule) {
    final gameWords = List<String>.from(state);
    gameWords.remove(rule);
    state = gameWords;
  }
}

final gamesWordsProvider = StateNotifierProvider<GamesWordsNotifier, List<String>>((ref) {
  return GamesWordsNotifier();
});
