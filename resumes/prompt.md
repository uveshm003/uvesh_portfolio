# Claude Code Prompt — Flutter Portfolio Website

Build me a **responsive, professional, minimalistic personal portfolio website using Flutter Web**. This is a static, content-driven site — no backend, no authentication, no database.

## Design direction

Take strong inspiration from `https://arpitbhayani.me` — study its restraint:

- **Single-column, prose-forward layout.** The hero is a circular profile photo, my name, a one-line tagline, and a flowing introduction paragraph written in natural prose with inline links (to companies, projects, GitHub). Avoid card grids and "feature box" clutter where prose reads better.
- **Generous whitespace and a comfortable reading measure** (cap body text around 680–720px, centered). Large line-height, calm vertical rhythm.
- **Restrained palette.** Near-white background, near-black text (not pure #000/#fff — use soft off-shades), a single understated accent color for links/hover. Provide a light theme by default; a clean dark theme toggle is a plus but optional.
- **Typography does the work.** Use a refined typeface pairing (e.g. a serif or distinctive sans for headings, a readable sans for body) via `google_fonts`. Clear type scale, no decorative noise.
- **Minimal motion.** Subtle hover underlines/color shifts and gentle fade-ins on scroll at most. No parallax, no heavy animation.
- Section headings are small, quiet labels ("Experience", "Projects") — the content carries the page, not the chrome.

## Tech & architecture

- Flutter (latest stable), **web target**, also lay it out so it renders fine if compiled for desktop.
- Keep dependencies light: `google_fonts`, `url_launcher`, `flutter_svg` if needed, `go_router` for clean section routing/anchors. No heavy state management — plain `StatefulWidget`/`ValueNotifier` is enough for the theme toggle.
- Clean folder structure: `lib/main.dart`, `lib/theme/` (colors, typography, spacing tokens), `lib/widgets/` (reusable section + nav + footer widgets), `lib/sections/` (one file per page section), and **`lib/data/portfolio_data.dart`** holding all my content as typed Dart constants/models so text is easy to edit in one place.
- Fully responsive: a mobile-first single column that scales gracefully to tablet/desktop. Use `LayoutBuilder`/breakpoints, not fixed pixel widths. Sticky/minimal top nav that collapses sensibly on small screens.
- Accessible: semantic structure, sufficient contrast, keyboard-focusable links, alt/semantics labels on the image and icons.
- Performance: defer/cache the profile image, avoid layout jank, keep the bundle lean.

## Page structure

A single scrolling page with a thin top nav that anchor-scrolls to sections (and a 404/fallback route via go_router):

1. **Top nav** — my name on the left; right-side links: Experience, Projects, Skills, GitHub, LinkedIn, Email. Collapses to a simple menu on mobile.
2. **Hero / Intro** — circular profile photo (use a placeholder asset `assets/images/profile.jpg` and reference it; I'll swap in my own), my name, a one-line tagline, then a prose intro (see content below) with inline links.
3. **Experience** — clean, list-style entries (role · company · dates), each with a short prose blurb. Quiet, not boxed-in.
4. **Projects** — selected work, each as title + tech line + 1–2 sentence description, with links where relevant.
5. **Skills** — grouped, scannable (Languages, Frameworks & Platforms, Architecture, Device & Integration, DevOps & Tools). Keep it light — inline tag-style or simple grouped lists, not loud badges.
6. **Footer** — grouped links (Contact / Social / Built with), copyright line.

## Content (use exactly this — it's my real résumé data)

**Name:** Muhammad Uvesh Menpurwala
**Tagline:** Software Engineer · Mobile & Cross-Platform Development
**Location:** Ahmedabad, India
**Email:** uveshmenpur.03@gmail.com
**Phone:** +91 9624150392
**LinkedIn:** linkedin.com/in/muhammaduvesh
**GitHub:** github.com/uveshm003

**Intro (write this as flowing prose with inline links, arpitbhayani.me style):**
Software Engineer with 3+ years of commercial experience building cross-platform mobile and desktop applications. Currently at Sensit Technologies (Halma PLC), architecting and shipping enterprise-grade Flutter applications across Android, iOS, and Windows. Track record in monorepo architecture, hardware device integration, offline-first systems, SDK development, and release management. Experienced in BLE device communication, native platform channels, automation, and expanding into full-stack web development.

**Experience:**

- **Software Engineer · Sensit Technologies (Halma PLC)** — Jan 2025 – Present, Ahmedabad. Primary developer on SyncIt, a strategic platform consolidating legacy Sensit applications into one cross-platform product (Android, iOS, Windows) built with Flutter on a Melos monorepo. Took a POC to a production MVP; architected two variants — SyncIt Lite (offline-first) and SyncIt Plus (cloud sync, advanced reporting). Built a shared Core Package and a Log Parsing SDK, device communication modules (log download, parsing, visualization, firmware update workflows, multi-format export), Windows-scheduled reporting over LAN, and owned the full build/release pipeline. Built n8n automation workflows and used Claude Code / AI-assisted tooling to accelerate engineering. Coordinates with global teams across India, Italy, and the USA.

- **Flutter Developer · Kaymatech** — Jan 2025 – Present, Ahmedabad. Delivered 12–15 applications across Android, iOS, macOS, Windows, and Linux. Built a complete In-App Purchase infrastructure for Windows, opening a new revenue stream; proposed and shipped architectural changes that cut development turnaround time.

- **Junior Mobile Consultant · Kody Technolabs Limited** — Sep 2023 – Jan 2025, Ahmedabad. Core developer on Dasher, a 9-panel delivery-robot platform; led the Main Panel (ROS SDK + Android native serial commands) and Advertisement Panel (dynamic content scheduling, remote file transfer). Built Odigo (dual-mirrored advertising robot) with Flutter, Platform Channels, ROS SDK, Socket.IO. Integrated BLE and Android Nearby Connections; implemented Dynamic Forms, Web Route Management, and end-to-end API encryption/decryption via platform channels.

- **Mobile Developer Intern · Kody Technolabs Limited** — Jun 2023 – Sep 2023, Ahmedabad. Built UI and API integrations for a Soccer Card Trading app and a Restaurant Reservation app using MVVM + DDD.

- **Flutter Developer Intern · Iconflux Technologies** — Mar 2023 – Jun 2023, Ahmedabad. Built a competitive-exam prep app with study materials, mock tests, and performance analytics.

**Projects:**

- **SyncIt Platform** — *Flutter · Melos · BLoC · Hive · REST APIs · Windows · Android · iOS.* Enterprise monorepo platform replacing legacy tools, with Lite (offline-first) and Plus (cloud-connected) variants from one shared codebase. Includes device communication, log parsing SDK, data visualization, firmware management, scheduled reporting, multi-format export.
- **Dasher (Delivery Robot)** — *Flutter · Android Native · ROS SDK · BLE · Platform Channels · Firebase · Socket.IO.* Multi-panel robot platform (9 apps); led Main Panel (ROS control) and Advertisement Panel (dynamic content + remote scheduling).
- **Medigo (Healthcare App)** — *Flutter · BLE · Medigo SDK.* Patient-facing app connecting to medical devices over Bluetooth for blood pressure and ECG tracking, with medication reminders and health alerts.
- **Vault (Personal Project)** — *Flutter · BLoC · Hive · GoRouter · Offline-First.* Fully offline personal inventory tracker across Android, iOS, Windows, macOS, and Linux with a custom design system.

**Skills:**

- **Languages:** Dart, Java, Kotlin, JavaScript, Python, C/C++, HTML/CSS
- **Frameworks & Platforms:** Flutter (Android · iOS · Windows · macOS · Linux · Web), Jetpack Compose, Angular, Node.js, Express.js
- **State Management:** BLoC, Riverpod, Provider, GetX
- **Architecture:** MVVM, DDD, Monorepo (Melos), Offline-First, Modular SDK Design
- **Device & Integration:** BLE, Platform Channels, ROS SDK, REST APIs, WebSocket / Socket.IO, Firmware Update Workflows
- **Databases & Storage:** Hive, ObjectBox, SQLite, MongoDB, Firebase Firestore, Firebase Suite
- **DevOps & Tools:** Git, GitHub Actions, CI/CD, n8n, Melos, Postman, Android Studio, VS Code
- **AI & Automation:** Claude Code, AI-Assisted Development, Workflow Automation

**Education:**
- B.E. in Information Technology — SAL College of Engineering, Ahmedabad (2020–2023), SPI 7.5
- Diploma in Information Technology — Government Polytechnic, Ahmedabad (2017–2020), SPI 8.6

## Deliverables & setup

- Create a complete, runnable Flutter web project. Initialize it, add dependencies, and make sure `flutter run -d chrome` works out of the box.
- Put all copy in `lib/data/portfolio_data.dart` so I can edit text without touching widgets.
- Centralize all colors, spacing, and text styles as theme tokens — no magic numbers scattered through widgets.
- Add a short `README.md` with: how to run locally, how to edit my content, and how to build + deploy to **GitHub Pages** (include the correct `flutter build web --base-href` note since my repo is `github.com/uveshm003`).
- Use a placeholder image at `assets/images/profile.jpg` and wire up `pubspec.yaml` assets so I can drop my own photo in.

## Constraints

- Keep it genuinely minimalist — when in doubt, remove. Prefer prose and whitespace over UI density.
- No lorem ipsum; use the real content above.
- No external CMS, no analytics trackers, no cookie banners.
- Comment the code where structure isn't obvious, and keep widgets small and composable.

Start by scaffolding the project and theme tokens, then build section by section, and run it at the end to confirm it compiles and looks right at mobile, tablet, and desktop widths.