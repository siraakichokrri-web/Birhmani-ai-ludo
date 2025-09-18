import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/game_state.dart';
import '../constants.dart';

class DiceWidget extends StatefulWidget { @override State<DiceWidget> createState() => _DiceWidgetState(); }
class _DiceWidgetState extends State<DiceWidget> with SingleTickerProviderStateMixin {
  bool rolling=false;
  late AnimationController _controller;
  @override void initState(){ super.initState(); _controller = AnimationController(vsync: this, duration: Duration(milliseconds:600)); }
  @override void dispose(){ _controller.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) {
    final gs = Provider.of<GameState>(context);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [ GestureDetector(onTap: rolling||gs.gameOver?null:() async { setState(()=>rolling=true); _controller.repeat(); final dice = gs.rollDice(); await Future.delayed(Duration(milliseconds:700)); _controller.stop(); setState(()=>rolling=false); final moves = gs.validMovesForPlayer(gs.currentPlayer, dice); if (moves.isNotEmpty) gs.moveToken(moves.first, dice); gs.endTurn(); }, child: RotationTransition(turns: Tween(begin:0.0,end:1.0).animate(_controller), child: Container(width:100,height:100,decoration: BoxDecoration(color:Colors.grey[900], borderRadius: BorderRadius.circular(12)), child: Center(child: Text('🎲', style: TextStyle(fontSize:36))))), SizedBox(width:16), Column(crossAxisAlignment: CrossAxisAlignment.start, children:[ Text('Player: \${gs.players[gs.currentPlayer].name}', style: TextStyle(color:textColor)), SizedBox(height:6), Text('Last Dice: \${gs.lastDice}', style: TextStyle(color: Colors.white70)) ]) ]);
  }
}
