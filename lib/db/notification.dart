import 'dart:convert';

import '../data/configs.dart';
import 'package:http/http.dart' as http;
import 'mother.dart';
import 'model/user.dart';
import 'db_provider.dart';

enum NotificationDbTimeType {
  Hour, Day, Month
}
enum NotificationDbType {
  Drug, Visit, Analysis
}

class NotificationDb {
  int id;
  int sent;
  String description;
  DateTime datetime;
  NotificationDbTimeType time_type;
  NotificationDbType type;

  NotificationDb({this.id, this.description, this.datetime, this.time_type, this.type, this.sent});

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
      type: dbType,
      sent: json['sent']
  );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "datetime": datetime.toString(),
    "time_type": time_type.toString(),
    "type": type.toString(),
    "sent": sent
  };

  Map<String, dynamic> toJsonForServer() => {
    "patient_id": id,
    "description": description,
    "datetime": datetime.toString(),
    "remind": convertTimetypeEnumsToString(time_type),
    "type": convertTypeEnumsToString(type),
  };

  String convertTimetypeEnumsToString(NotificationDbTimeType type){
    if(type == NotificationDbTimeType.Day)
      return 'day';
    else if(type == NotificationDbTimeType.Hour)
      return 'hour';
    else
      return 'month';
  }

  String convertTypeEnumsToString(NotificationDbType type){
    if(type == NotificationDbType.Drug)
      return 'medications';
    else if(type == NotificationDbType.Analysis)
      return 'tests';
    else
      return 'visit';
  }

  Future<bool> send() async {
    final url =
        Configs.ip+'api/notifications';
    DbUser userDb = await DBProvider.db.getUser();
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers:headers,
        body: json.encode(
            {
              "patient_id": userDb.id,
              "description": description,
              "datetime": datetime.toString(),
              "remind": convertTimetypeEnumsToString(time_type),
              "type": convertTypeEnumsToString(type),
            }),
      );
      var rr = json.decode(response.body);
      return true;
    }
    catch (error) {
      throw error;
    }
  }
}
NotificationDb notificationFromJson(String str) {
  final jsonData = json.decode(str);
  return NotificationDb.fromJson(jsonData);
}

String notificationToJson(NotificationDb data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}