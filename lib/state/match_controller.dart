import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/match_settings.dart';

class MatchController extends ChangeNotifier {
  final MatchSettings settings;
  final List<int> lifeTotals;
  final Set<int> _resetPressedPlayers = {};
  Timer? _resetTimer;
  VoidCallback? onResetTriggered;

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

  void startResetPress(int playerIndex) {
    _resetPressedPlayers.add(playerIndex);
    _checkResetCondition();
  }

  void endResetPress(int playerIndex) {
    _resetPressedPlayers.remove(playerIndex);
    _cancelResetTimer();
  }

  void _checkResetCondition() {
    // If two or more players are long-pressing simultaneously, start the countdown
    if (_resetPressedPlayers.length >= 2 && _resetTimer == null) {
      _resetTimer = Timer(const Duration(seconds: 3), () {
        // Still have 2+ players pressing after 3 seconds? Trigger reset
        if (_resetPressedPlayers.length >= 2) {
          onResetTriggered?.call();
        }
        _resetTimer = null;
      });
    }
  }

  void _cancelResetTimer() {
    if (_resetPressedPlayers.length < 2) {
      _resetTimer?.cancel();
      _resetTimer = null;
    }
  }

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }
}
