import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens [url] in a new tab/window (web) or the platform handler (desktop).
/// Silently no-ops on malformed URLs so a bad link never crashes the page.
Future<void> openUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  try {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: kIsWeb ? '_blank' : null,
    );
  } catch (_) {
    // Swallow - opening an external link should never throw to the UI.
  }
}
