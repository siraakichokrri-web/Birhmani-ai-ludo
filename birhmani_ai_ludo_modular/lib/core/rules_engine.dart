class RulesEngine {
  static const startIndices = [0,13,26,39];
  static const safeSquares = [0,8,13,21,26,34,39,47];

  static int stepsToFinish(int colorIndex, int position) {
    if (position == -1) return 999;
    if (position >= 52) return 58 - position;
    int start = startIndices[colorIndex];
    int entry = (start + 51) % 52;
    int distToEntry = (entry - position + 52) % 52;
    return distToEntry + 6;
  }

  static int? moveTokenPosition(int colorIndex, int oldPos, int dice) {
    if (oldPos == -1) {
      if (dice == 6) return startIndices[colorIndex];
      return null;
    }
    if (oldPos >= 52) {
      int newPos = oldPos + dice;
      if (newPos > 58) return null;
      if (newPos == 58) return 58;
      return newPos;
    }
    int stepsFromStart = (oldPos - startIndices[colorIndex] + 52) % 52;
    int remainingToFinishEntry = (51 - stepsFromStart);
    if (dice > remainingToFinishEntry) {
      int intoFinish = dice - remainingToFinishEntry - 1;
      int pos = 52 + colorIndex*6 + intoFinish;
      if (pos > 52 + colorIndex*6 + 5) return null;
      return pos;
    } else {
      return (oldPos + dice) % 52;
    }
  }

  static bool isSafeSquare(int pos) {
    if (pos < 0) return false;
    if (pos >= 52) return true;
    return safeSquares.contains(pos);
  }
}
