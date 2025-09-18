import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../core/ai_player.dart';
import '../core/game_state.dart';
import '../constants.dart';

enum AIDifficulty { easy, medium, hard }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedSkin = 'skin_classic.png';
  String _selectedBoard = 'board_classic.png';
  AIDifficulty _difficulty = AIDifficulty.medium;
  bool _voiceAssistant = false;

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedSkin = prefs.getString('selected_skin') ?? _selectedSkin;
      _selectedBoard = prefs.getString('selected_board') ?? _selectedBoard;
      final d = prefs.getString('ai_difficulty') ?? 'medium';
      _difficulty = d=='easy'?AIDifficulty.easy:(d=='hard'?AIDifficulty.hard:AIDifficulty.medium);
      _voiceAssistant = prefs.getBool('voice_assistant') ?? false;
    });
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_skin', _selectedSkin);
    await prefs.setString('selected_board', _selectedBoard);
    await prefs.setString('ai_difficulty', _difficulty==AIDifficulty.easy?'easy':_difficulty==AIDifficulty.hard?'hard':'medium');
    await prefs.setBool('voice_assistant', _voiceAssistant);
    final gs = Provider.of<GameState>(context, listen:false);
    gs.aiPlayer = AIPlayer(maxDepth: _difficulty==AIDifficulty.easy?3:(_difficulty==AIDifficulty.hard?7:5), aiColor: gs.aiPlayer?.aiColor ?? 1);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Settings saved')));
  }

  @override void initState(){ super.initState(); _load(); }

  @override Widget build(BuildContext context) {
    final skins = ['skin_classic.png','skin_neon_red.png','skin_fire.png','skin_ice.png'];
    final boards = ['board_classic.png','board_neon.png','board_futuristic.png'];
    return Scaffold(backgroundColor: backgroundColor, appBar: AppBar(title: Text('Settings'), backgroundColor: panelColor), body: Padding(padding: EdgeInsets.all(12), child: Column(children: [ Text('Token Skin', style: TextStyle(color:textColor)), SizedBox(height:8), SizedBox(height:90, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: skins.length, itemBuilder: (_,i){ final s = skins[i]; final sel = s==_selectedSkin; return GestureDetector(onTap: ()=>setState(()=>_selectedSkin=s), child: Container(margin: EdgeInsets.all(8), padding: EdgeInsets.all(6), decoration: BoxDecoration(border: sel?Border.all(color:blueColor,width:2):null, borderRadius: BorderRadius.circular(8), color: panelColor), child: Column(children:[ Image.asset('assets/skins/\$s', width:48,height:48), SizedBox(height:6), Text(s.replaceAll('skin_','').replaceAll('.png',''), style: TextStyle(color:textColor,fontSize:12))])) ; })), SizedBox(height:12), Text('Board Theme', style: TextStyle(color:textColor)), SizedBox(height:8), SizedBox(height:90, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: boards.length, itemBuilder: (_,i){ final b = boards[i]; final sel = b==_selectedBoard; return GestureDetector(onTap: ()=>setState(()=>_selectedBoard=b), child: Container(margin: EdgeInsets.all(8), padding: EdgeInsets.all(6), decoration: BoxDecoration(border: sel?Border.all(color:greenColor,width:2):null, borderRadius: BorderRadius.circular(8), color: panelColor), child: Column(children:[ Image.asset('assets/boards/\$b', width:100,height:56, fit: BoxFit.cover), SizedBox(height:6), Text(b.replaceAll('board_','').replaceAll('.png',''), style: TextStyle(color:textColor,fontSize:12))])) ; })), SizedBox(height:12), Text('AI Difficulty', style: TextStyle(color:textColor)), ListTile(title: Text('Easy', style: TextStyle(color:textColor)), leading: Radio(value: AIDifficulty.easy, groupValue: _difficulty, onChanged: (v)=>setState(()=>_difficulty=v!))), ListTile(title: Text('Medium', style: TextStyle(color:textColor)), leading: Radio(value: AIDifficulty.medium, groupValue: _difficulty, onChanged: (v)=>setState(()=>_difficulty=v!))), ListTile(title: Text('Hard', style: TextStyle(color:textColor)), leading: Radio(value: AIDifficulty.hard, groupValue: _difficulty, onChanged: (v)=>setState(()=>_difficulty=v!))), SwitchListTile(title: Text('Voice Assistant', style: TextStyle(color:textColor)), value: _voiceAssistant, onChanged: (v)=>setState(()=>_voiceAssistant=v)), SizedBox(height:12), ElevatedButton(onPressed: _save, child: Text('Save Settings')) ])));
  }
}
