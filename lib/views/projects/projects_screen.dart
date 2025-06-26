import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:portfolio/models/project_model.dart';
import 'package:portfolio/widgets/project_card.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'E-Commerce App',
      description: 'A cross-platform shopping app built with Flutter and Firebase.',
      tags: ['Flutter', 'Firebase', 'Dart'],
      githubLink: 'https://github.com',
      demoLink: 'https://example.com',
      // imageUrl: 'https://via.placeholder.com/300x200',
    ),
    ProjectModel(
      title: 'ML Predictor',
      description: 'A machine learning model deployed with Flask and AWS.',
      tags: ['Python', 'Scikit-learn', 'AWS'],
      githubLink: 'https://github.com',
      // imageUrl: 'https://via.placeholder.com/300x200',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: projects.length,
          itemBuilder:  (context, index) {
        return ProjectCard(project: projects[index])
            .animate()
            .fadeIn(duration: 600.ms, delay: (index * 200).ms);
        },
        ),
      ),
    );
  }
}