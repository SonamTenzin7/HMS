class Maintenance{
  final int id;
  final int roomid;
  final String studentid;
  final DateTime date;
  final String description;
  final String status;
  final int? roomno;
  final String? hostel;

  Maintenance({
    required this.id,
    required this.roomid,
    required this.studentid,
    required this.date,
    required this.description,
    required this.status,
    this.roomno,
    this.hostel,
  });

   factory Maintenance.fromJson(Map<String, dynamic> json) {
    return Maintenance(
      id: json['id'],
      roomid: json['roomId'],
      studentid: json['studentId'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      status: json['status'],
      roomno: json['roomno'],
      hostel: json['name'],
    );
  }
}