import 'dart:math' as math;
import 'rules_engine.dart';

class AIPlayer {
  final math.Random _r = math.Random.secure();
  int maxDepth;
  final int aiColor;
  AIPlayer({this.maxDepth = 5, this.aiColor = 1});

  Future<int> decideMove(List<List<int>> positions, int currentPlayer, int dice, {int timeLimitMs=900}) async {
    await Future.delayed(Duration(milliseconds: 600 + _r.nextInt(800)));
    // Simple ordered heuristic to pick a move — full minimax is in main version
    for (int t=0;t<4;t++) {
      final np = RulesEngine.moveTokenPosition(currentPlayer, positions[currentPlayer][t], dice);
      if (np!=null) return t;
    }
    return -1;
  }
}
