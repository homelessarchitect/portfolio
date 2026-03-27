import 'package:flutter/material.dart';
import '../domain/project.dart';
import 'widgets/project_presentation_section.dart';
import 'widgets/project_story_section.dart';
import 'widgets/sticky_section_tab_bar.dart';
import 'widgets/project_design_explorer.dart';
import 'widgets/project_features_section.dart';
import 'widgets/related_projects_section.dart';
import 'widgets/project_technical_drawer.dart';

class ProjectDetailView extends StatefulWidget {
  final Project project;

  const ProjectDetailView({super.key, required this.project});

  @override
  State<ProjectDetailView> createState() => _ProjectDetailViewState();
}

class _ProjectDetailViewState extends State<ProjectDetailView> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _conceptKey = GlobalKey();
  final GlobalKey _historyKey = GlobalKey();
  final GlobalKey _problemKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _designKey = GlobalKey();

  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    int newIndex = _currentTabIndex;

    // Approximate heights for sections to determine current tab
    // Ideally we would use RenderBox to find exact positions
    final h = MediaQuery.of(context).size.height;
    final presentationHeight = h; // Hero section
    final storyHeight = h * 0.8; // Each story section

    if (offset < presentationHeight) {
      newIndex = 0;
    } else if (offset < presentationHeight + storyHeight) {
      newIndex = 0; // Concepto
    } else if (offset < presentationHeight + storyHeight * 2) {
      newIndex = 1; // Historia
    } else if (offset < presentationHeight + storyHeight * 3) {
      newIndex = 2; // Problema/Solución
    } else if (offset < presentationHeight + storyHeight * 3 + 500) {
      newIndex = 3; // Features
    } else {
      newIndex = 4; // Diseño
    }

    if (newIndex != _currentTabIndex) {
      setState(() {
        _currentTabIndex = newIndex;
      });
    }
  }

  void _scrollToSection(GlobalKey key, int index) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
      setState(() {
        _currentTabIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.project.primaryColor != null) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: widget.project.primaryColor!,
            onPrimary:
                widget.project.onPrimaryColor ??
                Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        child: Builder(builder: (themedContext) => _buildBody(themedContext)),
      );
    }
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      endDrawer: widget.project.technicalModules.isNotEmpty
          ? ProjectTechnicalDrawer(project: widget.project)
          : null,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // 1. Presentation Section
          SliverToBoxAdapter(
            child: ProjectPresentationSection(project: widget.project),
          ),

          // 2. Sticky Tab Bar
          StickySectionTabBar(
            tabs: const [
              'Concepto',
              'Historia',
              'Problema/Solución',
              'Features',
              'Diseño',
            ],
            currentIndex: _currentTabIndex,
            onTabSelected: (index) {
              switch (index) {
                case 0:
                  _scrollToSection(_conceptKey, index);
                  break;
                case 1:
                  _scrollToSection(_historyKey, index);
                  break;
                case 2:
                  _scrollToSection(_problemKey, index);
                  break;
                case 3:
                  _scrollToSection(_featuresKey, index);
                  break;
                case 4:
                  _scrollToSection(_designKey, index);
                  break;
              }
            },
          ),

          // 3. Concept Section
          SliverToBoxAdapter(
            key: _conceptKey,
            child: ProjectStorySection(
              title: 'Concepto',
              description: widget.project.concept,
              imageUrl: widget.project.conceptImageUrl,
              isLeftAligned: true,
              accentColor: widget.project.primaryColor,
            ),
          ),

          // 4. History Section
          SliverToBoxAdapter(
            key: _historyKey,
            child: ProjectStorySection(
              title: 'Historia',
              description: widget.project.storytelling,
              imageUrl: widget.project.historyImageUrl,
              isLeftAligned: false,
              accentColor: widget.project.primaryColor,
            ),
          ),

          // 5. Problem & Solution Section
          SliverToBoxAdapter(
            key: _problemKey,
            child: ProjectStorySection(
              title: 'Problema & Solución',
              description:
                  '${widget.project.problem}\n\n${widget.project.solution}',
              imageUrl: widget.project.problemSolutionImageUrl,
              isLeftAligned: true,
              accentColor: widget.project.primaryColor,
            ),
          ),

          // 6. Features Section
          SliverToBoxAdapter(
            key: _featuresKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80),
              child: ProjectFeaturesSection(project: widget.project),
            ),
          ),

          // 7. Design Explorer Section
          SliverToBoxAdapter(
            key: _designKey,
            child: ProjectDesignExplorer(project: widget.project),
          ),

          // 8. Other Projects
          SliverToBoxAdapter(
            child: RelatedProjectsSection(currentProjectId: widget.project.id),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
