import 'package:flutter/foundation.dart';
import '../models/match_settings.dart';

class MatchController extends ChangeNotifier {
  final MatchSettings settings;
  final List<int> lifeTotals;

  MatchController({required this.settings})
      : lifeTotals = List.filled(settings.playerCount, settings.startingLife);

  void increment(int playerIndex) {
    if (playerIndex >= 0 && playerIndex < lifeTotals.length) {
      lifeTotals[playerIndex]++;
      notifyListeners();
    }
  }

  void decrement(int playerIndex) {
    if (playerIndex >= 0 && playerIndex < lifeTotals.length) {
      lifeTotals[playerIndex]--;
      notifyListeners();
    }
  }

  void reset() {
    for (int i = 0; i < lifeTotals.length; i++) {
      lifeTotals[i] = settings.startingLife;
    }
    notifyListeners();
  }
}
