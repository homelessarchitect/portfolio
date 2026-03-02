class Project {
  final String id;
  final String title;
  final String description;
  final String imageUrl; // Placeholder for now
  final List<String> tags;
  final String? demoUrl;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.tags,
    this.demoUrl,
  });
}
