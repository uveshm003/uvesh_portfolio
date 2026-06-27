/// Single source of truth for every piece of copy on the site.
///
/// Edit text here - never in the widgets. The models are intentionally plain
/// so non-Dart edits (changing a date, adding a project) are obvious.
library;

/// A run of intro text that may optionally be a hyperlink. The hero renders a
/// list of these as flowing prose with inline links (arpitbhayani.me style).
class ProseSpan {
  const ProseSpan(this.text, {this.url});

  final String text;

  /// When non-null the [text] renders as an inline accent-colored link.
  final String? url;

  bool get isLink => url != null;
}

class Experience {
  const Experience({required this.role, required this.company, required this.period, required this.location, required this.blurb, this.url});

  final String role;
  final String company;
  final String period;
  final String location;
  final String blurb;

  /// Optional company link.
  final String? url;
}

class Project {
  const Project({required this.title, required this.category, required this.tech, required this.description, this.url});

  final String title;

  /// Short editorial tag shown beside the title (e.g. "Enterprise", "Personal").
  final String category;

  /// Tech stack as a single ` · `-separated string. Use [techItems] to render
  /// it as individual tags.
  final String tech;

  final String description;
  final String? url;

  /// The tech string split into individual, trimmed tokens for tag rendering.
  List<String> get techItems => tech.split('·').map((t) => t.trim()).where((t) => t.isNotEmpty).toList();
}

class SkillGroup {
  const SkillGroup({required this.label, required this.items});

  final String label;
  final List<String> items;
}

class EducationItem {
  const EducationItem({required this.degree, required this.institution, required this.period, required this.score});

  final String degree;
  final String institution;
  final String period;
  final String score;
}

/// A navigation / social / contact destination.
class LinkRef {
  const LinkRef(this.label, this.url);
  final String label;
  final String url;
}

/// A top-nav destination that maps a label to an in-app route.
class NavItem {
  const NavItem(this.label, this.path);
  final String label;
  final String path;
}

/// Shared category vocabulary for the filterable content lists (Blog, Books,
/// Research). The chip rows derive their options from the values actually used,
/// and default to [technical] when it's present. Keep these stable so the
/// "Technical" default works across every section.
abstract final class ContentCategory {
  static const String technical = 'Technical';
  static const String nonTechnical = 'Non-Technical';
  static const String ai = 'AI / ML';
}

/// A blog post / writing entry. Add entries to [PortfolioData.blogs] as you
/// publish; an `url` makes the card link out.
class BlogPost {
  const BlogPost({
    required this.title,
    required this.date,
    required this.summary,
    this.category = ContentCategory.technical,
    this.url,
    this.readingTime,
    this.tags = const [],
  });

  final String title;
  final String date;
  final String summary;
  final String? url;

  /// High-level category used by the page's filter chips (e.g. "Technical").
  final String category;

  /// Optional estimated read time, e.g. "6 min read".
  final String? readingTime;

  /// Optional topic tags rendered as small pills.
  final List<String> tags;
}

/// A book on the reading list.
class Book {
  const Book({
    required this.title,
    required this.author,
    this.category = ContentCategory.technical,
    this.note,
    this.url,
    this.tag,
    this.progress,
  });

  final String title;
  final String author;

  /// High-level category used by the shelf's filter chips (e.g. "Technical").
  final String category;

  /// Optional one-line personal take.
  final String? note;

  /// Optional link (Goodreads, publisher, review, …).
  final String? url;

  /// Optional genre / topic label rendered as a small pill (e.g. "Systems").
  final String? tag;

  /// Reading progress as a fraction in `0.0 – 1.0`. Set this for books in
  /// [PortfolioData.currentlyReading] to draw a progress bar; leave null for
  /// finished books on the shelf.
  final double? progress;
}

/// A research paper worth reading. Mirrors [Book] but carries publication
/// metadata (authors, venue, year) instead of a single author line.
class ResearchPaper {
  const ResearchPaper({
    required this.title,
    required this.authors,
    required this.venue,
    required this.year,
    this.category = ContentCategory.technical,
    this.summary,
    this.url,
    this.topics = const [],
  });

  final String title;

  /// High-level category used by the page's filter chips (e.g. "Technical").
  final String category;

  /// Author line, e.g. "Dean & Ghemawat".
  final String authors;

  /// Publication venue, e.g. "OSDI", "USENIX ATC".
  final String venue;

  final String year;

  /// Optional one-line note on why it matters / what it covers.
  final String? summary;

  /// Optional link (DOI, arXiv, PDF, …).
  final String? url;

  /// Optional topic tags rendered as small pills.
  final List<String> topics;
}

/// ---------------------------------------------------------------------------
/// Content
/// ---------------------------------------------------------------------------
class PortfolioData {
  const PortfolioData._();

  // ---- Identity -------------------------------------------------------------
  static const String name = 'Muhammad Uvesh Menpurwala';
  static const String shortName = 'Uvesh Menpurwala';
  static const String tagline = 'Software Engineer · Mobile & Cross-Platform Development';
  static const String location = 'Ahmedabad, India';

  // ---- Contact / social -----------------------------------------------------
  static const String email = 'uveshmenpur.03@gmail.com';
  static const String phone = '+91 9624150392';
  static const String linkedInUrl = 'https://www.linkedin.com/in/muhammaduvesh';
  static const String githubUrl = 'https://github.com/uveshm003';
  static const String companyUrl = 'https://gasleaksensors.com';

  // const string interpolation of a const String - usable in const lists.
  static const String emailUrl = 'mailto:$email';
  static String get phoneUrl => 'tel:${phone.replaceAll(' ', '')}';

  /// Profile photo. Swap the file at this path to change it.
  static const String profileImage = 'assets/images/profile.jpg';

  // ---- Intro prose (flowing, with inline links) -----------------------------
  static const List<ProseSpan> intro = [
    ProseSpan(
      'Software Engineer with 3+ years of commercial experience building '
      'cross-platform mobile and desktop applications. Currently at ',
    ),
    ProseSpan('Sensit Technologies (Halma PLC)', url: companyUrl),
    ProseSpan(
      ', architecting and shipping enterprise-grade Flutter applications '
      'across Android, iOS, and Windows. Track record in monorepo '
      'architecture, hardware device integration, offline-first systems, SDK '
      'development, and release management. Experienced in BLE device '
      'communication, native platform channels, automation, and expanding '
      'into full-stack web development.',
    ),
  ];

  // ---- Experience -----------------------------------------------------------
  static const List<Experience> experiences = [
    Experience(
      role: 'Software Engineer',
      company: 'Sensit Technologies (Halma PLC)',
      period: 'Jan 2025 – Present',
      location: 'Ahmedabad',
      url: companyUrl,
      blurb:
          'Primary developer on SyncIt, a strategic platform consolidating '
          'legacy Sensit applications into one cross-platform product '
          '(Android, iOS, Windows) built with Flutter on a Melos monorepo. '
          'Took a POC to a production MVP and architected two variants: '
          'SyncIt Lite (offline-first) and SyncIt Plus (cloud sync, advanced '
          'reporting). Built a shared Core Package and a Log Parsing SDK, '
          'device communication modules (log download, parsing, '
          'visualization, firmware update workflows, multi-format export), '
          'Windows-scheduled reporting over LAN, and owned the full '
          'build/release pipeline. Built n8n automation workflows and used '
          'Claude Code / AI-assisted tooling to accelerate engineering. '
          'Coordinates with global teams across India, Italy, and the USA.',
    ),
    Experience(
      role: 'Flutter Developer',
      company: 'Kaymatech',
      period: 'Jan 2025 – Present',
      location: 'Ahmedabad',
      blurb:
          'Delivered 12–15 applications across Android, iOS, macOS, Windows, '
          'and Linux. Built a complete In-App Purchase infrastructure for '
          'Windows, opening a new revenue stream; proposed and shipped '
          'architectural changes that cut development turnaround time.',
    ),
    Experience(
      role: 'Junior Mobile Consultant',
      company: 'Kody Technolabs Limited',
      period: 'Sep 2023 – Jan 2025',
      location: 'Ahmedabad',
      blurb:
          'Core developer on Dasher, a 9-panel delivery-robot platform; led '
          'the Main Panel (ROS SDK + Android native serial commands) and '
          'Advertisement Panel (dynamic content scheduling, remote file '
          'transfer). Built Odigo (dual-mirrored advertising robot) with '
          'Flutter, Platform Channels, ROS SDK, and Socket.IO. Integrated BLE '
          'and Android Nearby Connections; implemented Dynamic Forms, Web '
          'Route Management, and end-to-end API encryption/decryption via '
          'platform channels.',
    ),
    Experience(
      role: 'Mobile Developer Intern',
      company: 'Kody Technolabs Limited',
      period: 'Jun 2023 – Sep 2023',
      location: 'Ahmedabad',
      blurb:
          'Built UI and API integrations for a Soccer Card Trading app and a '
          'Restaurant Reservation app using MVVM + DDD.',
    ),
    Experience(
      role: 'Flutter Developer Intern',
      company: 'Iconflux Technologies',
      period: 'Mar 2023 – Jun 2023',
      location: 'Ahmedabad',
      blurb:
          'Built a competitive-exam prep app with study materials, mock '
          'tests, and performance analytics.',
    ),
  ];

  // ---- Projects -------------------------------------------------------------
  static const List<Project> projects = [
    Project(
      title: 'SyncIt Platform',
      category: 'Enterprise',
      tech: 'Flutter · Melos · BLoC · Hive · REST APIs · Windows · Android · iOS',
      description:
          'Enterprise monorepo platform replacing legacy Sensit tools, with '
          'Lite (offline-first) and Plus (cloud-connected) variants built from '
          'one shared codebase. Spans device communication, a log-parsing SDK, '
          'data visualization, firmware management, LAN-scheduled reporting, '
          'and multi-format export.',
    ),
    Project(
      title: 'Dasher',
      category: 'Robotics',
      tech:
          'Flutter · Android Native · ROS SDK · BLE · Platform Channels · '
          'Firebase · Socket.IO',
      description:
          'Multi-display delivery-robot platform of nine integrated panels. '
          'Led the Main Panel (robot control via ROS SDK and native serial '
          'commands) and the Advertisement Panel, driving dynamic content with '
          'remote file transfer and scheduling. Added BLE and Nearby '
          'Connections for real-time device coordination.',
    ),
    Project(
      title: 'Odigo',
      category: 'Robotics',
      tech: 'Flutter · Platform Channels · ROS SDK · Socket.IO',
      description:
          'Advertising robot for public spaces like malls and airports, with '
          'two mirrored displays driven from a single control panel. Built the '
          'Flutter app and the native bridge coordinating displays and robot '
          'motion.',
    ),
    Project(
      title: 'Medigo',
      category: 'Healthcare',
      tech: 'Flutter · BLE · Medigo SDK',
      description:
          'Patient-facing health app that pairs with medical devices over '
          'Bluetooth to track blood pressure and ECG, with medication '
          'reminders and health alerts.',
    ),
    Project(
      title: 'SpeakUp',
      category: 'Personal',
      url: 'https://github.com/uveshm003/speakup',
      tech: 'Flutter · BLoC · ObjectBox · Hive · GoRouter · Offline-First',
      description:
          'A fully offline English-communication trainer that turns daily '
          'practice into a guided card-draw loop: pick a category, draw a '
          'card, read a mini-guide, then speak against a timer and build a '
          'streak. Audio capture and playback included, shipped from a single '
          'codebase to all six Flutter platforms.',
    ),
    Project(
      title: 'Vault',
      category: 'Personal',
      tech: 'Flutter · BLoC · Hive · GoRouter · Offline-First',
      description:
          'Fully offline personal inventory tracker across Android, iOS, '
          'Windows, macOS, and Linux, built on a custom design system.',
    ),
    Project(
      title: 'Be My Hand',
      category: 'Academic',
      tech: 'Flutter · Firebase Firestore',
      description:
          'Academic project connecting students with disabilities to '
          'volunteer scribes for exams, coordinating requests and matches over '
          'Firestore.',
    ),
  ];

  // ---- Skills ---------------------------------------------------------------
  static const List<SkillGroup> skills = [
    SkillGroup(label: 'Languages', items: ['Dart', 'Java', 'Kotlin', 'JavaScript', 'Python', 'C/C++', 'HTML/CSS']),
    SkillGroup(
      label: 'Frameworks & Platforms',
      items: ['Flutter (Android · iOS · Windows · macOS · Linux · Web)', 'Jetpack Compose', 'Angular', 'Node.js', 'Express.js'],
    ),
    SkillGroup(label: 'State Management', items: ['BLoC', 'Riverpod', 'Provider', 'GetX']),
    SkillGroup(label: 'Architecture', items: ['MVVM', 'DDD', 'Monorepo (Melos)', 'Offline-First', 'Modular SDK Design']),
    SkillGroup(
      label: 'Device & Integration',
      items: ['BLE', 'Platform Channels', 'ROS SDK', 'REST APIs', 'WebSocket / Socket.IO', 'Firmware Update Workflows'],
    ),
    SkillGroup(label: 'Databases & Storage', items: ['Hive', 'ObjectBox', 'SQLite', 'MongoDB', 'Firebase Firestore', 'Firebase Suite']),
    SkillGroup(label: 'DevOps & Tools', items: ['Git', 'GitHub Actions', 'CI/CD', 'n8n', 'Melos', 'Postman', 'Android Studio', 'VS Code']),
    SkillGroup(label: 'AI & Automation', items: ['Claude Code', 'AI-Assisted Development', 'Workflow Automation']),
  ];

  // ---- Education ------------------------------------------------------------
  static const List<EducationItem> education = [
    EducationItem(
      degree: 'B.E. in Information Technology',
      institution: 'SAL College of Engineering, Ahmedabad',
      period: '2020 – 2023',
      score: 'SPI 7.5',
    ),
    EducationItem(
      degree: 'Diploma in Information Technology',
      institution: 'Government Polytechnic, Ahmedabad',
      period: '2017 – 2020',
      score: 'SPI 8.6',
    ),
  ];

  // ---- Navigation -----------------------------------------------------------
  /// Top-nav destinations, each its own page/route. Reorder freely; the shell
  /// renders them in this order and highlights the active one.
  static const List<NavItem> navItems = [
    NavItem('Home', '/'),
    NavItem('Experience', '/experience'),
    NavItem('Projects', '/projects'),
    NavItem('Skills', '/skills'),
    NavItem('Blog', '/blog'),
    NavItem('Reading', '/books'),
    NavItem('Research', '/research'),
  ];

  static const List<LinkRef> navExternal = [LinkRef('GitHub', githubUrl), LinkRef('LinkedIn', linkedInUrl), LinkRef('Email', emailUrl)];

  // ---- Blog -----------------------------------------------------------------
  /// Writing. Empty for now - add [BlogPost] entries here as you publish and
  /// the Blog page fills in automatically (an empty list shows a tidy
  /// "coming soon" state).
  static const List<BlogPost> blogs = [
    BlogPost(
      title: 'Designing an offline-first sync engine',
      date: 'Jun 2026',
      category: ContentCategory.technical,
      summary: 'Notes on conflict resolution and local-first storage: how to '
          'keep a Flutter app usable with zero connectivity and reconcile '
          'cleanly when the network returns.',
      readingTime: '8 min read',
      tags: ['Flutter', 'Offline-First', 'Architecture'],
      url: 'https://example.com/post',
    ),
    BlogPost(
      title: 'Shipping to six platforms from one codebase',
      date: 'Apr 2026',
      category: ContentCategory.technical,
      summary: 'What it actually takes to keep Android, iOS, Windows, macOS, '
          'Linux and Web honest from a single Flutter codebase.',
      readingTime: '6 min read',
      tags: ['Flutter', 'Cross-Platform', 'Release'],
      url: 'https://example.com/post-2',
    ),
    BlogPost(
      title: 'Staying sane while shipping cross-platform',
      date: 'Feb 2026',
      category: ContentCategory.nonTechnical,
      summary: 'Habits, focus and the non-code side of doing engineering work '
          'that lasts, and what has kept me steady over three years.',
      readingTime: '4 min read',
      tags: ['Career', 'Habits'],
      url: 'https://example.com/post-3',
    ),
  ];

  // ---- Currently reading ----------------------------------------------------
  /// What's on the desk right now. Each entry carries a `progress` fraction
  /// (0.0 – 1.0) that the Reading page renders as a thin progress bar. Clear
  /// the list to hide the section entirely.
  static const List<Book> currentlyReading = [
    Book(
      title: 'Designing Data-Intensive Applications',
      author: 'Martin Kleppmann',
      tag: 'Systems',
      progress: 0.45,
      note: 'Working through the storage and replication chapters.',
      url: 'https://www.amazon.com/Designing-Data-Intensive-Applications-Reliable-Maintainable/dp/1449373321',
    ),
    Book(
      title: 'Grokking Algorithms',
      author: 'Aditya Bhargava',
      tag: 'Foundations',
      progress: 0.7,
      url: 'https://www.manning.com/books/grokking-algorithms',
    ),
  ];

  // ---- Books ----------------------------------------------------------------
  /// Finished / recommended reads. Add books you've actually read and the
  /// Reading page fills in the shelf automatically (an empty list shows a tidy
  /// placeholder).
  static const List<Book> books = [
    Book(
      title: 'Clean Architecture',
      author: 'Robert C. Martin',
      category: ContentCategory.technical,
      tag: 'Craft',
      note: 'Sharpened how I draw boundaries between layers in large apps.',
      url: 'https://www.amazon.com/Clean-Architecture-Craftsmans-Software-Structure/dp/0134494164',
    ),
    Book(
      title: 'The Pragmatic Programmer',
      author: 'Hunt & Thomas',
      category: ContentCategory.technical,
      tag: 'Craft',
      url: 'https://pragprog.com/titles/tpp20/the-pragmatic-programmer-20th-anniversary-edition/',
    ),
    Book(
      title: 'Refactoring',
      author: 'Martin Fowler',
      category: ContentCategory.technical,
      tag: 'Craft',
      url: 'https://martinfowler.com/books/refactoring.html',
    ),
    Book(
      title: 'The 5AM Club',
      author: 'Robin Sharma',
      category: ContentCategory.nonTechnical,
      tag: 'Habits',
      url: 'https://www.amazon.com/The-5-AM-Club-Robin-Sharma-audiobook/dp/B07KRM53PR',
    ),
    Book(
      title: 'Atomic Habits',
      author: 'James Clear',
      category: ContentCategory.nonTechnical,
      tag: 'Habits',
      url: 'https://jamesclear.com/atomic-habits',
    ),
  ];

  // ---- Research papers ------------------------------------------------------
  /// Papers worth a read. Add [ResearchPaper] entries and the Reading page
  /// renders them; an empty list shows a tidy placeholder.
  static const List<ResearchPaper> researchPapers = [
    ResearchPaper(
      title: 'MapReduce: Simplified Data Processing on Large Clusters',
      authors: 'Dean & Ghemawat',
      venue: 'OSDI',
      year: '2004',
      category: ContentCategory.technical,
      topics: ['Distributed Systems', 'Data'],
      summary: 'The programming model that made large-scale batch processing '
          'approachable. Still the mental model behind modern data pipelines.',
      url: 'https://research.google/pubs/pub62/',
    ),
    ResearchPaper(
      title: 'In Search of an Understandable Consensus Algorithm (Raft)',
      authors: 'Ongaro & Ousterhout',
      venue: 'USENIX ATC',
      year: '2014',
      category: ContentCategory.technical,
      topics: ['Consensus', 'Replication'],
      summary: 'Consensus designed for human comprehension, and the clearest '
          'way in to how distributed systems agree under failure.',
      url: 'https://raft.github.io/raft.pdf',
    ),
    ResearchPaper(
      title: 'Dynamo: Amazon\'s Highly Available Key-value Store',
      authors: 'DeCandia et al.',
      venue: 'SOSP',
      year: '2007',
      category: ContentCategory.technical,
      topics: ['Availability', 'Storage'],
      summary: 'Trading strict consistency for always-on availability. The '
          'roots of eventual consistency and the offline-first systems I build.',
      url: 'https://www.allthingsdistributed.com/files/amazon-dynamo-sosp2007.pdf',
    ),
    ResearchPaper(
      title: 'Attention Is All You Need',
      authors: 'Vaswani et al.',
      venue: 'NeurIPS',
      year: '2017',
      category: ContentCategory.ai,
      topics: ['Transformers', 'Deep Learning'],
      summary: 'The transformer architecture behind modern LLMs. Essential '
          'context for the AI-assisted tooling I build with.',
      url: 'https://arxiv.org/abs/1706.03762',
    ),
  ];

  // ---- Footer ---------------------------------------------------------------
  static List<LinkRef> get contactLinks => [const LinkRef('Email', emailUrl), LinkRef('Phone', phoneUrl)];

  static const List<LinkRef> socialLinks = [LinkRef('GitHub', githubUrl), LinkRef('LinkedIn', linkedInUrl)];
}
