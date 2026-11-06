# Daily Sales Management — UI Design System & Guidelines

This document is the single source of truth for the visual language of the Daily Sales
Management app (Flutter mobile + companion web). All screens, components, and new features
must follow these rules. When in doubt, prefer consistency over novelty.

> **Status:** v1.0 — derived from the approved palette in the initial design pass.
> **Theme brightness:** Dark (white text on a dark slate background).
> **Design tokens** are listed with both hex values and Flutter `Color` literals.

---

## 1. Design Principles

1. **Clarity first.** Sales data must be scannable at a glance — large numbers, clear
   labels, consistent alignment.
2. **One primary action per screen.** The main CTA is always the most visually prominent
   element (filled button, FAB, or primary-colored AppBar action).
3. **Consistency over creativity.** Reuse the components in §7 instead of inventing new
   ones. Same data, same representation, everywhere.
4. **Feedback is mandatory.** Every user action produces a visible response: loading
   spinner, snackbar, disabled state, or navigation.
5. **Accessible by default.** Minimum 4.5:1 contrast for text, 44×44 dp touch targets,
   never color-only meaning.

---

## 2. Color Palette

### 2.1 Core Colors

| Token | Hex | Flutter | Usage |
|---|---|---|---|
| `colorPrimary` | `#37B6E9` | `Color(0xFF37B6E9)` | AppBars, primary buttons, active nav/tab states, links, focus rings |
| `colorSecondary` | `#242C3B` | `Color(0xFF242C3B)` | FABs, secondary accents, active toggles, selected chips background |
| `colorBackground` | `#353F54` | `Color(0xFF353F54)` | Scaffold background, page background |
| `colorSurface` | `#4B4CED` | `Color(0xFF4B4CED)` | Cards, dialogs, bottom sheets, elevated containers |
| `colorOnPrimary` | `#FFFFFF` | `Color(0xFFFFFFFF)` | Text/icons on primary surfaces |
| `colorOnSurface` | `#FFFFFF` | `Color(0xFFFFFFFF)` | Primary text on surface/background |
| `colorOnSurfaceVariant` | `#B0BEC5` | `Color(0xFFB0BEC5)` | Subtitles, hints, secondary text, captions (see note) |
| `colorDisabled` | `#607D8B` | `Color(0xFF607D8B)` | Disabled text/icons (50% opacity of on-surface variant) |

> **Note on subtitles:** The earlier value `#757575` failed contrast against
> `#353F54` (≈2.6:1). It is replaced by `#B0BEC5` (≈6.4:1). Do not use `#757575`
> anywhere in the app.

### 2.2 Semantic Colors

| Token | Hex | Flutter | Usage |
|---|---|---|---|
| `colorSuccess` | `#4CAF50` | `Color(0xFF4CAF50)` | Profit, positive deltas, success snackbars |
| `colorWarning` | `#FFB300` | `Color(0xFFFFB300)` | Low stock, pending states |
| `colorError` | `#EF5350` | `Color(0xFFEF5350)` | Errors, validation failures, delete actions |
| `colorInfo` | `#37B6E9` | `Color(0xFF37B6E9)` | Informational (alias of primary) |

Semantic colors are used **only** for status meaning, never as brand/decoration. Always
pair color with an icon or text label (never color-only).

### 2.3 Borders, Dividers & Overlays

| Token | Value | Usage |
|---|---|---|
| `colorDivider` | `#FFFFFF` @ 12% opacity | `Divider`, list separators |
| `colorBorder` | `#FFFFFF` @ 20% opacity | Input borders, card outlines |
| `colorOverlay` | `#000000` @ 54% opacity | Modal scrim behind dialogs/bottom sheets |
| `colorRipple` | `#FFFFFF` @ 10% opacity | Splash/ripple on dark surfaces |

### 2.4 Color Usage Rules

- AppBars and primary buttons use `colorPrimary` with `colorOnPrimary` content.
- FABs use `colorSecondary` background with `colorOnPrimary` icon.
- Scaffold background is always `colorBackground`.
- Cards/dialogs/bottom sheets use `colorSurface`.
- Never place `colorPrimary` text on `colorSurface` for body copy (use `colorOnSurface`).
- Status colors (success/error/warning) appear only on icons, badges, or short labels —
  never as large background fills except for snackbars.

---

## 3. Typography

### 3.1 Font Family

- **Primary:** `Roboto` (Flutter default). No custom font is loaded in v1.
- If a custom font is introduced later, it must be added to `pubspec.yaml` assets and
  registered in `AppTheme`, and this doc updated.

### 3.2 Type Scale

All styles derive from `Theme.of(context).textTheme`. Use these semantic roles; do not
hardcode `TextStyle(fontSize: ...)` in widgets except for the numeric data exceptions
noted below.

| Role | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| `displayLarge` | 57 | 400 | 1.12 | Hero numbers on dashboard (optional) |
| `headlineMedium` | 28 | 400 | 1.29 | Screen titles (login "Daily Sales") |
| `titleLarge` | 22 | 400 | 1.27 | AppBar titles |
| `titleMedium` | 16 | 500 | 1.50 | Section headers, card titles |
| `bodyLarge` | 16 | 400 | 1.50 | Primary body text, form field text |
| `bodyMedium` | 14 | 400 | 1.43 | Secondary body, list subtitles |
| `bodySmall` | 12 | 400 | 1.33 | Captions, helper text |
| `labelLarge` | 14 | 500 | 1.43 | Button labels |
| `labelMedium` | 12 | 500 | 1.33 | Chip/badge labels |

### 3.3 Numeric Data Typography

Revenue, profit, prices, quantities, and stock counts are **always** rendered with:

- `fontWeight: FontWeight.w700` (bold)
- tabular figures where the font supports it (`FontFeature.tabularFigures()`)
- currency via `Formatters.money(...)` (never inline string interpolation of raw numbers)

Size guidance: KPI values 18–24 dp bold; list trailing amounts 14–16 dp bold.

### 3.4 Text Color Rules

- Primary text: `colorOnSurface` (`#FFFFFF`).
- Secondary/hint/subtitle text: `colorOnSurfaceVariant` (`#B0BEC5`).
- Disabled text: `colorDisabled` (`#607D8B`).
- Never use pure black (`#000000`) text on these dark surfaces.

---

## 4. Spacing, Grid & Layout

### 4.1 Base Unit

All spacing is a multiple of **4 dp**. Prefer these canonical values:

| Token | Value | Usage |
|---|---|---|
| `spaceXs` | 4 | Tight gaps inside chips/badges |
| `spaceSm` | 8 | Between related elements, icon-to-label |
| `spaceMd` | 12 | Between form fields, list items vertical |
| `spaceLg` | 16 | Standard horizontal body padding, card padding |
| `spaceXl` | 24 | Section spacing, login form padding |
| `space2xl` | 32 | Top/bottom screen margins |
| `space3xl` | 48 | Empty-state vertical centering |

### 4.2 Layout Rules

- **Standard horizontal padding for all main body containers: `16.0`.** (Matches §4.1
  `spaceLg`.) Applies to `ListView`, `Column`, `Form`, and `SingleChildScrollView`
  bodies. Auth screens may use `24.0` for breathing room.
- Content max width is not capped on phone; on tablet/web a future max-width (e.g. 600 dp)
  may be applied — out of scope for v1.
- Use `Expanded`/`Flexible` for equal-width KPI cards in rows; never fixed widths.
- Lists use `ListView.builder` for > 20 items.

### 4.3 Border Radius

| Token | Value | Usage |
|---|---|---|
| `radiusSm` | 4 | Chips, badges, small tags |
| `radiusMd` | 8 | Inputs, buttons, snackbars, small cards |
| `radiusLg` | 12 | Cards, dialogs, bottom sheets, FABs |

- Standard card and button corner radius: **8.0 or 12.0** (modern look). Prefer 12 for
  cards/dialogs, 8 for inputs/buttons.
- Circular elements (avatars, icon buttons) use `BorderRadius.circular(999)`.

### 4.4 Elevation & Shadows

Material 3 elevation is used sparingly on the dark theme:

| Level | Elevation | Usage |
|---|---|---|
| 0 | 0 | Flat surfaces, scaffold background |
| 1 | 1 | Cards at rest |
| 2 | 2 | AppBars (scrolled), FABs |
| 3 | 3 | Dialogs, bottom sheets |
| 4 | 6 | Dropdown menus, popovers |

Do not stack high elevations; prefer tonal surface colors for hierarchy on dark themes.

---

## 5. Iconography

- Use **Material Icons** (`Icons.*`) only. No custom icon sets in v1.
- Default icon size: 24 dp. In dense lists use 20 dp; in FABs 24 dp.
- Icon color follows the containing text color unless it conveys status (then semantic
  color + tooltip).
- Every icon-only button must have a `tooltip`.

---

## 6. Navigation & App Bar Rules

### 6.1 Back Button Policy

- **Every pushed route/screen must display a back arrow (`←`) on the top-left of the
  `AppBar`.** This is automatic when a route is pushed onto the stack. When using
  `context.go` (replacement) on a sub-screen, either push instead, or explicitly add
  `leading: BackButton()` / `IconButton(icon: BackButtonIcon(), onPressed: () => context.pop())`.
- Root tabs/destinations (Dashboard, Products, Sales, Expenses, Reports) have **no**
  back button.
- Auth screens (Login) have no back button; Register has a back button (or "Back to
  login" text button).

### 6.2 Title Alignment

- Title alignment must be **consistent across all screens**: `centerTitle: false`
  (left-aligned) on Android, respecting Flutter platform adaptations. Set explicitly in
  `AppBarTheme` so behavior is identical on iOS and Android.
- AppBar title uses `titleLarge` (22, 400).

### 6.3 App Bar Structure

- Height: default 56 dp (small) / 64 dp (medium). Use default.
- Leading: back button or menu. Trailing: at most 2 icon actions; overflow into a
  "more" menu beyond that.
- AppBars are `colorPrimary` background with `colorOnPrimary` content, elevation 0 at
  rest and 2 when scrolled (`scrolledUnderElevation`).

### 6.4 Navigation Pattern

- Bottom navigation is **not** used in v1; navigation is via AppBar actions and in-page
  buttons/links (Dashboard quick actions). If bottom nav is added later, max 5 items,
  icons + labels, active item `colorPrimary`.

---

## 7. Component Specifications

### 7.1 Buttons

| Variant | Style | Usage |
|---|---|---|
| `ElevatedButton` | Filled, `colorPrimary` bg, `colorOnPrimary` text, radius 8 | Primary CTA (Save, Record Sale, Login) |
| `OutlinedButton` | Transparent bg, `colorPrimary` border/text, radius 8 | Secondary actions (Products, Expenses, Reports) |
| `TextButton` | No bg/border, `colorPrimary` text | Tertiary/inline actions (Create account, Cancel) |
| `IconButton` | 48×48 touch target, icon 24 | Icon-only actions (settings, add, delete) |
| `FloatingActionButton` | `colorSecondary` bg, `colorOnPrimary` icon, radius 12 | Screen-level create action (Products, Sales, Expenses) |

- Button height: 48 dp minimum. Label uses `labelLarge`.
- Disabled state: 38% opacity of the enabled style; never remove the button.
- Loading state: replace label with a 20 dp `CircularProgressIndicator` (same color as
  label) and disable the button.

### 7.2 Cards

- Background `colorSurface`, radius 12, elevation 1, padding 16.
- KPI cards: title (`bodySmall`, on-surface-variant) above value (bold 18–24).
- List cards (sale create product rows): radius 8, padding 12, elevation 1.
- Never nest cards more than one level deep.

### 7.3 Inputs (TextFormField / TextField)

- Filled style with `colorSurface` @ 40% opacity background, or outlined with
  `colorBorder` border — choose one and use consistently (v1 uses **outlined**).
- Radius 8, height 56 dp, content padding 16 horizontal / 12 vertical.
- Label: `bodyMedium` on-surface-variant; floating label shrinks to `bodySmall`.
- Error text: `colorError`, `bodySmall`, below field.
- Focus border: `colorPrimary` 2 dp.
- Always provide `keyboardType` and `validator` for typed fields.

### 7.4 Lists & ListTiles

- Divider between items: `colorDivider` (or none with card-per-item).
- Leading icon/avatar 40×40; title `bodyLarge`/`titleMedium`; subtitle `bodyMedium`
  on-surface-variant; trailing amount bold.
- Swipe-to-delete is not used in v1; use long-press or an explicit delete icon.

### 7.5 Dialogs & Bottom Sheets

- Dialog: `colorSurface` bg, radius 12, elevation 3, title `titleMedium`, content
  `bodyMedium`, actions right-aligned.
- Bottom sheet: `colorSurface` bg, top radius 12, drag handle 4×32 `colorDivider`,
  padding 16.
- Scrim: `colorOverlay`.

### 7.6 Feedback Components

- **Loading (full screen):** centered `CircularProgressIndicator(color: colorPrimary)`.
- **Loading (inline):** 20 dp spinner in place of content.
- **Empty state:** centered icon (48 dp, on-surface-variant) + title `titleMedium` +
  subtitle `bodyMedium` + optional CTA button.
- **Error state:** centered icon `Icons.error_outline` (colorError) + message +
  "Retry" `OutlinedButton`.
- **Snackbar:** `colorSurface` bg, `colorOnSurface` text, radius 8, bottom-aligned,
  4 s duration, max one visible at a time. Success/error snackbars tint the leading icon
  with the semantic color.
- **Pull-to-refresh:** `RefreshIndicator` on scrollable lists where data can change.

### 7.7 Chips & Badges

- Filter chips: `colorSecondary` selected bg with `colorOnPrimary` text; unselected
  transparent with `colorBorder`.
- Status badges (e.g. "Low stock"): small pill, radius 4, semantic color bg @ 20%
  opacity with semantic color text.

### 7.8 Progress & Charts

- Reports series rendered as simple `ListTile` rows in v1 (no chart library). If charts
  are added later, use `colorPrimary`/`colorSuccess`/`colorError` series colors and
  update this doc.

---

## 8. States & Interaction

- **Hover/press:** ripple `colorRipple` on dark surfaces; scale 0.98 on cards (optional).
- **Focus:** 2 dp `colorPrimary` outline on inputs and buttons (keyboard navigation).
- **Disabled:** 38% opacity + `colorDisabled` text; keep layout stable.
- **Selected:** `colorPrimary` indicator (underline for tabs, fill for chips).

---

## 9. Motion & Animation

- Default duration: 200 ms for micro-interactions, 300 ms for screen transitions.
- Curves: `Curves.easeOutCubic` for entrances, `Curves.easeInCubic` for exits.
- Respect `MediaQuery.disableAnimations` — skip non-essential motion when set.
- Avoid bouncy/elastic curves; keep motion functional.

---

## 10. Accessibility

- Minimum contrast: 4.5:1 for normal text, 3:1 for large text (≥18 dp bold or 24 dp).
- Touch targets: minimum 48×48 dp (44×44 dp absolute minimum).
- Never convey information by color alone — pair with icon/text.
- All interactive elements have semantic labels (`Semantics`/`tooltip`).
- Support text scaling up to 2.0× without layout overflow (use `Flexible`/`Expanded`,
  avoid fixed heights for text containers).
- Form errors are announced via `Semantics` (Flutter does this for `TextFormField`).

---

## 11. Theming Implementation (Flutter)

`AppTheme.light()` is currently a placeholder. Replace with a dark theme built from these
tokens. Target mapping:

```dart
static ThemeData dark() => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF37B6E9),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF242C3B),
    onSecondary: Color(0xFFFFFFFF),
    surface: Color(0xFF4B4CED),
    onSurface: Color(0xFFFFFFFF),
    error: Color(0xFFEF5350),
    onError: Color(0xFFFFFFFF),
  ),
  scaffoldBackgroundColor: const Color(0xFF353F54),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF37B6E9),
    foregroundColor: Color(0xFFFFFFFF),
    elevation: 0,
    scrolledUnderElevation: 2,
    centerTitle: false,
    titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, color: Color(0xFFFFFFFF)),
  ),
  cardTheme: CardThemeData(
    color: const Color(0xFF4B4CED),
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Color(0xFF37B6E9), width: 2),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF37B6E9),
      foregroundColor: const Color(0xFFFFFFFF),
      minimumSize: const Size(0, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF242C3B),
    foregroundColor: Color(0xFFFFFFFF),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
  ),
);
```

> Note: `MyApp` must switch from `AppTheme.light()` to `AppTheme.dark()` (or rename
> to `AppTheme.theme()`) when applying this design. This doc is the spec; the code
> change is a separate task.

---

## 12. Do & Don't

**Do**
- Use design tokens, not raw hex, in widget code (define constants in `AppTheme`).
- Keep body padding at 16 horizontal.
- Show a back arrow on every pushed screen.
- Pair status colors with icons/text.
- Use `Formatters.money` for all currency.

**Don't**
- Don't introduce new colors without updating §2.
- Don't use `#757575` for subtitles (contrast failure).
- Don't hardcode `fontSize` for body copy.
- Don't nest cards.
- Don't use color alone to convey status.
- Don't add a new icon set or font without updating §5/§3.

---

## 13. Changelog

- **v1.0** — Initial design system. Fixed subtitle color from `#757575` to `#B0BEC5`
  for WCAG AA contrast. Documented full token set, typography, spacing, radius,
  components, navigation, accessibility, and Flutter implementation mapping.
