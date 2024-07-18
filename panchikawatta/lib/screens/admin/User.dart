class User {
  final String name;
  final String email;
  final String activity;
  final UserType userType;
  final String contact;
  final String businessContact;
  final String businessName;
  final String businessDescription;
  final String? imageUrls; // Add imageUrl property

  User({
    required this.name,
    required this.email,
    required this.activity,
    required this.userType,
    required this.contact,
    required this.businessContact,
    required this.businessName,
    required this.businessDescription,
    required this.imageUrls, // Initialize imageUrl
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      activity: json['activity'] ?? '',
      userType: UserType.values.firstWhere(
          (e) => e.toString() == 'UserType.' + (json['userType'] ?? 'buyer')),
      contact: json['contact'] ?? '',
      businessContact: json['businessContact'] ?? '',
      businessName: json['businessName'] ?? '',
      businessDescription: json['businessDescription'] ?? '',
      imageUrls: json['imageUrl'], // Ensure imageUrl is correctly parsed
    );
  }

  get id => null;

  toJson() {}
}

enum UserType {
  buyer,
  seller,
}
