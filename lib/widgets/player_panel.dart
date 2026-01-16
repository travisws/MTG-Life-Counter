/// Player panel widget displaying life total with controls.
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/match_controller.dart';
import '../theme/app_theme.dart';
import 'life_adjustment_dialog.dart';

/// Displays a single player's life total with increment/decrement controls.
///
/// Features:
/// - Tap +/- buttons for single changes
/// - Long-press +/- for rapid repeated changes (100ms interval)
/// - Long-press life total for 30 seconds to trigger reset
/// - Responsive font sizing based on available space
class PlayerPanel extends StatefulWidget {
  /// Zero-based index identifying which player this panel represents.
  final int playerIndex;

  /// Rotation in quarter turns (0=0°, 1=90°, 2=180°, 3=270°).
  final int quarterTurns;

  const PlayerPanel({
    super.key,
    required this.playerIndex,
    this.quarterTurns = 0,
  });

  @override
  State<PlayerPanel> createState() => _PlayerPanelState();
}

class _PlayerPanelState extends State<PlayerPanel> {
  Timer? _repeatTimer;

  /// Interval for repeated life changes during long-press.
  /// 180ms provides ~5-6 changes per second - fast enough to be useful
  /// but slow enough to stop at the desired number.
  static const _repeatInterval = Duration(milliseconds: 180);

  void _startRepeat({required bool increment}) {
    _stopRepeat();

    final controller = context.read<MatchController>();
    final action =
        increment ? controller.increment : controller.decrement;

    // Execute immediately
    action(widget.playerIndex);

    // Then repeat at interval
    _repeatTimer = Timer.periodic(_repeatInterval, (_) {
      action(widget.playerIndex);
    });
  }

  void _stopRepeat() {
    _repeatTimer?.cancel();
    _repeatTimer = null;
  }

  @override
  void dispose() {
    _stopRepeat();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        AppColors.playerColors[widget.playerIndex % AppColors.playerColors.length];
    final controller = context.read<MatchController>();

    return RotatedBox(
      quarterTurns: widget.quarterTurns,
      child: Container(
        color: backgroundColor,
        child: Selector<MatchController, int>(
          selector: (_, controller) =>
              controller.lifeTotals[widget.playerIndex],
          builder: (context, lifeTotal, _) {
            return _buildContent(context, controller, lifeTotal);
          },
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    MatchController controller,
    int lifeTotal,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Scale fonts based on available height
        final lifeTotalSize = (constraints.maxHeight * 0.25).clamp(48.0, 120.0);
        final buttonSize = (constraints.maxHeight * 0.15).clamp(36.0, 72.0);

        return Row(
          children: [
            _buildLifeButton(
              label: '-',
              fontSize: buttonSize,
              onTap: () => controller.decrement(widget.playerIndex),
              onLongPressStart: () => _startRepeat(increment: false),
            ),
            _buildLifeTotalDisplay(controller, lifeTotal, lifeTotalSize),
            _buildLifeButton(
              label: '+',
              fontSize: buttonSize,
              onTap: () => controller.increment(widget.playerIndex),
              onLongPressStart: () => _startRepeat(increment: true),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLifeButton({
    required String label,
    required double fontSize,
    required VoidCallback onTap,
    required VoidCallback onLongPressStart,
  }) {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: onTap,
        onLongPressStart: (_) => onLongPressStart(),
        onLongPressEnd: (_) => _stopRepeat(),
        onLongPressCancel: _stopRepeat,
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.lifeDelta.copyWith(fontSize: fontSize),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLifeTotalDisplay(
    MatchController controller,
    int lifeTotal,
    double fontSize,
  ) {
    return Expanded(
      flex: 3,
      child: GestureDetector(
        onDoubleTap: () => _showLifeAdjustmentDialog(controller),
        onLongPressStart: (_) => controller.startResetPress(),
        onLongPressEnd: (_) => controller.endResetPress(),
        onLongPressCancel: controller.endResetPress,
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: Text(
              '$lifeTotal',
              style: AppTextStyles.lifeTotal.copyWith(fontSize: fontSize),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showLifeAdjustmentDialog(MatchController controller) async {
    final result = await showLifeAdjustmentDialog(
      context,
      quarterTurns: widget.quarterTurns,
    );

    if (result != null && mounted) {
      controller.adjustLife(widget.playerIndex, result.signedValue);
    }
  }
}
