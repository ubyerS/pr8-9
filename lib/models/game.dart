class Game {
  final String name;
  final String description;
  final double price;
  final String? imagePath;
  final String? imageFilePath;

  Game({
    required this.name,
    required this.description,
    required this.price,
    this.imagePath,
    this.imageFilePath,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] is int ? (json['price'] as int).toDouble() : json['price']) ?? 0.0,
      imagePath: json['imagePath'],
      imageFilePath: json['imageFilePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imagePath': imagePath,
      'imageFilePath': imageFilePath,
    };
  }

  String get effectiveImagePath => imageFilePath ?? imagePath ?? 'assets/default_image.png';
}

