# uvesh_portfolio - Component Inventory

**Date:** 2026-06-23

Catalog of the app's widgets and content sections, plus the design-system
elements they share. All are Flutter widgets under `lib/`.

## Design System Elements

Defined in `lib/theme/` and consumed everywhere via `AppPalette.of(context)`,
`Theme.of(context).textTheme`, and `AppTypography`/`AppSpacing` helpers.

- **Palette ("Instrument"):** cool paper `#F4F5F3` / graphite `#121317` grounds;
  cobalt accent `#2E47D6` (light) / `#6E83FF` (dark); muted text tiers; hairline
  dividers. Exposed as the `AppPalette` `ThemeExtension`.
- **Type roles:** Space Grotesk (display/titles/`heroName`), Inter (body/prose),
  IBM Plex Mono (eyebrows, dates, tags, indices, nav, wordmark). Helpers:
  `AppTypography.heroName/sectionLabel/tag/indexNumeral/mono` + the `TextTheme`.
- **Spacing/layout:** 4px scale (`xxs`…`huge`); widths `sidebarWidth` 312,
  `paneGutter` 80, `paneMaxWidth` 880; `Breakpoints` (tablet 640, desktop 1024).
- **Detailing:** sharp corners (panels 8px, pills/cells 4px), hairline borders,
  mono labels prefixed by a short accent tick.

## App Chrome (Layout) Components

| Component | File | Role |
| --- | --- | --- |
| `AppShell` | `widgets/app_shell.dart` | Responsive two-pane shell: `Sidebar`+content (desktop) or `MobileBar`+content (narrow). |
| `Sidebar` | `widgets/sidebar.dart` | Persistent desktop identity panel: name, tagline, numbered section index w/ active marker, NOW status, links, theme toggle. |
| `MobileBar` | `widgets/sidebar.dart` | Collapsed top bar: name, theme toggle, popup section menu. |
| `PageScaffold` | `widgets/page_scaffold.dart` | Per-page wrapper: own scroll, mono eyebrow+title+lead header, single `FadeIn`, footer. |
| `FooterSection` | `sections/footer_section.dart` | Footer (Contact/Social/Built-with + copyright), pane-aligned. |
| `ContentContainer` | `widgets/content_container.dart` | Centered measure helper (used by 404). |

## Reusable UI Primitives

| Component | File | Role |
| --- | --- | --- |
| `HoverLink` | `widgets/hover_link.dart` | Text link with animated underline + hover color. |
| `ProseText` | `widgets/prose_text.dart` | Flowing paragraph from `ProseSpan`s with inline links. |
| `MiniHeading` | `widgets/mini_heading.dart` | Small mono section heading (accent tick + label). |
| `CategoryFilterBar` / `CategoryFilteredList<T>` | `widgets/category_filter.dart` | Chip filter + generic filtered list with cross-fade and empty state. |
| `FadeIn` | `widgets/fade_in.dart` | One-shot fade/slide entrance (one per page, in `PageScaffold`). |
| `ProfileAvatar` | `widgets/profile_avatar.dart` | Circular photo with initials fallback. **Currently unused** in the layout. |
| `ReadingCard` / `ReadingTitleRow` / `TagPill` / `ReadingEmptyState` | `sections/reading_widgets.dart` | Shared card language for Blog/Reading/Research. |

## Content Sections

Each renders data from `portfolio_data.dart`. Composed by a thin page in
`pages/`.

| Section | File | Renders |
| --- | --- | --- |
| `HeroContent` | `sections/hero_section.dart` | Home hero: `INTRODUCTION` eyebrow, statement headline, intro prose, six-platform "SHIPS TO" matrix (name shown here on narrow screens). |
| `ExperienceContent` | `sections/experience_section.dart` | Vertical timeline of roles (role · company, period · location, blurb). |
| `ProjectsContent` | `sections/projects_section.dart` | **Showpiece:** numbered work index — big mono numerals, large titles, category, tech tags, hover wash + arrow for linked entries. |
| `SkillsContent` | `sections/skills_section.dart` | Skill groups, each a mono label + pills. |
| `BlogContent` | `sections/blog_section.dart` | Blog cards (date kicker, title, summary, topic pills), category-filtered; empty state. |
| `CurrentlyReadingContent` / `BooksContent` | `sections/books_section.dart` | Currently-reading cards (spine + progress bar) and the bookshelf (category-filtered). |
| `ResearchPapersContent` | `sections/research_section.dart` | Paper cards (citation line, summary, topic pills), category-filtered. |
| `EducationContent` | `sections/education_section.dart` | Two education entries (degree, institution, period · score). |

## Pages (route widgets)

`pages/`: `HomePage`, `ExperiencePage`, `ProjectsPage`, `SkillsPage`,
`BlogPage`, `BooksPage` (route `/books`, label "Reading"), `ResearchPage`,
`NotFoundPage`. Each (except 404) composes a `PageScaffold` with its section(s)
and supplies the eyebrow/title/lead.

## Component Patterns

- **Reusable vs specific:** `widgets/` are content-agnostic and reused;
  `sections/` are content-specific.
- **Hover micro-interactions:** localized `StatefulWidget`s (nav rows, links,
  project rows, pills) — no global state.
- **Empty-state aware:** filtered lists render a `ReadingEmptyState` when a
  category or list is empty, so the page never looks broken.

---

_Generated using BMAD Method `document-project` workflow_
