enum LayoutPreset {
  onePlayerA,
  onePlayerB,
  twoPlayerA,
  twoPlayerB,
  threePlayerA,
  threePlayerB,
  fourPlayerA,
  fourPlayerB,
}

extension LayoutPresetExtension on LayoutPreset {
  int get playerCount {
    switch (this) {
      case LayoutPreset.onePlayerA:
      case LayoutPreset.onePlayerB:
        return 1;
      case LayoutPreset.twoPlayerA:
      case LayoutPreset.twoPlayerB:
        return 2;
      case LayoutPreset.threePlayerA:
      case LayoutPreset.threePlayerB:
        return 3;
      case LayoutPreset.fourPlayerA:
      case LayoutPreset.fourPlayerB:
        return 4;
    }
  }

  bool get isVariantA {
    switch (this) {
      case LayoutPreset.onePlayerA:
      case LayoutPreset.twoPlayerA:
      case LayoutPreset.threePlayerA:
      case LayoutPreset.fourPlayerA:
        return true;
      case LayoutPreset.onePlayerB:
      case LayoutPreset.twoPlayerB:
      case LayoutPreset.threePlayerB:
      case LayoutPreset.fourPlayerB:
        return false;
    }
  }

  static List<LayoutPreset> presetsForPlayerCount(int count) {
    switch (count) {
      case 1:
        return [LayoutPreset.onePlayerA, LayoutPreset.onePlayerB];
      case 2:
        return [LayoutPreset.twoPlayerA, LayoutPreset.twoPlayerB];
      case 3:
        return [LayoutPreset.threePlayerA, LayoutPreset.threePlayerB];
      case 4:
        return [LayoutPreset.fourPlayerA, LayoutPreset.fourPlayerB];
      default:
        return [LayoutPreset.onePlayerA, LayoutPreset.onePlayerB];
    }
  }
}
