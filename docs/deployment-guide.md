# uvesh_portfolio - Deployment Guide

**Date:** 2026-06-23

## Platform

**Netlify**, configured by `netlify.toml` at the repo root. The site is a static
Flutter Web bundle served from the domain root.

## How the build works

Netlify has no Flutter SDK preinstalled, so the build command bootstraps it:

```toml
[build]
  publish = "build/web"
  command = """
    if [ ! -d "$HOME/flutter/bin" ]; then
      git clone https://github.com/flutter/flutter.git --depth 1 -b stable "$HOME/flutter"
    fi
    export PATH="$HOME/flutter/bin:$PATH"
    flutter --version
    flutter config --enable-web
    flutter pub get
    flutter build web --release
  """

[build.environment]
  CI = "true"            # skip Flutter first-run prompts in CI

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200           # SPA fallback so deep links / refreshes load the app
```

- **Flutter SDK:** cloned (stable, shallow) on first build, cached between builds.
- **Publish dir:** `build/web` (the release bundle).
- **SPA fallback:** every unknown path serves `index.html`; the app then
  resolves the (hash-based) route.

## Base href

Served from the domain root, so the default base-href `/` is correct. **Do not**
pass a subpath in the build (no `--base-href /subdir/`).

## Manual / local production build

```bash
flutter build web --release
# then serve build/web with any static server, e.g.:
python3 -m http.server 8090 --bind 127.0.0.1   # from build/web
```

## Infrastructure requirements

None beyond a static host. No backend, database, secrets, or runtime
environment variables are needed.

## Deploy process

1. Push to the repository branch connected to Netlify.
2. Netlify runs the build command above and publishes `build/web`.
3. The SPA redirect ensures direct links and refreshes resolve correctly.

## Other CI/CD

No GitHub Actions / GitLab CI / other pipelines are present. `flutter analyze`
and `flutter test` are run locally as quality gates.

---

_Generated using BMAD Method `document-project` workflow_
