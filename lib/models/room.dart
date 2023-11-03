class Room{
  final int id;
  final int roomno;
  final int capacity;
  final int hid;

  Room({
    required this.id,
    required this.roomno,
    required this.capacity,
    required this.hid,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['roomno'],
      roomno: json['roomno'],
      capacity: json['capacity'],
      hid: json['hid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomno': roomno,
      'capacity': capacity,
      'hid': hid,
    };
  }
}