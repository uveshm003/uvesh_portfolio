# uvesh_portfolio - Source Tree Analysis

**Date:** 2026-06-23

## Overview

A standard Flutter project. All application code lives under `lib/`, organized
by responsibility: content data, theme tokens, reusable widgets, page-content
sections, thin route pages, the router, and small utilities. There is no
backend and no generated code.

## Complete Directory Structure

```
uvesh_portfolio/
├── lib/                       # All application code
│   ├── main.dart              # Entry point: MaterialApp.router + theme listenable
│   ├── data/
│   │   └── portfolio_data.dart    # SINGLE SOURCE OF TRUTH: models + all content
│   ├── theme/
│   │   ├── app_colors.dart        # Raw color tokens (light/dark) — Instrument palette
│   │   ├── app_typography.dart    # Type scale + helpers (display/body/mono)
│   │   ├── app_spacing.dart       # Spacing scale, layout widths, Breakpoints
│   │   ├── app_theme.dart         # Builds ThemeData + AppPalette ThemeExtension
│   │   └── theme_controller.dart  # ValueNotifier<ThemeMode> with toggle()
│   ├── widgets/                   # Reusable building blocks
│   │   ├── app_shell.dart         # Two-pane shell (sidebar | content) / responsive
│   │   ├── sidebar.dart           # Persistent desktop sidebar + MobileBar
│   │   ├── page_scaffold.dart     # Per-page wrapper: scroll, header, footer, fade
│   │   ├── content_container.dart # Centered measure helper (used by 404)
│   │   ├── hover_link.dart        # Animated-underline link
│   │   ├── prose_text.dart        # Flowing paragraph with inline links
│   │   ├── category_filter.dart   # Chip filter + CategoryFilteredList<T>
│   │   ├── mini_heading.dart      # Small mono section heading (tick + label)
│   │   ├── profile_avatar.dart    # Circular photo + initials fallback (unused)
│   │   ├── fade_in.dart           # One-shot fade/slide entrance
│   │   └── top_nav.dart           # DEAD CODE (superseded by sidebar.dart)
│   ├── sections/                  # Page-content blocks (one concern each)
│   │   ├── hero_section.dart       # Home hero: statement + intro + platform matrix
│   │   ├── experience_section.dart # Role timeline
│   │   ├── projects_section.dart   # Numbered work index (showpiece)
│   │   ├── skills_section.dart     # Grouped skill pills
│   │   ├── blog_section.dart       # Blog cards (filterable)
│   │   ├── books_section.dart      # Currently-reading + bookshelf
│   │   ├── research_section.dart   # Research-paper cards
│   │   ├── education_section.dart  # Education entries
│   │   ├── reading_widgets.dart    # Shared card/pill/empty-state primitives
│   │   └── footer_section.dart     # Footer (pane-aligned)
│   ├── pages/                     # Thin route widgets (compose PageScaffold + section)
│   │   ├── home_page.dart
│   │   ├── experience_page.dart
│   │   ├── projects_page.dart
│   │   ├── skills_page.dart
│   │   ├── blog_page.dart
│   │   ├── books_page.dart         # Route '/books', labeled "Reading"
│   │   ├── research_page.dart
│   │   └── not_found_page.dart     # 404 (rendered outside the shell)
│   ├── router/
│   │   └── app_router.dart         # go_router: ShellRoute(AppShell) + 7 routes + 404
│   └── utils/
│       └── url.dart                # openUrl() wrapper around url_launcher
├── assets/
│   └── images/profile.jpg         # Profile photo (avatar widget currently unused)
├── web/                           # Flutter web shell (index.html, manifest, icons)
├── resumes/                       # Source resume files (PDF/DOCX) — not in web build
├── test/
│   └── widget_test.dart           # Single widget test
├── docs/                          # THIS documentation (BMAD document-project)
├── build/web/                     # Release build output (gitignored)
├── pubspec.yaml                   # Dependencies + asset declarations
├── analysis_options.yaml          # flutter_lints config
└── netlify.toml                   # Netlify build + SPA redirect config
```

## Critical Directories

### `lib/data/`

**Purpose:** Single source of truth for every piece of copy and content.
**Contains:** `portfolio_data.dart` — plain const models (`Experience`,
`Project`, `SkillGroup`, `BlogPost`, `Book`, `ResearchPaper`, `EducationItem`,
`ProseSpan`, `NavItem`, `LinkRef`) and the data lists rendered by sections.
**Integration:** Read by every `sections/` widget. Edit content here, never in
widgets.

### `lib/theme/`

**Purpose:** Token-driven design system.
**Contains:** color tokens, type scale + helpers, spacing/layout/breakpoints,
the `ThemeData` builder + `AppPalette` `ThemeExtension`, and the theme toggle
controller.
**Entry Points:** `AppTheme.light()/dark()`, `AppPalette.of(context)`.

### `lib/widgets/`

**Purpose:** Reusable, content-agnostic building blocks and app chrome.
**Contains:** the shell + sidebar, the per-page scaffold, links, prose, filters,
headings, the entrance animation.

### `lib/sections/`

**Purpose:** Content blocks that render `portfolio_data` into the design system.
**Contains:** one file per section, plus shared reading-card primitives.

### `lib/pages/`

**Purpose:** Thin route widgets; each composes a `PageScaffold` with one or more
sections and supplies the page eyebrow/title/lead.

### `lib/router/`

**Purpose:** Navigation. A single `ShellRoute` wraps every page in `AppShell`;
unknown paths fall to `NotFoundPage`.

## Entry Points

- **Main Entry:** `lib/main.dart` (`main()` → `runApp(PortfolioApp())`).
- **Router:** `lib/router/app_router.dart` (`buildRouter`).
- **Web bootstrap:** `web/index.html` (Flutter loader).

## File Organization Patterns

- **Pages are thin; sections hold content.** A page wires a `PageScaffold` to a
  section widget. Sections own the layout of their content.
- **Tokens over magic numbers.** Spacing, colors and type come from `theme/`.
- **State-light.** Most widgets are `StatelessWidget`; `StatefulWidget` is used
  only for hover/selection micro-interactions and the theme toggle.

## Key File Types

### Dart source

- **Pattern:** `lib/**/*.dart`
- **Purpose:** All app logic and UI.
- **Examples:** `main.dart`, `sections/projects_section.dart`.

### Configuration

- **Pattern:** `pubspec.yaml`, `analysis_options.yaml`, `netlify.toml`
- **Purpose:** Dependencies/assets, lints, deploy.

## Asset Locations

- **Images:** `assets/images/` (`profile.jpg`) — declared in `pubspec.yaml`.

## Configuration Files

- **`pubspec.yaml`**: dependencies, SDK constraint, asset declarations.
- **`analysis_options.yaml`**: includes `package:flutter_lints/flutter.yaml`.
- **`netlify.toml`**: build command (clones Flutter, builds web), publish dir, SPA redirect.

## Notes for Development

- `lib/widgets/top_nav.dart` is dead code, superseded by `sidebar.dart`; safe to delete.
- The Reading section's route is `/books` (label "Reading").
- Keep `flutter analyze` at zero issues.

---

_Generated using BMAD Method `document-project` workflow_
