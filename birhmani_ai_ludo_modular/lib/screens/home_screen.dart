import 'package:flutter/material.dart';
import '../constants.dart';
import 'chat_screen.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  Widget neonButton(BuildContext context, String label, VoidCallback onTap, {Color glow = blueColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(margin: EdgeInsets.symmetric(vertical:12,horizontal:36), padding: EdgeInsets.symmetric(vertical:18), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(14), border: Border.all(color: glow.withOpacity(0.8), width:2), boxShadow: [BoxShadow(color: glow.withOpacity(0.35), blurRadius:22, spreadRadius:1)]), child: Center(child: Text(label, style: TextStyle(color: textColor, fontSize:18, fontWeight: FontWeight.bold))))
    );
  }

  @override Widget build(BuildContext context) {
    return Scaffold(backgroundColor: backgroundColor, body: SafeArea(child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text('Birhmani AI Ludo', style: TextStyle(color:textColor,fontSize:36,fontWeight:FontWeight.bold, shadows:[Shadow(color:blueColor, blurRadius:12)])), SizedBox(height:32), neonButton(context,'Birhmani AI', ()=>Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen())) , glow: blueColor), neonButton(context,'Ludo Birhmani', ()=>Navigator.push(context, MaterialPageRoute(builder: (_) => GameScreen(mode: '1vAI'))), glow: greenColor), SizedBox(height:24), Text('Neon black • Play & Chat', style: TextStyle(color: Colors.white54))])));
  }
}
