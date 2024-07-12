// models/province.dart
class Province {
  final String province;

  Province({required this.province});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      province: json['province'],
    );
  }
}
