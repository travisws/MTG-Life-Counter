import 'package:flutter/material.dart';
import '../widgets/player_panel.dart';

class Layout2PA extends StatelessWidget {
  const Layout2PA({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: PlayerPanel(playerIndex: 0, quarterTurns: 1)),
        Expanded(child: PlayerPanel(playerIndex: 1, quarterTurns: 3)),
      ],
    );
  }
}
