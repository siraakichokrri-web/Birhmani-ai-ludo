import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class SkinsStoreScreen extends StatefulWidget {
  const SkinsStoreScreen({super.key});
  @override State<SkinsStoreScreen> createState() => _SkinsStoreScreenState();
}

class _SkinsStoreScreenState extends State<SkinsStoreScreen> {
  Set<String> unlocked = {'skin_classic.png'};
  int coins = 0;

  @override void initState(){ super.initState(); _load(); }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('unlocked_skins') ?? ['skin_classic.png'];
    final c = prefs.getInt('coins') ?? 100;
    setState(()=>{ unlocked = Set.from(list); coins = c; });
  }

  Future<void> _buy(String skin) async {
    if (unlocked.contains(skin)) return;
    if (coins < 50) { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Not enough coins'))); return; }
    final prefs = await SharedPreferences.getInstance();
    coins -= 50;
    unlocked.add(skin);
    await prefs.setStringList('unlocked_skins', unlocked.toList());
    await prefs.setInt('coins', coins);
    setState((){});
  }

  @override Widget build(BuildContext context) {
    final skins = ['skin_neon_red.png','skin_fire.png','skin_ice.png'];
    return Scaffold(backgroundColor: backgroundColor, appBar: AppBar(title: Text('Skins Store'), backgroundColor: panelColor), body: Padding(padding: EdgeInsets.all(12), child: Column(children: [ Text('Coins: \$coins', style: TextStyle(color:textColor)), SizedBox(height:12), Expanded(child: ListView.builder(itemCount: skins.length, itemBuilder: (_,i){ final s=skins[i]; final unlockedFlag = unlocked.contains(s); return ListTile(leading: Image.asset('assets/skins/\$s', width:48), title: Text(s.replaceAll('.png',''), style: TextStyle(color:textColor)), trailing: ElevatedButton(onPressed: unlockedFlag?null:()=>_buy(s), child: Text(unlockedFlag?'Owned':'Buy 50'))); })) ])));
  }
}
