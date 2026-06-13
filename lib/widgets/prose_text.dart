import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../utils/url.dart';

/// Renders a list of [ProseSpan]s as a single flowing paragraph with inline
/// accent links. Link spans underline and shift color on hover, matching the
/// restrained, prose-forward feel of the rest of the page.
class ProseText extends StatefulWidget {
  const ProseText(this.spans, {super.key, this.style});

  final List<ProseSpan> spans;

  /// Base paragraph style; defaults to [TextTheme.bodyLarge].
  final TextStyle? style;

  @override
  State<ProseText> createState() => _ProseTextState();
}

class _ProseTextState extends State<ProseText> {
  // One recognizer per link span, created once and disposed with the widget.
  final Map<int, TapGestureRecognizer> _recognizers = {};
  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.spans.length; i++) {
      final span = widget.spans[i];
      if (span.isLink) {
        _recognizers[i] = TapGestureRecognizer()
          ..onTap = () => openUrl(span.url!);
      }
    }
  }

  @override
  void dispose() {
    for (final r in _recognizers.values) {
      r.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final base = (widget.style ?? Theme.of(context).textTheme.bodyLarge!)
        .copyWith(color: palette.textSecondary);

    final children = <InlineSpan>[];
    for (var i = 0; i < widget.spans.length; i++) {
      final span = widget.spans[i];
      if (!span.isLink) {
        children.add(TextSpan(text: span.text, style: base));
        continue;
      }

      final hovered = _hoveredIndex == i;
      children.add(
        TextSpan(
          text: span.text,
          style: base.copyWith(
            color: hovered ? palette.accentHover : palette.accent,
            decoration: TextDecoration.underline,
            decorationColor: (hovered ? palette.accentHover : palette.accent)
                .withValues(alpha: hovered ? 1 : 0.45),
            decorationThickness: 1.2,
          ),
          recognizer: _recognizers[i],
          mouseCursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hoveredIndex = i),
          onExit: (_) => setState(() => _hoveredIndex = null),
        ),
      );
    }

    return Text.rich(TextSpan(children: children), style: base);
  }
}
