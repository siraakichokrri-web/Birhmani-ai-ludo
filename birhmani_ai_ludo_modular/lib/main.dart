import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'core/game_state.dart';
import 'services/chat_service.dart';
import 'services/voice_service.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env').catchError((_) {});
  final gs = await GameState.create(oneVsAI: true);
  runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_) => gs), Provider(create: (_) => ChatService.create()), Provider(create: (_) => VoiceService())], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(title: 'Birhmani AI Ludo', debugShowCheckedModeBanner: false, theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Color(0xFF000000), appBarTheme: AppBarTheme(backgroundColor: Color(0xFF121213))), home: const HomeScreen());
  }
}
