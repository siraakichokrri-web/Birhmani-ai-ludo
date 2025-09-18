import 'package:flutter_test/flutter_test.dart';
import 'package:birhmani_ai_ludo/game_state.dart';

void main() {
  test('GameState initializes players', () {
    final gs = GameState();
    expect(gs.players.length, 4);
  });
}
