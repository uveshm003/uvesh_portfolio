import 'package:flutter/material.dart';

import '../sections/education_section.dart';
import '../sections/hero_section.dart';
import '../theme/app_spacing.dart';
import '../widgets/mini_heading.dart';
import '../widgets/page_scaffold.dart';

/// Home - the landing page: the prose hero/intro, followed by a quiet
/// Education block. No page title; the name in the hero is the heading.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScaffold(
      topGap: AppSpacing.huge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroContent(),
          SizedBox(height: AppSpacing.huge),
          MiniHeading('Education'),
          SizedBox(height: AppSpacing.lg),
          EducationContent(),
        ],
      ),
    );
  }
}
