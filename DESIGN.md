# Daily Sales Management — UI Design System & Guidelines

This document is the single source of truth for the visual language of the Daily Sales
Management app (Flutter mobile). All screens, components, and new features must follow
these rules. When in doubt, prefer consistency over novelty.

> **Status:** v2.0 — clean & modern light theme.
> **Theme brightness:** Light (dark text on a light background).
> **Primary color:** `#6366F1` · **Secondary color:** `#22D3EE` · **Background:** `#F9FAFB`

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
5. **Accessible by default.** Minimum 4.5:1 contrast for text, 48×48 dp touch targets,
   never color-only meaning.
6. **Clean & modern.** Generous whitespace, soft shadows, rounded corners, and a
   restrained palette. Avoid clutter and heavy borders.

---

## 2. Color Palette

### 2.1 Core Colors

| Token | Hex | Flutter | Usage |
|---|---|---|---|
| `colorPrimary` | `#6366F1` | `Color(0xFF6366F1)` | AppBars, primary buttons, active nav/tab states, links, focus rings |
| `colorSecondary` | `#22D3EE` | `Color(0xFF22D3EE)` | FABs, secondary accents, active toggles, selected chips |
| `colorBackground` | `#F9FAFB` | `Color(0xFFF9FAFB)` | Scaffold background, page background |
| `colorSurface` | `#FFFFFF` | `Color(0xFFFFFFFF)` | Cards, dialogs, bottom sheets, elevated containers, inputs |
| `colorOnPrimary` | `#FFFFFF` | `Color(0xFFFFFFFF)` | Text/icons on primary surfaces |
| `colorOnSecondary` | `#111827` | `Color(0xFF111827)` | Text/icons on secondary surfaces |
| `colorOnSurface` | `#111827` | `Color(0xFF111827)` | Primary text on surface/background |
| `colorOnSurfaceVariant` | `#6B7280` | `Color(0xFF6B7280)` | Subtitles, hints, secondary text, captions |
| `colorDisabled` | `#9CA3AF` | `Color(0xFF9CA3AF)` | Disabled text/icons |

### 2.2 Semantic Colors

| Token | Hex | Flutter | Usage |
|---|---|---|---|
| `colorSuccess` | `#10B981` | `Color(0xFF10B981)` | Profit, positive deltas, success snackbars |
| `colorWarning` | `#F59E0B` | `Color(0xFFF59E0B)` | Low stock, pending states |
| `colorError` | `#EF4444` | `Color(0xFFEF4444)` | Errors, validation failures, delete actions |
| `colorInfo` | `#6366F1` | `Color(0xFF6366F1)` | Informational (alias of primary) |

Semantic colors are used **only** for status meaning, never as brand/decoration. Always
pair color with an icon or text label (never color-only).

### 2.3 Borders, Dividers & Overlays

| Token | Value | Usage |
|---|---|---|
| `colorDivider` | `#000000` @ 12% opacity | `Divider`, list separators |
| `colorBorder` | `#000000` @ 20% opacity | Input borders, card outlines |
| `colorOverlay` | `#000000` @ 54% opacity | Modal scrim behind dialogs/bottom sheets |
| `colorRipple` | `#000000` @ 6% opacity | Splash/ripple on light surfaces |

### 2.4 Color Usage Rules

- AppBars and primary buttons use `colorPrimary` with `colorOnPrimary` content.
- FABs use `colorSecondary` background with `colorOnSecondary` icon.
- Scaffold background is always `colorBackground`.
- Cards/dialogs/bottom sheets/inputs use `colorSurface`.
- Never place `colorPrimary` text on `colorSurface` for body copy (use `colorOnSurface`).
- Status colors (success/error/warning) appear only on icons, badges, or short labels —
  never as large background fills except for snackbars.

---

## 3. Typography

### 3.1 Font Family

- **Primary:** `Roboto` via the `google_fonts` package (`google_fonts: ^6.2.1`).
  Applied through `GoogleFonts.roboto(...)` in `AppTheme`.
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

- Primary text: `colorOnSurface` (`#111827`).
- Secondary/hint/subtitle text: `colorOnSurfaceVariant` (`#6B7280`).
- Disabled text: `colorDisabled` (`#9CA3AF`).
- Never use pure white text on light surfaces.

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

- **Standard horizontal padding for all main body containers: `16.0`.** Applies to
  `ListView`, `Column`, `Form`, and `SingleChildScrollView` bodies. Auth screens may
  use `24.0` for breathing room.
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

### 4.4 Elevation & Shadows

Material 3 elevation is used sparingly on the light theme:

| Level | Elevation | Usage |
|---|---|---|
| 0 | 0 | Flat surfaces, scaffold background |
| 1 | 1 | Cards at rest |
| 2 | 2 | AppBars (scrolled), FABs |
| 3 | 3 | Dialogs, bottom sheets |
| 4 | 6 | Dropdown menus, popovers |

Prefer soft shadows over heavy elevation for a clean, modern feel.

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

- Every pushed route/screen displays a back arrow (`←`) on the top-left of the `AppBar`.
  This is automatic when a route is pushed onto the stack. Use `context.push(...)` for
  forward navigation; do not build custom back buttons from scratch.
- Root destinations (Dashboard, Products, Sales, Expenses, Reports) have **no** back button.
- Auth screens (Login) have no back button; Register has a back button (or "Back to
  login" text button).

### 6.2 Title Alignment

- Title alignment must be **consistent across all screens**: `centerTitle: false`
  (left-aligned). Set explicitly in `AppBarTheme`.

### 6.3 App Bar Structure

- AppBars are `colorPrimary` background with `colorOnPrimary` content, elevation 0 at
  rest and 2 when scrolled (`scrolledUnderElevation`).
- Leading: back button or menu. Trailing: at most 2 icon actions.

### 6.4 Navigation Pattern

- Navigation is via AppBar actions and in-page buttons/links (Dashboard quick actions).
- If bottom nav is added later, max 5 items, icons + labels, active item `colorPrimary`.

---

## 7. Component Specifications

### 7.1 Buttons

| Variant | Style | Usage |
|---|---|---|
| `ElevatedButton` | Filled, `colorPrimary` bg, `colorOnPrimary` text, radius 8 | Primary CTA (Save, Record Sale, Login) |
| `OutlinedButton` | Transparent bg, `colorPrimary` border/text, radius 8 | Secondary actions |
| `TextButton` | No bg/border, `colorPrimary` text | Tertiary/inline actions |
| `IconButton` | 48×48 touch target, icon 24 | Icon-only actions |
| `FloatingActionButton` | `colorSecondary` bg, `colorOnSecondary` icon, radius 12 | Screen-level create action |

- Button height: 48 dp minimum. Label uses `labelLarge`.
- Disabled state: 38% opacity; never remove the button.
- Loading state: replace label with a 20 dp `CircularProgressIndicator` and disable.

### 7.2 Cards

- Background `colorSurface`, radius 12, elevation 1, padding 16.
- KPI cards: title (`bodySmall`, on-surface-variant) above value (bold 18–24).
- Never nest cards more than one level deep.

### 7.3 Inputs

- Outlined style with `colorBorder` border, radius 8, height 56 dp.
- Focus border: `colorPrimary` 2 dp.
- Error text: `colorError`, `bodySmall`.

### 7.4 Lists & ListTiles

- Divider between items: `colorDivider`.
- Title `bodyLarge`/`titleMedium`; subtitle `bodyMedium` on-surface-variant; trailing
  amount bold.

### 7.5 Dialogs & Bottom Sheets

- Dialog: `colorSurface` bg, radius 12, elevation 3.
- Scrim: `colorOverlay`.

### 7.6 Feedback Components

- **Loading (full screen):** centered `CircularProgressIndicator(color: colorPrimary)`.
- **Empty state:** centered icon (48 dp, on-surface-variant) + title + subtitle + optional CTA.
- **Error state:** centered icon `Icons.error_outline` (colorError) + message + "Retry".
- **Snackbar:** `colorSurface` bg, `colorOnSurface` text, radius 8, bottom-aligned, 4 s.
- **Pull-to-refresh:** `RefreshIndicator` on scrollable lists.

### 7.7 Chips & Badges

- Filter chips: `colorSecondary` selected bg with `colorOnSecondary` text.
- Status badges: small pill, radius 4, semantic color bg @ 20% opacity with semantic
  color text.

---

## 8. States & Interaction

- **Hover/press:** ripple `colorRipple` on surfaces.
- **Focus:** 2 dp `colorPrimary` outline on inputs and buttons.
- **Disabled:** 38% opacity + `colorDisabled` text.
- **Selected:** `colorPrimary` indicator.

---

## 9. Motion & Animation

- Default duration: 200 ms for micro-interactions, 300 ms for screen transitions.
- Curves: `Curves.easeOutCubic` for entrances, `Curves.easeInCubic` for exits.
- Respect `MediaQuery.disableAnimations`.

---

## 10. Accessibility

- Minimum contrast: 4.5:1 for normal text, 3:1 for large text.
- Touch targets: minimum 48×48 dp.
- Never convey information by color alone.
- All interactive elements have semantic labels.
- Support text scaling up to 2.0× without overflow.

---

## 11. Theming Implementation (Flutter)

```dart
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color colorPrimary = Color(0xFF6366F1);
  static const Color colorSecondary = Color(0xFF22D3EE);
  static const Color colorBackground = Color(0xFFF9FAFB);
  static const Color colorSurface = Color(0xFFFFFFFF);
  static const Color colorOnPrimary = Color(0xFFFFFFFF);
  static const Color colorOnSecondary = Color(0xFF111827);
  static const Color colorOnSurface = Color(0xFF111827);
  static const Color colorOnSurfaceVariant = Color(0xFF6B7280);
  static const Color colorDisabled = Color(0xFF9CA3AF);
  static const Color colorSuccess = Color(0xFF10B981);
  static const Color colorWarning = Color(0xFFF59E0B);
  static const Color colorError = Color(0xFFEF4444);
  static const Color colorDivider = Color(0x1F000000);
  static const Color colorBorder = Color(0x33000000);

  static ThemeData light() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: colorPrimary,
          onPrimary: colorOnPrimary,
          secondary: colorSecondary,
          onSecondary: colorOnSecondary,
          surface: colorSurface,
          onSurface: colorOnSurface,
          error: colorError,
          onError: colorOnPrimary,
        ),
        scaffoldBackgroundColor: colorBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: colorPrimary,
          foregroundColor: colorOnPrimary,
          elevation: 0,
          scrolledUnderElevation: 2,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: colorOnPrimary,
          ),
        ),
        cardTheme: CardThemeData(
          color: colorSurface,
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: colorBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: colorPrimary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: colorError),
          ),
          labelStyle: const TextStyle(color: colorOnSurfaceVariant),
          hintStyle: const TextStyle(color: colorOnSurfaceVariant),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorPrimary,
            foregroundColor: colorOnPrimary,
            minimumSize: const Size(0, 48),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: colorSecondary,
          foregroundColor: colorOnSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        dividerTheme: const DividerThemeData(color: colorDivider, thickness: 1),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: colorSurface,
          contentTextStyle: const TextStyle(color: colorOnSurface),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: colorPrimary),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w400, height: 1.29, color: colorOnSurface),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w400, height: 1.27, color: colorOnSurface),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, height: 1.50, color: colorOnSurface),
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.50, color: colorOnSurface),
          bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.43, color: colorOnSurface),
          bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.33, color: colorOnSurfaceVariant),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.43, color: colorOnSurface),
        ),
      );
}
```

In `main.dart`/`app.dart`, use `theme: AppTheme.light()`.

---

## 12. Do & Don't

**Do**
- Use design tokens, not raw hex, in widget code.
- Keep body padding at 16 horizontal.
- Show a back arrow on every pushed screen via `context.push`.
- Pair status colors with icons/text.
- Use `Formatters.money` for all currency.

**Don't**
- Don't introduce new colors without updating §2.
- Don't hardcode `fontSize` for body copy.
- Don't nest cards.
- Don't use color alone to convey status.
- Don't build custom back buttons from scratch.

---

## 13. Changelog

- **v2.0** — Rewrote design system with a clean & modern light theme. New palette:
  primary `#6366F1`, secondary `#22D3EE`, background `#F9FAFB`. Updated tokens,
  typography, components, and Flutter implementation.
- **v1.0** — Initial dark theme design system.