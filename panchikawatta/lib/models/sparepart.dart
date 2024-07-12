class SparePart {
  final int id;
  final String title;
  final String description;
  String imageUrl;
  final int price;
  final String make;
  final String model;
  final String origin;
  final String condition;
  final String fuel;
  final int year;

  SparePart({
    required this.id,
    required this.title,
    required this.description,
    String? imageUrl,
    required this.price,
    required this.make,
    required this.model,
    required this.origin,
    required this.condition,
    required this.fuel,
    required this.year,
  }) : imageUrl = imageUrl ?? 'assets/images/no_image.png';

  factory SparePart.fromJson(Map<String, dynamic> json) {
    return SparePart(
      id: json['sparePartId'] ?? 0,
      title: json['title'] ?? 'Unknown',
      description: json['description'] ?? 'No description',
      imageUrl: json['imageUrl'] ?? 'assets/images/no_image.png',
      price: json['price'] ?? 0,
      make: json['make'] ?? 'Unknown',
      model: json['model'] ?? 'Unknown',
      origin: json['origin'] ?? 'Unknown',
      condition: json['condition'] ?? 'Unknown',
      fuel: json['fuel'] ?? 'Unknown',
      year: json['year'] ?? 0,
    );
  }
}
