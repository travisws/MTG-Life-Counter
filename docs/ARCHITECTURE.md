# Architecture

Back to spec: **[CLAUDE.md](../CLAUDE.md)**

## State model

### MatchSettings (immutable)
Fields:
- `int startingLife`
- `int playerCount` (1–4)
- `LayoutPreset layoutPreset`

### MatchController (ChangeNotifier)
Fields:
- `MatchSettings settings`
- `List<int> lifeTotals` (length == playerCount)

Methods:
- `increment(int playerIndex)`
- `decrement(int playerIndex)`
- (optional) `reset()`

## UI layers

### SetupScreen
Responsibilities:
- Maintain temporary selections (or store in a SetupController)
- Render selectors and orientation options
- Construct `MatchSettings`
- Navigate to MatchScreen

### MatchScreen
Responsibilities:
- Own/provide `MatchController`
- Render the selected layout preset
- Delegate per-player UI to `PlayerPanel`

## Layout system

### Approach (explicit first)
Implement one widget per preset (recommended for MVP):
- `Layout1P_A`, `Layout1P_B`
- `Layout2P_A`, `Layout2P_B`
- `Layout3P_A`, `Layout3P_B`
- `Layout4P_A`, `Layout4P_B`

Then select with a `switch(layoutPreset)` in `LayoutRenderer`.

### Rotations
Use `RotatedBox(quarterTurns: N)` on the **whole player panel**.

## Suggested lib/ structure

```text
lib/
  main.dart
  theme/app_theme.dart
  models/match_settings.dart
  state/match_controller.dart
  screens/setup_screen.dart
  screens/match_screen.dart
  widgets/
    segmented_selector.dart
    orientation_picker.dart
    layout_preview.dart
    player_panel.dart
  layouts/
    presets.dart
    layout_renderer.dart
    layout_1p_a.dart
    ...
```

## Dependencies
- `provider` for state
- `wakelock_plus` optional
