import 'package:flutter/material.dart';

import '../sections/research_section.dart';
import '../widgets/page_scaffold.dart';

/// Research - papers worth reading, grouped by category. Its own page so it
/// stands apart from the day-to-day reading list.
class ResearchPage extends StatelessWidget {
  const ResearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScaffold(
      title: 'Research',
      lead: 'Papers that shaped how I think about systems, data, and the AI '
          'tooling I build with.',
      child: ResearchPapersContent(),
    );
  }
}
