import 'package:flutter/material.dart';
import 'package:portfolio/models/project_model.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            project.imageUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  project.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: project.tags.map((tag) => Chip(label: Text(tag))).toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (project.githubLink != null)
                      IconButton(
                        icon: const Icon(Icons.code),
                        onPressed: () {
                          // TODO: Launch GitHub URL
                        },
                      ),
                    if (project.demoLink != null)
                      IconButton(
                        icon: const Icon(Icons.launch),
                        onPressed: () {
                          // TODO: Launch Demo URL
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}