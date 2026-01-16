# Implementation plan

Back to spec: **[CLAUDE.md](../CLAUDE.md)**

## Phase 0 — Project bootstrap
1. Create Flutter app
2. Add dependencies (`provider`, optional `wakelock_plus`)
3. Create folder structure (see ARCHITECTURE)

## Phase 1 — Theme + shared UI components
1. Implement `AppTheme` (colors, text styles)
2. Build `SegmentedSelector<T>`
3. Build `OrientationPicker` + `LayoutPreview` drawing

## Phase 2 — SetupScreen
1. Compose sections:
   - Starting life selector
   - Player count selector (1–4)
   - Orientation picker (2 options for chosen count)
2. “Start Match” builds `MatchSettings` and routes to MatchScreen

## Phase 3 — Match core
1. Implement `MatchController` (life totals list)
2. Implement `PlayerPanel` (life + +/- only)
3. Implement `LayoutRenderer` with 8 explicit preset widgets

## Phase 4 — Polish
1. SafeArea and responsive scaling
2. Optional: keep screen awake in match
3. Optional: long-press repeat +/-

## Phase 5 — QA
Run through: **[TEST_PLAN.md](TEST_PLAN.md)**
