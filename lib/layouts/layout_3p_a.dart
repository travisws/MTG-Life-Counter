import 'package:flutter/material.dart';
import '../widgets/player_panel.dart';

class Layout3PA extends StatelessWidget {
  const Layout3PA({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(child: PlayerPanel(playerIndex: 0, quarterTurns: 2)),
              Expanded(child: PlayerPanel(playerIndex: 1, quarterTurns: 0)),
            ],
          ),
        ),
        Expanded(child: PlayerPanel(playerIndex: 2, quarterTurns: 3)),
      ],
    );
  }
}
