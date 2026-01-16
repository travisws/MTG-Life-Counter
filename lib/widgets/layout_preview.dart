import 'package:flutter/material.dart';
import '../layouts/presets.dart';
import '../theme/app_theme.dart';

class LayoutPreview extends StatelessWidget {
  final LayoutPreset preset;
  final bool isSelected;
  final double size;

  const LayoutPreview({
    super.key,
    required this.preset,
    this.isSelected = false,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * 1.5,
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? AppColors.purple : AppColors.border,
          width: isSelected ? 3 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? AppColors.purple.withValues(alpha: 0.2) : Colors.transparent,
      ),
      padding: const EdgeInsets.all(4),
      child: _buildPreviewLayout(),
    );
  }

  Widget _buildPreviewLayout() {
    switch (preset) {
      case LayoutPreset.onePlayerA:
        return _buildOnePlayerA();
      case LayoutPreset.onePlayerB:
        return _buildOnePlayerB();
      case LayoutPreset.twoPlayerA:
        return _buildTwoPlayerA();
      case LayoutPreset.twoPlayerB:
        return _buildTwoPlayerB();
      case LayoutPreset.threePlayerA:
        return _buildThreePlayerA();
      case LayoutPreset.threePlayerB:
        return _buildThreePlayerB();
      case LayoutPreset.fourPlayerA:
        return _buildFourPlayerA();
      case LayoutPreset.fourPlayerB:
        return _buildFourPlayerB();
    }
  }

  // 1P_A: Fullscreen sideways (270 rotation)
  Widget _buildOnePlayerA() {
    return _panel(0, rotation: 3);
  }

  // 1P_B: Fullscreen upright
  Widget _buildOnePlayerB() {
    return _panel(0);
  }

  // 2P_A: Side-by-side, opposing sideways
  Widget _buildTwoPlayerA() {
    return Row(
      children: [
        Expanded(child: _panel(0, rotation: 1)),
        const SizedBox(width: 2),
        Expanded(child: _panel(1, rotation: 3)),
      ],
    );
  }

  // 2P_B: Side-by-side, both upright
  Widget _buildTwoPlayerB() {
    return Row(
      children: [
        Expanded(child: _panel(0)),
        const SizedBox(width: 2),
        Expanded(child: _panel(1)),
      ],
    );
  }

  // 3P_A: L-shape (2 stacked on left, 1 tall on right)
  Widget _buildThreePlayerA() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(child: _panel(0, rotation: 2)),
              const SizedBox(height: 2),
              Expanded(child: _panel(1)),
            ],
          ),
        ),
        const SizedBox(width: 2),
        Expanded(child: _panel(2, rotation: 3)),
      ],
    );
  }

  // 3P_B: Three-in-a-row upright
  Widget _buildThreePlayerB() {
    return Row(
      children: [
        Expanded(child: _panel(0)),
        const SizedBox(width: 2),
        Expanded(child: _panel(1)),
        const SizedBox(width: 2),
        Expanded(child: _panel(2)),
      ],
    );
  }

  // 4P_A: 2x2 grid, top upside-down
  Widget _buildFourPlayerA() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: _panel(0, rotation: 2)),
              const SizedBox(width: 2),
              Expanded(child: _panel(1, rotation: 2)),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Expanded(
          child: Row(
            children: [
              Expanded(child: _panel(2)),
              const SizedBox(width: 2),
              Expanded(child: _panel(3)),
            ],
          ),
        ),
      ],
    );
  }

  // 4P_B: Cross layout
  Widget _buildFourPlayerB() {
    return Row(
      children: [
        Expanded(child: _panel(2, rotation: 1)),
        const SizedBox(width: 2),
        Expanded(
          child: Column(
            children: [
              Expanded(child: _panel(0, rotation: 2)),
              const SizedBox(height: 2),
              Expanded(child: _panel(1)),
            ],
          ),
        ),
        const SizedBox(width: 2),
        Expanded(child: _panel(3, rotation: 3)),
      ],
    );
  }

  Widget _panel(int playerIndex, {int rotation = 0}) {
    final color = AppColors.playerColors[playerIndex % AppColors.playerColors.length];
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: RotatedBox(
        quarterTurns: rotation,
        child: Center(
          child: Text(
            '${playerIndex + 1}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
