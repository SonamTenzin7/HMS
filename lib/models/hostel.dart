class Hostel {
  final int? id;
  final String name;
  final String gender;
  final String? fname;
  final String? mname;
  final String? lname;

  Hostel({
    this.id,
    required this.name,
    required this.gender,
    this.fname,
    this.mname,
    this.lname,
  });

  factory Hostel.fromJson(Map<String, dynamic> json) {
    return Hostel(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      fname: json['FName'],
      mname: json['MName'],
      lname: json['LName'],
    );
  }
}
