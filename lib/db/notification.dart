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
    if(json["time_type"].toString == NotificationDbTimeType.Day.toString)
      timeType = NotificationDbTimeType.Day;
    else if(json["time_type"].toString == NotificationDbTimeType.Month.toString)
      timeType = NotificationDbTimeType.Month;

    NotificationDbType dbType = NotificationDbType.Drug;
    if(json["type"].toString() == NotificationDbType.Visit.toString())
      dbType = NotificationDbType.Visit;
    else if(json["type"].toString() == NotificationDbType.Analysis.toString())
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

  static String convertTimetypeEnumsToString(NotificationDbTimeType type){
    if(type == NotificationDbTimeType.Day)
      return 'day';
    else if(type == NotificationDbTimeType.Hour)
      return 'hour';
    else
      return 'month';
  }

  static String convertTypeEnumsToString(NotificationDbType type){
    if(type == NotificationDbType.Drug)
      return 'medications';
    else if(type == NotificationDbType.Analysis)
      return 'tests';
    else
      return 'visit';
  }

  static NotificationDbTimeType convertStringToTimetypeEnums(String type){
    if(type == 'day')
      return NotificationDbTimeType.Day;
    else if(type == 'hour')
      return NotificationDbTimeType.Hour;
    else
      return NotificationDbTimeType.Month;
  }

  static NotificationDbType convertStringToTypeEnums(String type){
    if(type == 'medications')
      return NotificationDbType.Drug;
    else if(type == 'tests')
      return NotificationDbType.Analysis;
    else
      return NotificationDbType.Visit;
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
        body: {
            "data":[json.encode({
              "patient_id": userDb.id,
              "description": description,
              "datetime": datetime.toString(),
              "remind": convertTimetypeEnumsToString(time_type),
              "type": convertTypeEnumsToString(type),
            })],}
      );
      var rr = json.decode(response.body);
      return true;
    }
    catch (error) {
      throw error;
    }
  }
  static Future<bool> sendList(List<NotificationDb> list) async {
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
              "data": notificationList(list, userDb.id)
            }),
      );
      var rr = json.decode(response.body);
      return true;
    }
    catch (error) {
      throw error;
    }
  }
  static Future<bool> getList() async {
    await DBProvider.db.getUser().then((value) async {
      final url =
          Configs.ip+'api/patientmoods/'+value.id.toString();
      try {
        Map<String, String> headers = {"Content-type": "application/json","token": value.token};
        final response = await http.get(
          url,
          headers:headers,
        );
        var rr = saveListToDatabase(json.decode(response.body));
        return true;
      }
      catch (error) {
        throw error;
      }
    });
  }
  static List<NotificationDb> saveListToDatabase(var responseBody){
    List<NotificationDb> list = new List<NotificationDb>();
    for(var i in responseBody){
      NotificationDb model = new NotificationDb();

      model.datetime = i['datetime'];
      model.description = i['description'];
      model.type = convertStringToTypeEnums(i['type']);
      model.time_type = convertStringToTimetypeEnums(i['remind']);
      model.sent = 1;

      DBProvider.db.newNotification1(model);
      list.add(model);
    }
    return list;
  }

  static List<Map<String, dynamic>> notificationList(List<NotificationDb> list, int user_id) {
    List<Map<String, dynamic>> result = new List<Map<String, dynamic>>();
    for(var i in list){
      result.add({
        "patient_id": user_id,
        "description": i.description,
        "datetime": i.datetime.toString(),
        "remind": convertTimetypeEnumsToString(i.time_type),
        "type": convertTypeEnumsToString(i.type),
      });
    }
    return result;
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