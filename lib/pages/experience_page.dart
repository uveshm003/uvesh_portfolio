import 'package:flutter/material.dart';

import '../sections/experience_section.dart';
import '../widgets/page_scaffold.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScaffold(
      title: 'Experience',
      lead: 'Three-plus years shipping cross-platform products - from '
          'delivery robots to enterprise device tooling.',
      child: ExperienceContent(),
    );
  }
}
