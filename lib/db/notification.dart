import 'dart:convert';

enum NotificationDbTimeType {
  Hour, Day, Month
}
enum NotificationDbType {
  Drug, Visit, Analysis
}

class NotificationDb {
  int id;
  String description;
  DateTime datetime;
  NotificationDbTimeType time_type;
  NotificationDbType type;

  NotificationDb({this.id, this.description, this.datetime, this.time_type, this.type});

  factory NotificationDb.fromJson(Map<String, dynamic> json) {
    NotificationDbTimeType timeType = NotificationDbTimeType.Hour;
    if(json["time_type"] == NotificationDbTimeType.Day.toString)
      timeType = NotificationDbTimeType.Day;
    else if(json["time_type"] == NotificationDbTimeType.Month.toString)
      timeType = NotificationDbTimeType.Month;

    NotificationDbType dbType = NotificationDbType.Drug;
    if(json["type"] == NotificationDbType.Visit.toString)
      dbType = NotificationDbType.Visit;
    else if(json["type"] == NotificationDbType.Analysis.toString)
      dbType = NotificationDbType.Analysis;
  return new NotificationDb(
      id: json["id"],
      description: json["description"],
      datetime: DateTime.parse(json['datetime']),
      time_type: timeType,
      type: dbType
  );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "datetime": datetime.toString(),
    "time_type": time_type.toString(),
    "type": type.toString(),
  };
}
NotificationDb notificationFromJson(String str) {
  final jsonData = json.decode(str);
  return NotificationDb.fromJson(jsonData);
}

String notificationToJson(NotificationDb data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}