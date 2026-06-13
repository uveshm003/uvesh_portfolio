import 'package:flutter/material.dart';

import '../sections/skills_section.dart';
import '../widgets/page_scaffold.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScaffold(
      title: 'Skills',
      lead: 'The languages, frameworks and tools I reach for.',
      child: SkillsContent(),
    );
  }
}
