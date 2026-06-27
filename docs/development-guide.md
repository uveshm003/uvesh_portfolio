# uvesh_portfolio - Development Guide

**Date:** 2026-06-23

## Prerequisites

- **Flutter SDK** (stable channel) including **Dart ^3.11.0**.
- **Web enabled:** `flutter config --enable-web`.
- A **Chromium** browser for local runs.
- No environment variables, secrets, or services are required (client-only app).

## Setup

```bash
flutter pub get
```

## Run locally

```bash
flutter run -d chrome
```

Notes:
- Routing is **hash-based**; deep links look like `http://localhost:PORT/#/projects`.
- Default theme is light; toggle dark via the sidebar/mobile-bar control.

## Build

```bash
flutter build web --release        # outputs to build/web
```

## Test

```bash
flutter test                       # runs test/widget_test.dart
```

## Lint

```bash
flutter analyze                    # standing gate — keep at zero issues
```

Lint config: `analysis_options.yaml` includes `package:flutter_lints/flutter.yaml`.

## Common Development Tasks

### Edit any text / content
All copy lives in `lib/data/portfolio_data.dart`. Edit there — never hard-code
strings in widgets.

### Add a project / job / book / paper / blog post
Append a new model instance to the relevant `static const` list in
`PortfolioData` (`projects`, `experiences`, `books`/`currentlyReading`,
`researchPapers`, `blogs`). The corresponding section renders it automatically;
empty lists show a tidy empty state.

### Add a new nav section
1. Add a `NavItem(label, path)` to `PortfolioData.navItems`.
2. Add a `GoRoute` in `lib/router/app_router.dart`.
3. Create a page widget in `lib/pages/` composing `PageScaffold` + a section.

### Change the look (theme)
- Colors: `lib/theme/app_colors.dart`
- Type: `lib/theme/app_typography.dart`
- Spacing / widths / breakpoints: `lib/theme/app_spacing.dart`
Widgets read these tokens via `AppPalette.of(context)` and the `TextTheme`, so
changes propagate site-wide.

### Replace the profile photo
Swap `assets/images/profile.jpg` (declared in `pubspec.yaml`). Note the
`ProfileAvatar` widget exists but is not currently placed in the layout.

## Conventions

- **Data is the single source of truth** (`portfolio_data.dart`).
- **Tokens over magic numbers** for all spacing/color/type.
- **Pages are thin; sections hold content.**
- **One `FadeIn` per page** (in `PageScaffold`) — do not nest entrance fades in
  sections.
- **Copy style:** avoid AI-slop punctuation — no ` - ` dash stand-ins and no
  gratuitous em dashes; prefer colons/periods/parentheses.
- Keep `flutter analyze` clean before committing.

## Visual Verification (optional, headless)

A debug `flutter run -d web-server` does **not** render under headless Chrome
(DDC modules stall). To screenshot headlessly: `flutter build web --release`,
serve `build/web` statically, and drive headless Chrome with SwiftShader via
CDP. Trigger a repaint (navigate/click/scroll) before capturing, or
entrance-animated content can appear blank/faded in a one-shot screenshot. This
is a capture artifact only.

## Gotchas

- The Reading section's route is `/books` (label "Reading").
- `lib/widgets/top_nav.dart` is dead code; safe to delete.
- Fonts load at runtime via `google_fonts`; the first paint fetches them.

---

_Generated using BMAD Method `document-project` workflow_
