import 'package:flutter/material.dart';
import '../widgets/ai_chat_widget.dart';

class ChatScreen extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Birhmani AI')), body: SafeArea(child: AIChatWidget()));
  }
}
