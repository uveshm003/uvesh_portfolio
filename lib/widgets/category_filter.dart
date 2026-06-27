import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_spacing.dart';
import '../theme/app_theme.dart';
import '../theme/app_typography.dart';

/// The catch-all chip label shown first in every filter row.
const String kAllCategory = 'All';

/// Builds the chip list for a set of content categories: [kAllCategory] first,
/// then the distinct categories in first-seen order.
List<String> buildCategoryChips(Iterable<String> categories) {
  final seen = <String>[];
  for (final c in categories) {
    if (!seen.contains(c)) seen.add(c);
  }
  return [kAllCategory, ...seen];
}

/// The chip selected on first paint: "Technical" when the list offers it,
/// otherwise the catch-all "All". Keeps the default consistent across sections.
String defaultCategory(List<String> chips) =>
    chips.contains(ContentCategory.technical) ? ContentCategory.technical : kAllCategory;

/// A horizontal row of selectable category chips.
class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({
    super.key,
    required this.chips,
    required this.selected,
    required this.onChanged,
  });

  final List<String> chips;
  final String selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        for (final c in chips)
          _FilterChip(
            label: c,
            selected: c == selected,
            onTap: () => onChanged(c),
          ),
      ],
    );
  }
}

class _FilterChip extends StatefulWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final palette = AppPalette.of(context);
    final selected = widget.selected;
    final textColor = selected
        ? palette.accent
        : _hovered
        ? palette.textPrimary
        : palette.textSecondary;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Semantics(
          button: true,
          selected: selected,
          label: widget.label,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm + 2, vertical: AppSpacing.xs - 1),
            decoration: BoxDecoration(
              color: selected
                  ? palette.accentSoft
                  : _hovered
                  ? palette.surface
                  : palette.surface.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: selected ? palette.accent.withValues(alpha: 0.55) : palette.divider,
              ),
            ),
            child: Text(
              widget.label,
              style: AppTypography.tag(textColor).copyWith(
                fontSize: 12.5,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A section that renders a [CategoryFilterBar] over [items] and rebuilds its
/// body with only the items in the selected category. Starts on
/// [defaultCategory] (Technical when available). When the chosen category is
/// momentarily empty it shows [emptyMessage].
class CategoryFilteredList<T> extends StatefulWidget {
  const CategoryFilteredList({
    super.key,
    required this.items,
    required this.categoryOf,
    required this.builder,
    required this.emptyMessage,
  });

  final List<T> items;
  final String Function(T item) categoryOf;

  /// Builds the body from the filtered items (e.g. a column of cards).
  final Widget Function(BuildContext context, List<T> filtered) builder;

  /// Shown when the selected category currently has no items.
  final Widget emptyMessage;

  @override
  State<CategoryFilteredList<T>> createState() => _CategoryFilteredListState<T>();
}

class _CategoryFilteredListState<T> extends State<CategoryFilteredList<T>> {
  late List<String> _chips;
  late String _selected;

  @override
  void initState() {
    super.initState();
    _chips = buildCategoryChips(widget.items.map(widget.categoryOf));
    _selected = defaultCategory(_chips);
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _selected == kAllCategory
        ? widget.items
        : widget.items.where((i) => widget.categoryOf(i) == _selected).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // A single category offers no real choice - skip the bar entirely.
        if (_chips.length > 2) ...[
          CategoryFilterBar(
            chips: _chips,
            selected: _selected,
            onChanged: (c) => setState(() => _selected = c),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
        // AnimatedSwitcher gives a soft cross-fade as the filter changes.
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          layoutBuilder: (current, previous) => Align(
            alignment: Alignment.topLeft,
            child: current ?? const SizedBox.shrink(),
          ),
          child: KeyedSubtree(
            key: ValueKey(_selected),
            child: filtered.isEmpty ? widget.emptyMessage : widget.builder(context, filtered),
          ),
        ),
      ],
    );
  }
}
