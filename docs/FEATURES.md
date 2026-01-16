# Features

Back to spec: **[CLAUDE.md](../CLAUDE.md)**

## MVP (must have)

### F1 — Setup screen
**Requirements**
- Starting life segmented selector: `20, 25, 30, 40, 50, 60`
- Player count segmented selector: `1, 2, 3, 4`
- Orientation section shows **2 options** for the selected player count
- “Start Match” navigates to match

**Acceptance**
- Tapping any segment updates selection and UI highlight
- Player count never offers 5 or 6
- Changing player count resets orientation preset to a valid default

---

### F2 — Layout presets
**Requirements**
- Exactly **8** presets (2 per player count)
- Each preset specifies:
  - panel arrangement (grid/row/column/cross)
  - per-player rotation (`quarterTurns`)

**Acceptance**
- Preset previews on Setup screen reflect the same arrangement as Match screen

See: **[LAYOUT_PRESETS.md](LAYOUT_PRESETS.md)**

---

### F3 — Match screen
**Requirements**
- Renders chosen preset
- Each player panel includes only:
  - life total
  - `-` and `+` buttons

**Acceptance**
- Pressing `+` increments that player’s life
- Pressing `-` decrements that player’s life
- Rotations match the selected preset
- No extra buttons/menus

---

### F4 — Styling
**Requirements**
- Dark background + overlay
- Purple borders + purple selected fill for segmented controls
- Orange “Start Match” CTA

See: **[STYLE_GUIDE.md](STYLE_GUIDE.md)**

---

## Nice-to-have (post-MVP)
See: **[BACKLOG.md](BACKLOG.md)**
