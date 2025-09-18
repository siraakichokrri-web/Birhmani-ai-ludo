import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/game_state.dart';
import '../constants.dart';

class LeaderboardWidget extends StatelessWidget {
  @override Widget build(BuildContext context) {
    final gs = Provider.of<GameState>(context);
    final map = gs.getLeaderboard();
    return Container(padding: EdgeInsets.all(12), child: Column(mainAxisSize: MainAxisSize.min, children: [ Text('Leaderboard', style: TextStyle(color:textColor,fontSize:18)), ...map.entries.map((e) => ListTile(title: Text(e.key, style: TextStyle(color:textColor)), trailing: Text(e.value.toString(), style: TextStyle(color:textColor)))) ]));
  }
}
