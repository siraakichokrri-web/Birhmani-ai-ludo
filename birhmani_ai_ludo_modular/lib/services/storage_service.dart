import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static Future<void> saveSkin(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_skin', key);
  }
  static Future<void> saveBoard(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_board', key);
  }
  static Future<String?> getSkin() async { final prefs = await SharedPreferences.getInstance(); return prefs.getString('selected_skin'); }
  static Future<String?> getBoard() async { final prefs = await SharedPreferences.getInstance(); return prefs.getString('selected_board'); }
}
