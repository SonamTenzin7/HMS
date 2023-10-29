class Hostel {
  final int? id;
  final String name;
  final String gender;

  Hostel({
    this.id,
    required this.name,
    required this.gender,
  });

  factory Hostel.fromJson(Map<String, dynamic> json) {
    return Hostel(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
    );
  }
}
