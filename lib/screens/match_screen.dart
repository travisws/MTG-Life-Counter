import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:screen_brightness/screen_brightness.dart';
import '../models/match_settings.dart';
import '../state/match_controller.dart';
import '../layouts/layout_renderer.dart';

class MatchScreen extends StatefulWidget {
  final MatchSettings settings;

  const MatchScreen({super.key, required this.settings});

  @override
  State<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  late MatchController _controller;
  double? _originalBrightness;

  @override
  void initState() {
    super.initState();
    // Keep screen awake during match
    WakelockPlus.enable();

    // Set brightness to maximum
    _setMaxBrightness();

    // Initialize controller and set up reset callback
    _controller = MatchController(settings: widget.settings);
    _controller.onResetTriggered = _handleReset;
  }

  Future<void> _setMaxBrightness() async {
    try {
      // Save current brightness
      _originalBrightness = await ScreenBrightness().current;
      // Set to maximum brightness
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
        // Reset to system brightness if we couldn't save the original
        await ScreenBrightness().resetScreenBrightness();
      }
    } catch (e) {
      debugPrint('Failed to restore brightness: $e');
    }
  }

  void _handleReset() {
    // Navigate back to setup screen
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // Allow screen to sleep when leaving match
    WakelockPlus.disable();
    // Restore original brightness
    _restoreBrightness();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Scaffold(
        body: SafeArea(
          child: LayoutRenderer(preset: widget.settings.layoutPreset),
        ),
      ),
    );
  }
}
