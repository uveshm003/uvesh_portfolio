import 'package:flutter/material.dart';

import '../sections/education_section.dart';
import '../sections/featured_work_section.dart';
import '../sections/hero_section.dart';
import '../theme/app_spacing.dart';
import '../widgets/mini_heading.dart';
import '../widgets/page_scaffold.dart';

/// Home — the landing page: the statement hero/intro, the marquee featured work,
/// then a quiet Education block. No page title; the hero serves as the heading.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScaffold(
      topGap: AppSpacing.xxl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroContent(),
          SizedBox(height: AppSpacing.xxxl),
          MiniHeading('Featured Work'),
          SizedBox(height: AppSpacing.lg),
          FeaturedWorkContent(),
          SizedBox(height: AppSpacing.xxxl),
          MiniHeading('Education'),
          SizedBox(height: AppSpacing.lg),
          EducationContent(),
        ],
      ),
    );
  }
}
