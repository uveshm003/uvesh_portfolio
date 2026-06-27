# uvesh_portfolio - Project Overview

**Date:** 2026-06-23
**Type:** Flutter Web frontend (single-page app)
**Architecture:** Component-based, token-driven design system over a fixed-sidebar shell

## Executive Summary

`uvesh_portfolio` is the personal portfolio website of Muhammad Uvesh
Menpurwala, a cross-platform software engineer. It is a single-page Flutter Web
application with seven routed sections (Home, Experience, Projects, Skills, Blog,
Reading, Research) plus a 404. There is no backend: all content is compile-time
constant Dart held in a single source-of-truth file. The app ships light and
dark themes and a distinctive "Instrument" visual identity (precision-
engineering aesthetic: cool architectural neutrals, a single cobalt signal
accent, Space Grotesk / Inter / IBM Plex Mono type roles).

## Project Classification

- **Repository Type:** monolith
- **Project Type(s):** web (Flutter Web frontend)
- **Primary Language(s):** Dart (SDK ^3.11.0)
- **Architecture Pattern:** Component-based UI + token-driven theming + data-as-single-source-of-truth, navigated by a `go_router` `ShellRoute` with a persistent sidebar shell

## Technology Stack Summary

| Category | Technology | Version | Justification |
| --- | --- | --- | --- |
| Framework | Flutter (Web target) | SDK ^3.11.0 | Single codebase; author's specialty |
| Language | Dart | ^3.11.0 | Flutter language |
| Routing | go_router | ^17.3.0 | Declarative routes; ShellRoute for persistent chrome |
| Fonts | google_fonts | ^8.1.0 | Space Grotesk, Inter, IBM Plex Mono at runtime |
| External links | url_launcher | ^6.3.2 | Open mailto/tel/https |
| Icons | cupertino_icons | ^1.0.8 | Icon set |
| Lints | flutter_lints | ^6.0.0 | Recommended lint rules (CI gate) |
| Rendering | CanvasKit (default web renderer) | - | High-fidelity text/graphics |
| Hosting | Netlify | - | Builds Flutter, serves `build/web`, SPA fallback |

State management: a single `ValueNotifier<ThemeMode>` (`ThemeController`) drives
the theme toggle at the app root. All other content is stateless / const.

## Key Features

- Seven content sections, each its own route, under a shared shell.
- Persistent left **sidebar** (desktop) with name, a numbered section index, a
  "NOW" status, links and the theme toggle; collapses to a top bar with a popup
  menu on narrow screens.
- **Light + dark** themes via a `ThemeExtension` (`AppPalette`); default light.
- "Instrument" **design system**: cool paper / graphite grounds, cobalt accent,
  three type roles, monospace data voice, hairline rules, sharp corners.
- A bold, numbered **work index** (Projects) and a statement-led **hero** (Home)
  including a six-platform "SHIPS TO" matrix.
- Filterable lists (Blog, Reading, Research) with tidy empty states.
- All copy centralized in `lib/data/portfolio_data.dart`.

## Architecture Highlights

- **Token-driven theming.** `theme/` holds color, type and spacing tokens;
  widgets read semantic colors via `AppPalette.of(context)`. Changing the look
  is done in tokens, not scattered widgets.
- **Shell + content pane.** `AppShell` renders a fixed `Sidebar` beside an
  `Expanded` content pane on desktop, or a `MobileBar` above the content on
  narrow screens. The routed page (`PageScaffold`) owns its own scroll.
- **Data as single source of truth.** `portfolio_data.dart` defines plain const
  models and all content; sections render from these lists and degrade to empty
  states when a list is empty.
- **One entrance animation per page.** `PageScaffold` wraps content in a single
  `FadeIn`; sections do not nest their own (nested fades caused paint issues).

## Development Overview

### Prerequisites

- Flutter SDK (stable channel) with Dart ^3.11.0
- Web enabled: `flutter config --enable-web`
- A Chromium browser for local runs

### Getting Started

Install dependencies, then run against Chrome. See
[development-guide.md](./development-guide.md) for the full workflow.

### Key Commands

- **Install:** `flutter pub get`
- **Dev:** `flutter run -d chrome`
- **Build:** `flutter build web --release`
- **Test:** `flutter test`
- **Lint:** `flutter analyze`

## Repository Structure

Monolith. Application code in `lib/` (organized into `data/`, `theme/`,
`widgets/`, `sections/`, `pages/`, `router/`, `utils/`). Static assets in
`assets/`, web shell in `web/`, source resumes in `resumes/`, a single widget
test in `test/`. See [source-tree-analysis.md](./source-tree-analysis.md).

## Documentation Map

For detailed information, see:

- [index.md](./index.md) - Master documentation index
- [architecture.md](./architecture.md) - Detailed architecture
- [source-tree-analysis.md](./source-tree-analysis.md) - Directory structure
- [component-inventory.md](./component-inventory.md) - Widgets, sections, design system
- [development-guide.md](./development-guide.md) - Development workflow
- [deployment-guide.md](./deployment-guide.md) - Netlify deployment

---

_Generated using BMAD Method `document-project` workflow_
