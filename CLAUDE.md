# CLAUDE.md — MTG Life Counter (Flutter)

This file is the primary source of truth for how to build this project.

## Project goal
Build a Flutter **MTG life counter** with:
- A **Setup/Start** screen modeled after the provided reference screenshots.
- A **Match** screen that only shows **life total + plus/minus** (nothing else).
- Support for **1–4 players only**.
- For each player count, provide **2 layout/orientation presets** that match the screenshot patterns.

## Non-goals
- No commander damage, poison, mana, counters, tax, history, etc.
- No online accounts, sync, ads, or purchases.

## Repository map
- `README.md` — quick start + dev workflow
- `docs/FEATURES.md` — feature list + acceptance criteria
- `docs/ARCHITECTURE.md` — state model, layout system, screen responsibilities
- `docs/LAYOUT_PRESETS.md` — exact presets and rotation rules
- `docs/IMPLEMENTATION_PLAN.md` — step-by-step build plan
- `docs/STYLE_GUIDE.md` — UI styling rules to match the references
- `docs/TEST_PLAN.md` — manual QA checklist
- `docs/BACKLOG.md` — optional enhancements

> If anything conflicts, **this file wins**.

---

## Product requirements

### Screens
1) **SetupScreen**
- Segmented selector: starting life `20, 25, 30, 40, 50, 60`
- Segmented selector: player count `1, 2, 3, 4`
- Orientation section: **two preset choices** for the selected player count
- Primary CTA: **Start Match**

2) **MatchScreen**
- Renders the chosen layout preset for the chosen player count
- Each player area shows:
  - Life total (large)
  - `-` and `+` buttons
- No other controls on screen

### Layout/rotation rules
Use `RotatedBox(quarterTurns: N)`:
- `0` = 0°
- `1` = 90° clockwise
- `2` = 180°
- `3` = 270° clockwise

Presets are defined in **docs/LAYOUT_PRESETS.md**.

---

## Implementation principles

### Keep it explicit
Prefer **one widget per preset** over a generic “layout engine” until the app is stable.

### State management
Use `ChangeNotifier` + `Provider`:
- `MatchSettings` (immutable): startingLife, playerCount, layoutPreset
- `MatchController` (ChangeNotifier): `List<int> lifeTotals` + increment/decrement

### Visual consistency
Match the screenshot style:
- Dark background image + overlay
- Purple/blue border for segmented options
- Selected state: purple fill
- CTA button: orange

Details in: [docs/STYLE_GUIDE.md](docs/STYLE_GUIDE.md)

---

## Definition of done
A release is acceptable when:
- Setup screen matches the layout and behavior described above.
- Player count is restricted to **1–4**.
- Each player count has **exactly 2** working presets.
- Match screen shows **only life + +/-** and correctly rotates panels.
- No overflow/layout breakage on common phones in portrait.

---

## Work order (recommended)
Follow: [docs/IMPLEMENTATION_PLAN.md](docs/IMPLEMENTATION_PLAN.md)

Then validate with: [docs/TEST_PLAN.md](docs/TEST_PLAN.md)

---

## How to use these docs
- Start at **CLAUDE.md**
- Jump to **FEATURES** for scope and acceptance criteria
- Jump to **LAYOUT_PRESETS** for exact layout definitions
- Use **IMPLEMENTATION_PLAN** as the build checklist

---

## Git workflow
**IMPORTANT**: After implementing each feature and verifying it works:
1. Test the feature (run the app, verify functionality)
2. Run `flutter analyze` to ensure no issues
3. Run `flutter test` to ensure tests pass
4. Commit the changes with a descriptive message
5. Follow conventional commit format: `feat:`, `fix:`, `refactor:`, `docs:`, etc.

Example:
```bash
git add .
git commit -m "feat: implement player panel with +/- buttons"
```

This ensures the git history tracks progress and makes it easy to reference implementation in future sessions.
