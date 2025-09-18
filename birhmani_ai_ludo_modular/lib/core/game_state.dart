import 'package:flutter/foundation.dart';
import 'token.dart';
import 'ai_player.dart';
import 'rules_engine.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerState {
  final String name;
  final int colorIndex;
  final bool isAI;
  final List<Token> tokens;
  PlayerState(this.name,this.colorIndex,this.isAI): tokens = List.generate(4,(i)=>Token(i));
}

class GameState extends ChangeNotifier {
  final List<PlayerState> players = [];
  int currentPlayer = 0;
  int lastDice = 1;
  bool extraTurn = false;
  bool gameOver = false;
  String winner = '';
  Map<String,dynamic>? lastMove;
  final _rng = math.Random.secure();
  AIPlayer? aiPlayer;
  final SharedPreferences? prefs;

  GameState._(this.prefs,{bool oneVsAI=true}) {
    players.add(PlayerState('Red',0,false));
    players.add(PlayerState('Green',1,oneVsAI));
    players.add(PlayerState('Blue',2,oneVsAI));
    players.add(PlayerState('Yellow',3,oneVsAI));
    final depth = (prefs?.getString('ai_difficulty') ?? 'medium') == 'easy' ? 3 : ((prefs?.getString('ai_difficulty') ?? 'medium') == 'hard' ? 7 : 5);
    aiPlayer = AIPlayer(maxDepth: depth, aiColor:1);
  }

  static Future<GameState> create({bool oneVsAI=true}) async {
    final prefs = await SharedPreferences.getInstance();
    return GameState._(prefs, oneVsAI: oneVsAI);
  }

  int rollDice() {
    lastDice = _rng.nextInt(6)+1;
    return lastDice;
  }

  List<List<int>> positionsSnapshot() => players.map((p)=>p.tokens.map((t)=>t.position).toList()).toList();

  // Other methods omitted for brevity; use main.dart for full implementation
}
