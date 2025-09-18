import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/chat_service.dart';
import '../services/voice_service.dart';
import '../constants.dart';

class AIChatWidget extends StatefulWidget { const AIChatWidget({super.key}); @override State<AIChatWidget> createState() => _AIChatWidgetState(); }
class _AIChatWidgetState extends State<AIChatWidget> {
  final List<Map<String,String>> _messages = [];
  final TextEditingController _ctrl = TextEditingController();
  bool _loading=false;

  Future<void> _send() async {
    final q=_ctrl.text.trim();
    if (q.isEmpty) return;
    setState(()=>_messages.add({'from':'you','text':q}));
    _ctrl.clear(); setState(()=>_loading=true);
    final chat = Provider.of<ChatService>(context, listen:false);
    final reply = await chat.ask(q);
    setState(()=>_messages.add({'from':'ai','text': reply.length>220? reply.substring(0,220)+'...' : reply}));
    setState(()=>_loading=false);
  }

  Future<void> _voiceAsk() async {
    final voice = Provider.of<VoiceService>(context, listen:false);
    final ok = await voice.init();
    if (!ok) return;
    final txt = await voice.listen();
    if (txt==null || txt.isEmpty) return;
    _ctrl.text = txt;
    await _send();
    await voice.speak('I replied: ' + (txt.length>120? txt.substring(0,120) : txt));
  }

  @override Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(12), child: Column(children: [ Expanded(child: ListView.builder(itemCount: _messages.length, itemBuilder: (_,i){ final m=_messages[i]; final isAi = m['from']=='ai'; return Container(padding: EdgeInsets.symmetric(horizontal:12,vertical:8), alignment: isAi?Alignment.centerLeft:Alignment.centerRight, child: Container(constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width*0.75), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: isAi? panelColor : Colors.black, borderRadius: BorderRadius.circular(12), border: Border.all(color: (isAi?blueColor:greenColor).withOpacity(0.6))), child: Text(m['text']!, style: TextStyle(color:textColor)))) }), SizedBox(height:8), Row(children: [ Expanded(child: Container(padding: EdgeInsets.symmetric(horizontal:12), decoration: BoxDecoration(color: panelColor, borderRadius: BorderRadius.circular(12)), child: TextField(controller: _ctrl, style: TextStyle(color:textColor), decoration: InputDecoration(border: InputBorder.none, hintText: 'Ask Birhmani AI')))), SizedBox(width:8), GestureDetector(onTap: _loading?null:_send, child: Container(padding: EdgeInsets.all(12), decoration: BoxDecoration(color: blueColor, borderRadius: BorderRadius.circular(12)), child: _loading? SizedBox(width:16,height:16,child:CircularProgressIndicator(color:Colors.black, strokeWidth:2)): Icon(Icons.send, color: Colors.black)))), SizedBox(height:8), ElevatedButton(onPressed: _voiceAsk, child: Text('Voice Ask')) ]));
  }
}
