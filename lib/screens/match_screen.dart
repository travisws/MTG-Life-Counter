import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
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
  @override
  void initState() {
    super.initState();
    // Keep screen awake during match
    WakelockPlus.enable();
  }

  @override
  void dispose() {
    // Allow screen to sleep when leaving match
    WakelockPlus.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MatchController(settings: widget.settings),
      child: Scaffold(
        body: SafeArea(
          child: LayoutRenderer(preset: widget.settings.layoutPreset),
        ),
      ),
    );
  }
}
