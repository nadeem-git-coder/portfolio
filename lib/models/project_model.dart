class ProjectModel {
  final String title;
  final String description;
  final List<String> tags;
  final String? githubLink;
  final String? demoLink;
  final String imageUrl;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.tags,
    this.githubLink,
    this.demoLink,
    required this.imageUrl,
  });
}