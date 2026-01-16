import 'package:flutter/material.dart';
import '../models/match_settings.dart';
import '../layouts/presets.dart';
import '../theme/app_theme.dart';
import '../widgets/segmented_selector.dart';
import '../widgets/orientation_picker.dart';
import 'match_screen.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int _startingLife = 20;
  int _playerCount = 2;
  LayoutPreset _layoutPreset = LayoutPreset.twoPlayerA;

  void _updatePlayerCount(int count) {
    setState(() {
      _playerCount = count;
      final presets = LayoutPresetExtension.presetsForPlayerCount(count);
      _layoutPreset = presets.first;
    });
  }

  void _startMatch() {
    final settings = MatchSettings(
      startingLife: _startingLife,
      playerCount: _playerCount,
      layoutPreset: _layoutPreset,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MatchScreen(settings: settings),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 40),

                        // Title
                        const Text(
                          'MTG LIFE COUNTER',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 60),

                        // Starting Life section
                        const Text(
                          'STARTING LIFE',
                          style: AppTextStyles.sectionHeader,
                        ),
                        const SizedBox(height: 12),
                        SegmentedSelector<int>(
                          options: const [20, 25, 30, 40, 50, 60],
                          selectedValue: _startingLife,
                          onChanged: (value) => setState(() => _startingLife = value),
                          labelBuilder: (value) => '$value',
                        ),

                        const SizedBox(height: 40),

                        // Player Count section
                        const Text(
                          'PLAYERS',
                          style: AppTextStyles.sectionHeader,
                        ),
                        const SizedBox(height: 12),
                        SegmentedSelector<int>(
                          options: const [1, 2, 3, 4],
                          selectedValue: _playerCount,
                          onChanged: _updatePlayerCount,
                          labelBuilder: (value) => '$value',
                        ),

                        const SizedBox(height: 40),

                        // Orientation section
                        const Text(
                          'LAYOUT',
                          style: AppTextStyles.sectionHeader,
                        ),
                        const SizedBox(height: 20),
                        OrientationPicker(
                          playerCount: _playerCount,
                          selectedPreset: _layoutPreset,
                          onChanged: (preset) => setState(() => _layoutPreset = preset),
                        ),

                        const Spacer(),

                        // Start Match button
                        ElevatedButton(
                          onPressed: _startMatch,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.purple,
                            foregroundColor: AppColors.textPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'START MATCH',
                            style: AppTextStyles.buttonText,
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
