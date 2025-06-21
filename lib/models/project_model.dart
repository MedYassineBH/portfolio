class Project {
  final String title;
  final String description;
  final List<String> tech;
  final String? imageUrl;
  final String? githubUrl;
  final String imageAsset;

  Project({
    required this.title,
    required this.description,
    required this.tech,
    required this.imageAsset,
    this.imageUrl,
    this.githubUrl,
  });
}
