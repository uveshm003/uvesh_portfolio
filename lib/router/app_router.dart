import 'package:go_router/go_router.dart';

import '../pages/home_page.dart';
import '../pages/not_found_page.dart';
import '../theme/theme_controller.dart';

/// Routing config. A single home route plus a catch-all 404. Kept here so
/// adding deep-linkable routes later is a one-line change.
GoRouter buildRouter(ThemeController controller) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => HomePage(controller: controller),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );
}
