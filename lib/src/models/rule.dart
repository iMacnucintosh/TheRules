class Rule {
  Rule({
    required this.imagePath,
    required this.name,
    required this.description,
    this.enabled = false,
  });

  String imagePath;
  String name;
  String description;
  bool enabled;
}
