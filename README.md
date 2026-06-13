# Uvesh Menpurwala — Portfolio

A minimalist, prose-forward personal portfolio built with **Flutter Web**. Static and content-driven: no backend, database, or analytics.

Light/dark themes, responsive single-column layout, anchor-scrolling top nav, and all copy centralized in one data file.

---

## Run locally

You need the [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable, 3.4+).

```bash
flutter pub get
flutter run -d chrome
```

That serves the site in Chrome with hot reload. To run on desktop instead (the layout adapts), use `-d macos`, `-d windows`, or `-d linux`.

---

## Edit my content

**All text lives in [`lib/data/portfolio_data.dart`](lib/data/portfolio_data.dart).** Edit it there — never in the widgets. It holds:

- Identity (name, tagline, location) and contact/social links
- The intro prose, including which words are inline links (`ProseSpan(text, url: ...)`)
- `experiences`, `projects`, `skills`, `education` — typed lists; add/remove/reorder entries freely

### Swap the profile photo

Replace [`assets/images/profile.jpg`](assets/images/profile.jpg) with your own photo (keep the same filename). A square image works best — it's clipped to a circle. If the file is ever missing, the hero falls back to your initials, so the layout never breaks.

### Change the look

All colors, spacing, and type styles are theme tokens — there are no magic numbers in the widgets:

- [`lib/theme/app_colors.dart`](lib/theme/app_colors.dart) — light/dark palettes
- [`lib/theme/app_typography.dart`](lib/theme/app_typography.dart) — the Fraunces (serif) + Inter (sans) pairing and type scale
- [`lib/theme/app_spacing.dart`](lib/theme/app_spacing.dart) — spacing scale, breakpoints, reading-measure width

> **Note:** fonts are loaded at runtime from Google Fonts' CDN via the `google_fonts` package, so first paint depends on the network. To make the site fully self-contained/offline, download the Fraunces and Inter `.ttf` files, declare them under `flutter > fonts` in `pubspec.yaml`, and `google_fonts` will use the bundled copies automatically.

---

## Build & deploy to GitHub Pages

GitHub Pages serves a **project repo** from a subpath (`https://uveshm003.github.io/<repo-name>/`), so the build needs a matching `--base-href`. The value must start and end with `/`.

This repo is named `uvesh_portfolio`, so:

```bash
flutter build web --base-href "/uvesh_portfolio/"
```

> **Pick the base-href that matches your repo:**
> - **Project repo** (`github.com/uveshm003/<repo-name>`) → `--base-href "/<repo-name>/"`
> - **User/organization site** (a repo literally named `uveshm003.github.io`) → `--base-href "/"`
>
> If the page loads blank with 404s for `main.dart.js`, the base-href doesn't match the path you're served from — that's the first thing to check.

The compiled site lands in `build/web/`. Routing is hash-based (e.g. `/#/`), which GitHub Pages serves without any server-side rewrite config.

### Deploy

**Option A — `gh-pages` branch (manual):**

```bash
flutter build web --base-href "/uvesh_portfolio/"
# publish the contents of build/web to the gh-pages branch, e.g. with:
npx gh-pages -d build/web
```

Then in the repo's **Settings → Pages**, set the source to the `gh-pages` branch.

**Option B — GitHub Actions (automatic on push):** add `.github/workflows/deploy.yml`:

```yaml
name: Deploy to GitHub Pages
on:
  push:
    branches: [main]
permissions:
  contents: read
  pages: write
  id-token: write
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: stable
      - run: flutter pub get
      - run: flutter build web --base-href "/uvesh_portfolio/"
      - uses: actions/upload-pages-artifact@v3
        with:
          path: build/web
  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - id: deployment
        uses: actions/deploy-pages@v4
```

Then set **Settings → Pages → Source** to **GitHub Actions**.

---

## Project structure

```
lib/
  main.dart                 App root + theme toggle wiring
  data/portfolio_data.dart  ← all content lives here
  theme/                    colors, typography, spacing tokens, theme + controller
  widgets/                  reusable pieces (nav, section, links, avatar, prose)
  sections/                 one file per page section (hero, experience, …, footer)
  pages/                    home page (scroll + anchors) and 404 fallback
  router/app_router.dart    go_router config (home + catch-all 404)
```

## Tests

```bash
flutter test
```

Covers rendering of the hero/sections, no-overflow layout at mobile/tablet/desktop widths, and the theme toggle.
