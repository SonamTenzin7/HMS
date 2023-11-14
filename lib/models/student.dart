class Student{
  final String id;
  final String fname;
  final String? mname;
  final String? lname;
  final String dept;
  final String year;
  final String password;
  final String gender;
  final int? hosId;
  final int? rId;

  Student({
    required this.id,
    required this.fname,
    this.mname,
    this.lname,
    required this.dept,
    required this.year,
    required this.password,
    required this.gender,
    this.hosId,
    this.rId,
  });

   factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      fname: json['FName'],
      mname: json['MName'],
      lname: json['LName'],
      dept: json['Dept'],
      year: json['Year'],
      password: json['password'],
      gender: json['Gender'],
      hosId: json['hosId'],
      rId: json['rid'],
    );
  }
}