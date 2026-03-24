import 'package:flutter/material.dart';
import '../domain/project.dart';
import 'widgets/project_presentation_section.dart';
import 'widgets/project_narrative_section.dart';
import 'widgets/project_design_explorer.dart';
import 'widgets/project_features_section.dart';
import 'widgets/related_projects_section.dart';
import 'widgets/project_technical_drawer.dart';

class ProjectDetailView extends StatelessWidget {
  final Project project;

  const ProjectDetailView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    if (project.primaryColor != null) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: project.primaryColor!,
            onPrimary: project.onPrimaryColor ?? Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        child: Builder(
          builder: (themedContext) => _buildBody(themedContext),
        ),
      );
    }
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      endDrawer: project.technicalModules.isNotEmpty 
          ? ProjectTechnicalDrawer(project: project) 
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Presentation Section
            ProjectPresentationSection(project: project),

            // 2. Problem + Solution (Storytelling)
            ProjectNarrativeSection(project: project),
            const SizedBox(height: 80),

            // 3. Features
            ProjectFeaturesSection(project: project),
            const SizedBox(height: 80),

            // 4. Design Explorer
            ProjectDesignExplorer(project: project),

            // 5. Other Projects
            RelatedProjectsSection(currentProjectId: project.id),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
