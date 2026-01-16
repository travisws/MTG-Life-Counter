/// State management for an active match.
library;

import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../models/match_settings.dart';

/// Manages mutable state during an active match.
///
/// Responsibilities:
/// - Track life totals for each player
/// - Handle increment/decrement operations
/// - Manage the 30-second long-press reset timer
/// - Track undo history with debounced snapshots
///
/// Usage:
/// ```dart
/// final controller = MatchController(settings: settings);
/// controller.onResetTriggered = () => Navigator.pop(context);
/// ```
class MatchController extends ChangeNotifier {
  /// The immutable settings for this match.
  final MatchSettings settings;

  /// Internal storage for life totals.
  final List<int> _lifeTotals;

  /// Read-only view for external access.
  late final UnmodifiableListView<int> _lifeTotalsView;

  /// Timer for the long-press reset gesture.
  Timer? _resetTimer;

  /// Timer for debouncing undo snapshots.
  Timer? _undoDebounceTimer;

  /// Stack of previous life total states for undo functionality.
  final List<List<int>> _undoHistory = [];

  /// Maximum number of undo states to keep.
  static const int _maxUndoHistory = 50;

  /// Duration of inactivity before saving an undo point.
  /// 10 seconds allows an entire "turn" of activity to be grouped together.
  static const Duration undoDebounceDelay = Duration(seconds: 10);

  /// Callback invoked when the 30-second reset is triggered.
  ///
  /// Typically used to navigate back to the setup screen.
  VoidCallback? onResetTriggered;

  /// Duration required for long-press reset gesture.
  static const Duration resetDuration = Duration(seconds: 30);

  /// Creates a controller initialized with the given [settings].
  ///
  /// All players start with [MatchSettings.startingLife].
  MatchController({required this.settings})
      : _lifeTotals = List.filled(settings.playerCount, settings.startingLife) {
    _lifeTotalsView = UnmodifiableListView(_lifeTotals);
  }

  /// Read-only access to current life totals.
  ///
  /// Use [increment] and [decrement] to modify values.
  List<int> get lifeTotals => _lifeTotalsView;

  /// Whether there are any undo states available.
  bool get canUndo => _undoHistory.isNotEmpty;

  /// Returns the life total for a specific player.
  ///
  /// Returns null if [playerIndex] is out of bounds.
  int? getLifeTotal(int playerIndex) {
    if (!_isValidIndex(playerIndex)) return null;
    return _lifeTotals[playerIndex];
  }

  /// Schedules an undo snapshot after debounce delay.
  ///
  /// Called before any life total modification. If no changes happen
  /// within [undoDebounceDelay], the current state is saved to history.
  void _scheduleUndoSnapshot() {
    // If this is the first change in a batch, save the current state
    if (_undoDebounceTimer == null || !_undoDebounceTimer!.isActive) {
      _saveUndoSnapshot();
    }

    // Reset the debounce timer
    _undoDebounceTimer?.cancel();
    _undoDebounceTimer = Timer(undoDebounceDelay, () {
      // Timer fired - next change will start a new batch
    });
  }

  /// Saves the current life totals to the undo history.
  void _saveUndoSnapshot() {
    _undoHistory.add(List<int>.from(_lifeTotals));

    // Limit history size
    while (_undoHistory.length > _maxUndoHistory) {
      _undoHistory.removeAt(0);
    }

    notifyListeners(); // Update canUndo state
  }

  /// Increases the life total for [playerIndex] by 1.
  void increment(int playerIndex) {
    if (!_isValidIndex(playerIndex)) return;
    _scheduleUndoSnapshot();
    _lifeTotals[playerIndex]++;
    notifyListeners();
  }

  /// Decreases the life total for [playerIndex] by 1.
  void decrement(int playerIndex) {
    if (!_isValidIndex(playerIndex)) return;
    _scheduleUndoSnapshot();
    _lifeTotals[playerIndex]--;
    notifyListeners();
  }

  /// Adjusts the life total for [playerIndex] by [amount].
  ///
  /// Use positive values to add life, negative values to subtract.
  void adjustLife(int playerIndex, int amount) {
    if (!_isValidIndex(playerIndex)) return;
    if (amount == 0) return;
    _scheduleUndoSnapshot();
    _lifeTotals[playerIndex] += amount;
    notifyListeners();
  }

  /// Undoes the last batch of changes.
  ///
  /// Restores life totals to the state before the most recent
  /// batch of rapid changes.
  void undo() {
    if (!canUndo) return;

    // Cancel any pending debounce timer
    _undoDebounceTimer?.cancel();
    _undoDebounceTimer = null;

    final previousState = _undoHistory.removeLast();
    for (var i = 0; i < _lifeTotals.length && i < previousState.length; i++) {
      _lifeTotals[i] = previousState[i];
    }
    notifyListeners();
  }

  /// Resets all life totals to the starting value.
  void reset() {
    _scheduleUndoSnapshot();
    for (var i = 0; i < _lifeTotals.length; i++) {
      _lifeTotals[i] = settings.startingLife;
    }
    notifyListeners();
  }

  /// Begins the 30-second countdown for triggering a reset.
  ///
  /// Call this when a long-press gesture starts on the life total.
  void startResetPress() {
    _resetTimer?.cancel();
    _resetTimer = Timer(resetDuration, () {
      onResetTriggered?.call();
      _resetTimer = null;
    });
  }

  /// Cancels the reset countdown.
  ///
  /// Call this when the long-press gesture ends or is cancelled.
  void endResetPress() {
    _resetTimer?.cancel();
    _resetTimer = null;
  }

  /// Validates that [index] is within bounds.
  bool _isValidIndex(int index) => index >= 0 && index < _lifeTotals.length;

  @override
  void dispose() {
    _resetTimer?.cancel();
    _undoDebounceTimer?.cancel();
    super.dispose();
  }
}
