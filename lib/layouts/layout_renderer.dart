import 'package:flutter/material.dart';
import 'presets.dart';
import 'layout_1p_a.dart';
import 'layout_1p_b.dart';
import 'layout_2p_a.dart';
import 'layout_2p_b.dart';
import 'layout_3p_a.dart';
import 'layout_3p_b.dart';
import 'layout_4p_a.dart';
import 'layout_4p_b.dart';

class LayoutRenderer extends StatelessWidget {
  final LayoutPreset preset;

  const LayoutRenderer({super.key, required this.preset});

  @override
  Widget build(BuildContext context) {
    switch (preset) {
      case LayoutPreset.onePlayerA:
        return const Layout1PA();
      case LayoutPreset.onePlayerB:
        return const Layout1PB();
      case LayoutPreset.twoPlayerA:
        return const Layout2PA();
      case LayoutPreset.twoPlayerB:
        return const Layout2PB();
      case LayoutPreset.threePlayerA:
        return const Layout3PA();
      case LayoutPreset.threePlayerB:
        return const Layout3PB();
      case LayoutPreset.fourPlayerA:
        return const Layout4PA();
      case LayoutPreset.fourPlayerB:
        return const Layout4PB();
    }
  }
}
