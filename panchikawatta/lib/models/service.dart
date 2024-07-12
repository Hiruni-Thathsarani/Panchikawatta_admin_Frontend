class Service {
  final int id;
  final String title;
  final String description;
  String imageUrl;

  Service({
    required this.id,
    required this.title,
    required this.description,
    String? imageUrl,
  }) : imageUrl = imageUrl ?? 'no_image.png';

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown',
      description: json['description'] ?? 'No description',
      imageUrl: json['imageUrl'] ?? 'No image',
    );
  }
}
