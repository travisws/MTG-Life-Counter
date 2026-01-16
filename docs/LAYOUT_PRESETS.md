# Layout presets

Back to spec: **[CLAUDE.md](../CLAUDE.md)**

All rotations are `RotatedBox(quarterTurns: N)`.

## 1 player (2 presets)

### 1P_A — Fullscreen sideways
- Panels: 1 fullscreen
- Rotation:
  - P1: `3` (270°)

### 1P_B — Fullscreen upright
- Panels: 1 fullscreen
- Rotation:
  - P1: `0`

---

## 2 players (2 presets)

### 2P_A — Side-by-side, opposing sideways
- Layout: Row of 2 equal panels
- Rotation:
  - P1 (left): `1` (90°)
  - P2 (right): `3` (270°)

### 2P_B — Side-by-side, both upright
- Layout: Row of 2 equal panels
- Rotation:
  - P1: `0`
  - P2: `0`

---

## 3 players (2 presets)

### 3P_A — L-shape (2 stacked on left, 1 tall on right)
- Layout:
  - Left column: two stacked panels (top-left, bottom-left)
  - Right column: one panel spanning full height
- Rotation:
  - P1 (top-left): `2` (180°)
  - P2 (bottom-left): `0`
  - P3 (right tall): `3` (270°)

### 3P_B — Three-in-a-row upright
- Layout: Row of 3 equal panels
- Rotation:
  - P1: `0`
  - P2: `0`
  - P3: `0`

---

## 4 players (2 presets)

### 4P_A — 2×2 grid, top upside-down
- Layout: 2 rows × 2 columns
- Rotation:
  - P1 (top-left): `2`
  - P2 (top-right): `2`
  - P3 (bottom-left): `0`
  - P4 (bottom-right): `0`

### 4P_B — Cross layout (left/right sideways, top/bottom vertical)
- Layout:
  - Left: tall panel spanning full height
  - Center: two stacked panels (top, bottom)
  - Right: tall panel spanning full height
- Rotation:
  - P1 (top center): `2`
  - P2 (bottom center): `0`
  - P3 (left tall): `1`
  - P4 (right tall): `3`
