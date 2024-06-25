import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayersNotifier extends StateNotifier<int> {
  PlayersNotifier() : super(5);

  void addPlayer() {
    state = state + 1;
  }

  void removePlayer() {
    if (state > 1) state = state - 1;
  }
}

final playersProvider = StateNotifierProvider<PlayersNotifier, int>((ref) {
  return PlayersNotifier();
});
