class Token {
  final int id;
  int position; // -1 home, 0..51 board, 52..57 finish, 58 completed
  Token(this.id, {this.position = -1});
  bool get isHome => position == -1;
  bool get isCompleted => position == 58;
}
