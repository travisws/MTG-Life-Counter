# Test plan (manual)

Back to spec: **[CLAUDE.md](../CLAUDE.md)**

## Setup screen
- [ ] Default starting life is 40
- [ ] Life selector toggles highlight correctly
- [ ] Player selector only shows 1–4
- [ ] Switching player count resets orientation to a valid default
- [ ] Orientation shows exactly 2 choices for each player count
- [ ] Start Match navigates to Match screen

## Match screen — general
- [ ] Only life total and +/- appear
- [ ] No extra menus/buttons
- [ ] No overflow on typical phone sizes

## Match screen — per player count

### 1 player
- [ ] Preset A renders fullscreen rotated 270
- [ ] Preset B renders fullscreen upright

### 2 players
- [ ] Preset A: two panels side-by-side; left rotated 90, right rotated 270
- [ ] Preset B: two panels side-by-side; both upright

### 3 players
- [ ] Preset A: L-shape; top-left 180, bottom-left 0, right tall 270
- [ ] Preset B: three panels in a row; all upright

### 4 players
- [ ] Preset A: 2x2; top row 180, bottom row 0
- [ ] Preset B: cross; top 180, bottom 0, left 90, right 270

## Life changes
- [ ] +/- updates correct player only
- [ ] Values can go below 0 (unless you decide to clamp later)
