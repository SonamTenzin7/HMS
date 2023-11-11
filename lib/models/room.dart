class Room{
  final int? id;
  final int roomno;
  final int capacity;
  final int hid;
  final String? hname;
  final String? sid;
  final String? fname;
  final String? mname;
  final String? lname;
  final String? dept;
  final String? year;
  final String? gender;

  Room({
    this.id,
    required this.roomno,
    required this.capacity,
    required this.hid,
    this.sid,
    this.hname,
    this.fname,
    this.mname,
    this.lname,
    this.dept,
    this.year,
    this.gender,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      roomno: json['roomno'],
      capacity: json['capacity'],
      hid: json['hid'],
      hname: json['name'],
      sid: json['sid'],
      fname: json['FName'],
      mname: json['MName'],
      lname: json['LName'],
      dept: json['Dept'],
      year: json['Year'],
      gender: json['Gender'],
    );
  }
}