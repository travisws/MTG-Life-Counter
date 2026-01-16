import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/match_controller.dart';
import '../theme/app_theme.dart';

class PlayerPanel extends StatefulWidget {
  final int playerIndex;
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

  void _startRepeat(BuildContext context, bool isIncrement) {
    final controller = context.read<MatchController>();

    // Initial action
    if (isIncrement) {
      controller.increment(widget.playerIndex);
    } else {
      controller.decrement(widget.playerIndex);
    }

    // Start repeating after a brief delay
    _repeatTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      if (isIncrement) {
        controller.increment(widget.playerIndex);
      } else {
        controller.decrement(widget.playerIndex);
      }
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
    return RotatedBox(
      quarterTurns: widget.quarterTurns,
      child: Container(
        color: AppColors.playerColors[widget.playerIndex % AppColors.playerColors.length],
        child: Consumer<MatchController>(
          builder: (context, controller, _) {
            final lifeTotal = controller.lifeTotals[widget.playerIndex];

            return LayoutBuilder(
              builder: (context, constraints) {
                // Scale font sizes based on available height
                // This ensures the panel looks good on different screen sizes
                final availableHeight = constraints.maxHeight;
                final lifeTotalSize = (availableHeight * 0.25).clamp(48.0, 120.0);
                final buttonSize = (availableHeight * 0.15).clamp(36.0, 72.0);

                return Row(
                  children: [
                    // Minus button
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () => controller.decrement(widget.playerIndex),
                        onLongPressStart: (_) => _startRepeat(context, false),
                        onLongPressEnd: (_) => _stopRepeat(),
                        onLongPressCancel: () => _stopRepeat(),
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: Text(
                              '-',
                              style: AppTextStyles.lifeDelta.copyWith(fontSize: buttonSize),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Life total
                    Expanded(
                      flex: 3,
                      child: Center(
                        child: Text(
                          '$lifeTotal',
                          style: AppTextStyles.lifeTotal.copyWith(fontSize: lifeTotalSize),
                        ),
                      ),
                    ),

                    // Plus button
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () => controller.increment(widget.playerIndex),
                        onLongPressStart: (_) => _startRepeat(context, true),
                        onLongPressEnd: (_) => _stopRepeat(),
                        onLongPressCancel: () => _stopRepeat(),
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: Text(
                              '+',
                              style: AppTextStyles.lifeDelta.copyWith(fontSize: buttonSize),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
