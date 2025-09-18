import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/game_state.dart';
import '../widgets/game_board_widget.dart';
import '../widgets/dice_widget.dart';
import 'settings_screen.dart';
import '../widgets/leaderboard_widget.dart';

class GameScreen extends StatelessWidget {
  final String mode;
  const GameScreen({super.key, required this.mode});
  @override Widget build(BuildContext context) {
    final gs = Provider.of<GameState>(context);
    return Scaffold(
      backgroundColor: Color(0xFF000000),
      appBar: AppBar(title: Text('Ludo Birhmani - \$mode'), actions: [IconButton(icon: Icon(Icons.leaderboard), onPressed: () { showModalBottomSheet(context: context, builder: (_) => LeaderboardWidget()); }), IconButton(icon: Icon(Icons.settings), onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen())); })]),
      body: SafeArea(child: Column(children: [ Expanded(child: Center(child: GameBoardWidget())), Padding(padding: EdgeInsets.all(12), child: DiceWidget()) ]))
    );
  }
}
