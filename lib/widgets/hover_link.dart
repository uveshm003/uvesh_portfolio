import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/url.dart';

/// A standalone text link with a subtle hover treatment: an animated underline
/// and a shift to the accent-hover color. Used in the nav bar, footer and
/// anywhere a tappable label appears outside a prose paragraph.
class HoverLink extends StatefulWidget {
  const HoverLink({
    super.key,
    required this.label,
    this.url,
    this.onTap,
    this.style,
    this.baseColor,
    this.showUnderlineWhenIdle = false,
  });

  /// External destination. Either [url] or [onTap] should be provided.
  final String? url;

  /// In-page action (e.g. anchor scroll) used when there is no [url].
  final VoidCallback? onTap;

  final String label;
  final TextStyle? style;

  /// Idle color; defaults to the secondary prose color.
  final Color? baseColor;

  /// When true an underline is always shown (used for footer links).
  final bool showUnderlineWhenIdle;

  @override
  State<HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<HoverLink> {
  bool _hovered = false;

  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap!();
    } else if (widget.url != null) {
      openUrl(widget.url!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final base = widget.baseColor ?? palette.textSecondary;
    final color = _hovered ? palette.accent : base;
    final style = (widget.style ?? Theme.of(context).textTheme.bodyMedium!)
        .copyWith(color: color);

    final showUnderline = _hovered || widget.showUnderlineWhenIdle;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: _handleTap,
        behavior: HitTestBehavior.opaque,
        child: Semantics(
          link: true,
          label: widget.label,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.label, style: style),
              // Animated underline that grows in on hover.
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                curve: Curves.easeOut,
                margin: const EdgeInsets.only(top: 2),
                height: 1,
                width: showUnderline ? _approxTextWidth(style) : 0,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Rough width estimate for the underline so it tracks the label without a
  /// layout pass. Good enough for short nav/footer labels.
  double _approxTextWidth(TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: widget.label, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    return painter.width;
  }
}
