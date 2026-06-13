import 'package:flutter/material.dart';

import '../sections/education_section.dart';
import '../sections/experience_section.dart';
import '../sections/footer_section.dart';
import '../sections/hero_section.dart';
import '../sections/projects_section.dart';
import '../sections/skills_section.dart';
import '../theme/theme_controller.dart';
import '../widgets/top_nav.dart';

/// The single scrolling page. Owns the scroll controller and the anchor keys
/// the nav scrolls to, and lays the sections out top to bottom.
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.controller});

  final ThemeController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  // Anchor targets for the nav's section links.
  final _experienceKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _skillsKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Smoothly brings a keyed section to the top of the viewport (offset for the
  /// sticky nav). Used by both desktop links and the mobile menu.
  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return;
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeInOutCubic,
      alignment: 0.02,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 480),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final sections = <SectionTarget>[
      (label: 'Experience', onTap: () => _scrollTo(_experienceKey)),
      (label: 'Projects', onTap: () => _scrollTo(_projectsKey)),
      (label: 'Skills', onTap: () => _scrollTo(_skillsKey)),
    ];

    return Scaffold(
      body: Column(
        children: [
          TopNav(
            sections: sections,
            onHome: _scrollToTop,
            controller: widget.controller,
          ),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    const HeroSection(),
                    ExperienceSection(anchorKey: _experienceKey),
                    ProjectsSection(anchorKey: _projectsKey),
                    SkillsSection(anchorKey: _skillsKey),
                    const EducationSection(),
                    const FooterSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
