import 'package:flutter/material.dart';

import '../sections/blog_section.dart';
import '../widgets/page_scaffold.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScaffold(
      title: 'Blog',
      lead: 'Thoughts on engineering, cross-platform development and the '
          'occasional deep dive.',
      child: BlogContent(),
    );
  }
}
