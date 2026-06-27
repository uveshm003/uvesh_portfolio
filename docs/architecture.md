# uvesh_portfolio - Architecture

**Date:** 2026-06-23
**Project Type:** Flutter Web frontend (single-page app)
**Repository Type:** monolith

## Executive Summary

A client-only Flutter Web app. No server, database, or authentication. The
architecture is three concerns kept deliberately separate: **content** (const
data), **design tokens** (theme), and **presentation** (widgets/sections/pages),
wired together by a `go_router` `ShellRoute` that keeps a persistent sidebar
shell around an independently-scrolling content pane.

## Technology Stack

| Category | Technology | Version |
| --- | --- | --- |
| Framework | Flutter (Web) | SDK ^3.11.0 |
| Language | Dart | ^3.11.0 |
| Routing | go_router | ^17.3.0 |
| Fonts | google_fonts | ^8.1.0 |
| Links | url_launcher | ^6.3.2 |
| Lints | flutter_lints | ^6.0.0 |
| Renderer | CanvasKit (web default) | - |

## Architecture Pattern

**Component-based UI + token-driven theming + data-as-single-source-of-truth.**

- Presentation is composed from small reusable widgets and content sections.
- All visual decisions derive from tokens in `theme/`.
- All copy lives in `data/portfolio_data.dart`.
- Navigation is declarative; a shell provides persistent chrome.

## Application Structure & Flow

```
main() → PortfolioApp
  └─ ValueListenableBuilder<ThemeMode> (listens to ThemeController)
       └─ MaterialApp.router(theme: AppTheme.light(), darkTheme: AppTheme.dark(),
                             routerConfig: buildRouter(controller))
            └─ ShellRoute → AppShell(child: <routed page>)
                 ├─ desktop:  Row[ Sidebar (fixed 312px) | Expanded(content pane) ]
                 └─ narrow:   Column[ MobileBar | Expanded(content pane) ]
                       └─ <Page> → PageScaffold(scroll + header + FadeIn + Footer)
                            └─ <Section(s)> render PortfolioData via theme tokens
```

### Routing

`buildRouter(controller)` (in `router/app_router.dart`) defines one `ShellRoute`
whose builder wraps each page in `AppShell`. Routes: `/`, `/experience`,
`/projects`, `/skills`, `/blog`, `/books` (labeled "Reading"), `/research`.
Pages cross-fade via `CustomTransitionPage` (250 ms). Unknown paths use
`errorBuilder` → `NotFoundPage` (rendered outside the shell, so it has no
sidebar). URLs are **hash-based** (e.g. `/#/experience`); the Netlify SPA
redirect serves `index.html` for any path.

### Shell & layout

`AppShell` (in `widgets/app_shell.dart`) is responsive on the desktop
breakpoint (width >= 1024):

- **Desktop:** `Row` of a fixed `Sidebar` (312px) and an `Expanded` content
  pane. The sidebar is persistent across routes (it lives in the shell, not the
  page). It holds: name (routes Home), tagline eyebrow, a vertical **section
  index** with an active marker and two-digit numbers, a "NOW" status line,
  external links, and the theme toggle.
- **Narrow:** `Column` of a `MobileBar` (name + theme toggle + popup section
  menu) above the content pane.

`PageScaffold` (in `widgets/page_scaffold.dart`) is used by every page. It owns
the content pane's `ScrollController`, left-aligns content within a measure
(`paneMaxWidth` 880, overridable), renders the optional header (mono eyebrow
tick + `title` + `lead`), applies a **single** `FadeIn` entrance, and appends
`FooterSection` sharing the same gutters/measure.

> Entrance-animation invariant: exactly one `FadeIn` per page (in
> `PageScaffold`). Sections must not nest their own `FadeIn` — nested opacity
> layers previously left content unpainted under some compositing conditions.

## Theming (design system runtime)

- `theme/app_colors.dart` — raw light/dark color constants ("Instrument"
  palette: cool paper `#F4F5F3` / graphite `#121317` grounds; cobalt accent
  `#2E47D6` light, `#6E83FF` dark).
- `theme/app_typography.dart` — type scale + helpers. Three roles: Space Grotesk
  (display/titles), Inter (body/prose), IBM Plex Mono (data/labels/eyebrows).
- `theme/app_spacing.dart` — 4px-based spacing, layout widths
  (`sidebarWidth` 312, `paneGutter` 80, `paneMaxWidth` 880, `mobileBarHeight`
  60), and `Breakpoints` (tablet 640, desktop 1024).
- `theme/app_theme.dart` — `AppTheme.light()/dark()` build `ThemeData` and
  attach the `AppPalette` `ThemeExtension`. Widgets read semantic colors via
  `AppPalette.of(context)`.
- `theme/theme_controller.dart` — `ThemeController extends ValueNotifier<ThemeMode>`
  with `toggle()`. `main.dart` rebuilds `MaterialApp` on change. Default light;
  `prefers-color-scheme` is ignored.

## Data Architecture

No database. `data/portfolio_data.dart` is the single source of truth: plain
immutable models and `PortfolioData` (a final class of `static const` lists).
Models: `Experience`, `Project`, `SkillGroup`, `EducationItem`, `BlogPost`,
`Book`, `ResearchPaper`, `ProseSpan`, `NavItem`, `LinkRef`, plus a
`ContentCategory` vocabulary used by the filter chips. Sections read these lists
directly; empty lists render tidy empty states.

## API Design

None. The app makes no network calls. The only outbound actions are
`url_launcher` calls (`utils/url.dart` `openUrl`) opening external `mailto:`,
`tel:`, and `https:` links.

## Component Overview

See [component-inventory.md](./component-inventory.md). In brief: reusable
widgets in `widgets/` (shell, sidebar, page scaffold, hover link, prose text,
category filter, mini heading, fade-in) and content blocks in `sections/`
(hero, experience, projects, skills, blog, books, research, education, footer,
shared reading primitives).

## State Management

Intentionally minimal. The only app-wide state is `ThemeController`
(`ValueNotifier<ThemeMode>`) at the root. Local `StatefulWidget`s are used only
for ephemeral UI state: hover states (nav rows, links, project rows, skill/tag
pills), the category filter selection (`CategoryFilteredList<T>`), and the
per-page scroll controller. There is no Redux/Bloc/Provider/Riverpod layer.

## Source Tree

See [source-tree-analysis.md](./source-tree-analysis.md).

## Development Workflow

See [development-guide.md](./development-guide.md). Summary: `flutter pub get`,
`flutter run -d chrome`, `flutter analyze`, `flutter test`,
`flutter build web --release`.

## Deployment Architecture

Netlify (`netlify.toml`): the build clones the Flutter stable channel (cached
between builds), runs `flutter build web --release`, publishes `build/web`, and
adds an SPA fallback redirect (`/* → /index.html 200`). Served from domain root;
default base-href `/`. See [deployment-guide.md](./deployment-guide.md).

## Testing Strategy

A single smoke/widget test at `test/widget_test.dart`. Run with `flutter test`.
`flutter analyze` is the standing lint gate (keep at zero issues).

## Notable Constraints & Gotchas

- **Hash routing:** deep links use `/#/path`.
- **Headless screenshots:** under headless SwiftShader, entrance-animated
  content may not flush its final frame to a one-shot capture until a repaint is
  triggered (navigation/click/scroll). This is a capture artifact only; real
  browsers render correctly.
- **Dead code:** `widgets/top_nav.dart` is unused (replaced by `sidebar.dart`).

---

_Generated using BMAD Method `document-project` workflow_
