import 'package:flutter/material.dart';
import '../widgets/player_panel.dart';

class Layout1PA extends StatelessWidget {
  const Layout1PA({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlayerPanel(playerIndex: 0, quarterTurns: 3);
  }
}
