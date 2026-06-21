import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/blog_page.dart';
import '../pages/books_page.dart';
import '../pages/experience_page.dart';
import '../pages/home_page.dart';
import '../pages/not_found_page.dart';
import '../pages/projects_page.dart';
import '../pages/research_page.dart';
import '../pages/skills_page.dart';
import '../theme/theme_controller.dart';
import '../widgets/app_shell.dart';

/// Routing config. Every section is its own page, wrapped in a shared
/// [AppShell] (sticky nav + footer) via a [ShellRoute]. Pages cross-fade on
/// navigation. Unknown paths fall through to a 404.
GoRouter buildRouter(ThemeController controller) {
  // Helper: wrap a page in a short cross-fade so route changes feel calm.
  Page<void> faded(Widget child, GoRouterState state) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, secondary, child) =>
          FadeTransition(opacity: animation, child: child),
    );
  }

  return GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) =>
            AppShell(controller: controller, child: child),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (c, s) => faded(const HomePage(), s),
          ),
          GoRoute(
            path: '/experience',
            pageBuilder: (c, s) => faded(const ExperiencePage(), s),
          ),
          GoRoute(
            path: '/projects',
            pageBuilder: (c, s) => faded(const ProjectsPage(), s),
          ),
          GoRoute(
            path: '/skills',
            pageBuilder: (c, s) => faded(const SkillsPage(), s),
          ),
          GoRoute(
            path: '/blog',
            pageBuilder: (c, s) => faded(const BlogPage(), s),
          ),
          GoRoute(
            path: '/books',
            pageBuilder: (c, s) => faded(const BooksPage(), s),
          ),
          GoRoute(
            path: '/research',
            pageBuilder: (c, s) => faded(const ResearchPage(), s),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
