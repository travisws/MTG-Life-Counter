import 'package:flutter/material.dart';
import '../layouts/presets.dart';
import '../theme/app_theme.dart';
import 'layout_preview.dart';

class OrientationPicker extends StatelessWidget {
  final int playerCount;
  final LayoutPreset selectedPreset;
  final ValueChanged<LayoutPreset> onChanged;

  const OrientationPicker({
    super.key,
    required this.playerCount,
    required this.selectedPreset,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final presets = LayoutPresetExtension.presetsForPlayerCount(playerCount);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: presets.map((preset) {
        final isSelected = preset == selectedPreset;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: GestureDetector(
            onTap: () => onChanged(preset),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LayoutPreview(
                  preset: preset,
                  isSelected: isSelected,
                ),
                const SizedBox(height: 8),
                Text(
                  preset.isVariantA ? 'Option A' : 'Option B',
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
