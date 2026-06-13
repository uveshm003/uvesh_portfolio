import 'package:flutter/material.dart';

import '../sections/projects_section.dart';
import '../widgets/page_scaffold.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScaffold(
      title: 'Projects',
      lead: 'A selection of work across mobile, desktop, robotics and '
          'offline-first apps.',
      child: ProjectsContent(),
    );
  }
}
