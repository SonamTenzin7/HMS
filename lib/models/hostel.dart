class Hostel {
  final int? id;
  final String name;
  final String gender;
  final String? fname;
  final String? mname;
  final String? lname;
  final String? count;

  Hostel({
    this.id,
    required this.name,
    required this.gender,
    this.fname,
    this.mname,
    this.lname,
    this.count,
  });

  factory Hostel.fromJson(Map<String, dynamic> json) {
    return Hostel(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      fname: json['FName'],
      mname: json['MName'],
      lname: json['LName'],
      count: json['allocated_count'],
    );
  }
}
