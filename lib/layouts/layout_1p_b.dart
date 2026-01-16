import 'package:flutter/material.dart';
import '../widgets/player_panel.dart';

class Layout1PB extends StatelessWidget {
  const Layout1PB({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlayerPanel(playerIndex: 0, quarterTurns: 0);
  }
}
