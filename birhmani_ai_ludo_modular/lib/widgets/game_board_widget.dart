import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/game_state.dart';
import '../constants.dart';

class GameBoardWidget extends StatefulWidget { @override State<GameBoardWidget> createState() => _GameBoardWidgetState(); }
class _GameBoardWidgetState extends State<GameBoardWidget> {
  String? boardPath;
  @override void initState(){ super.initState(); _load(); }
  Future<void> _load() async { final prefs = await SharedPreferences.getInstance(); final b = prefs.getString('selected_board'); setState(()=>boardPath = b==null?null:'assets/boards/\$b'); }
  @override Widget build(BuildContext context) {
    final gs = Provider.of<GameState>(context);
    final size = MediaQuery.of(context).size.width * 0.92; final cell = size/15.0;
    final positions = _generateTrackPositions(cell,8.0); final finish = _generateFinishPositions(cell,8.0);
    return SizedBox(width:size, height:size, child: Stack(children: [
      if (boardPath!=null) Positioned.fill(child: Image.asset(boardPath!, fit: BoxFit.cover)),
      Positioned.fill(child: CustomPaint(painter: _BoardPainter(cell: cell))),
      // tokens omitted for brevity - tokens drawn as colored circles
    ]));
  }
  List<Offset> _generateTrackPositions(double cell, double padding) { final size = cell*15.0; final left=padding; final top=padding; final right = left + size - cell; final bottom = top + size - cell; final pos = <Offset>[]; for (int i=0;i<13;i++) pos.add(Offset(left + cell*1 + i*cell, top)); for (int i=0;i<13;i++) pos.add(Offset(right, top + cell*1 + i*cell)); for (int i=0;i<13;i++) pos.add(Offset(right - cell*1 - i*cell, bottom)); for (int i=0;i<13;i++) pos.add(Offset(left, bottom - cell*1 - i*cell)); if (pos.length>52) pos.removeRange(52,pos.length); return pos; }
  List<Offset> _generateFinishPositions(double cell, double padding) { final center = Offset(padding + cell*7.5, padding + cell*7.5); final res = <Offset>[]; for (int color=0;color<4;color++) for (int step=0;step<6;step++){ final dist=(step+1)*cell*0.5; double dx=0,dy=0; switch(color){ case 0: dy=-dist; break; case 1: dx=dist; break; case 2: dy=dist; break; default: dx=-dist; break; } res.add(center+Offset(dx,dy)); } return res; }
}

class _BoardPainter extends CustomPainter {
  final double cell;
  _BoardPainter({required this.cell});
  @override void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = panelColor; canvas.drawRect(Offset.zero & size, bg); final track = Paint()..color = Colors.grey[850]!; final center = Offset(size.width/2, size.height/2); canvas.drawRect(Rect.fromCenter(center: center, width: size.width - cell*2, height: size.height - cell*2), track); final gridPaint = Paint()..color = Colors.grey[800]!..strokeWidth=1; for (int i=0;i<=15;i++){ final x=i*cell; canvas.drawLine(Offset(x,0), Offset(x,size.height), gridPaint); canvas.drawLine(Offset(0,x), Offset(size.width,x), gridPaint); } final centerPaint = Paint()..color = Colors.black; canvas.drawCircle(center, cell*2, centerPaint);
  }
  @override bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
