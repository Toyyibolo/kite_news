class Category {
  final String name;
  final String file;

  Category({required this.name, required this.file});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      file: json['file'],
    );
  }
}
