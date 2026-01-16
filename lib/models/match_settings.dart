import '../layouts/presets.dart';

class MatchSettings {
  final int startingLife;
  final int playerCount;
  final LayoutPreset layoutPreset;

  const MatchSettings({
    required this.startingLife,
    required this.playerCount,
    required this.layoutPreset,
  });

  MatchSettings copyWith({
    int? startingLife,
    int? playerCount,
    LayoutPreset? layoutPreset,
  }) {
    return MatchSettings(
      startingLife: startingLife ?? this.startingLife,
      playerCount: playerCount ?? this.playerCount,
      layoutPreset: layoutPreset ?? this.layoutPreset,
    );
  }
}
