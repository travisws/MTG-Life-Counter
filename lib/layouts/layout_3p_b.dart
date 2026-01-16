import 'package:flutter/material.dart';
import '../widgets/player_panel.dart';

class Layout3PB extends StatelessWidget {
  const Layout3PB({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: PlayerPanel(playerIndex: 0, quarterTurns: 0)),
        Expanded(child: PlayerPanel(playerIndex: 1, quarterTurns: 0)),
        Expanded(child: PlayerPanel(playerIndex: 2, quarterTurns: 0)),
      ],
    );
  }
}
