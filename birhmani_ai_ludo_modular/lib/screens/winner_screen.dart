import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:confetti/confetti.dart';

class WinnerScreen extends StatelessWidget {
  final String winnerName;
  const WinnerScreen({super.key, required this.winnerName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(child: Column(mainAxisSize: MainAxisSize.min, children:[
        Text('\$winnerName Wins!', style: TextStyle(color:textColor, fontSize:28)),
        SizedBox(height:12),
        ElevatedButton(onPressed: ()=>Navigator.popUntil(context, (r)=>r.isFirst), child: Text('Play Again'))
      ])),
    );
  }
}
