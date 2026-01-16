import 'package:flutter/material.dart';
import '../widgets/player_panel.dart';

class Layout4PA extends StatelessWidget {
  const Layout4PA({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(child: PlayerPanel(playerIndex: 0, quarterTurns: 2)),
              Expanded(child: PlayerPanel(playerIndex: 1, quarterTurns: 2)),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(child: PlayerPanel(playerIndex: 2, quarterTurns: 0)),
              Expanded(child: PlayerPanel(playerIndex: 3, quarterTurns: 0)),
            ],
          ),
        ),
      ],
    );
  }
}
