/// Central undo button widget for the match screen.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/match_controller.dart';

/// A floating undo button that appears in the center of the match screen.
///
/// Features:
/// - Semi-transparent circular design
/// - Only visible when undo history is available
/// - Positioned at the center of the screen
class UndoButton extends StatelessWidget {
  const UndoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<MatchController, bool>(
      selector: (_, controller) => controller.canUndo,
      builder: (context, canUndo, _) {
        return AnimatedOpacity(
          opacity: canUndo ? 1.0 : 0.3,
          duration: const Duration(milliseconds: 200),
          child: GestureDetector(
            onTap: canUndo
                ? () => context.read<MatchController>().undo()
                : null,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.undo_rounded,
                color: canUndo
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.5),
                size: 28,
              ),
            ),
          ),
        );
      },
    );
  }
}
