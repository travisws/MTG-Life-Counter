/// Match screen displaying player panels during gameplay.
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../layouts/layout_renderer.dart';
import '../models/match_settings.dart';
import '../state/match_controller.dart';
import '../widgets/undo_button.dart';

/// Main gameplay screen showing life totals for all players.
///
/// Features:
/// - Keeps screen awake during gameplay
/// - Sets brightness to maximum for visibility
/// - Restores original settings when leaving
class MatchScreen extends StatefulWidget {
  /// Configuration for this match session.
  final MatchSettings settings;

  const MatchScreen({super.key, required this.settings});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  late final MatchController _controller;
  double? _originalBrightness;

  @override
  void initState() {
    super.initState();
    _enableGameplayMode();
    _initializeController();
  }

  /// Enables wakelock and max brightness for gameplay.
  void _enableGameplayMode() {
    unawaited(WakelockPlus.enable());
    unawaited(_setMaxBrightness());
  }

  /// Initializes the match controller with reset callback.
  void _initializeController() {
    _controller = MatchController(settings: widget.settings);
    _controller.onResetTriggered = _handleReset;
  }

  Future<void> _setMaxBrightness() async {
    try {
      _originalBrightness = await ScreenBrightness().current;
      await ScreenBrightness().setScreenBrightness(1.0);
    } catch (e) {
      debugPrint('Failed to set brightness: $e');
    }
  }

  Future<void> _restoreBrightness() async {
    try {
      if (_originalBrightness != null) {
        await ScreenBrightness().setScreenBrightness(_originalBrightness!);
      } else {
        await ScreenBrightness().resetScreenBrightness();
      }
    } catch (e) {
      debugPrint('Failed to restore brightness: $e');
    }
  }

  void _handleReset() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    unawaited(WakelockPlus.disable());
    unawaited(_restoreBrightness());
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              LayoutRenderer(preset: widget.settings.layoutPreset),
              const Positioned.fill(
                child: Center(
                  child: UndoButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
