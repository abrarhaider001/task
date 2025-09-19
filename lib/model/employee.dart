class Employee {
  final String id;
  final int accessLevel;
  final String room;
  final DateTime requestTime;

  Employee({
    required this.id,
    required this.accessLevel,
    required this.room,
    required this.requestTime,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      accessLevel: json['access_level'],
      room: json['room'],
      requestTime: _parseTime(json['request_time']),
    );
  }

  static DateTime _parseTime(String timeString) {
    final parts = timeString.split(':');
    return DateTime(2025, 1, 1, int.parse(parts[0]), int.parse(parts[1]));
  }
}
