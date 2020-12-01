import 'dart:convert';
import 'package:HIVApp/data/configs.dart';
import 'package:http/http.dart' as http;

import 'db_provider.dart';
import 'model/user.dart';

class UserMood {
  int id;
  int sent;
  int user_id;
  String title;
  String file_name;
  DateTime date_time;


  UserMood({this.id, this.user_id, this.title, this.file_name, this.date_time, this.sent});

  factory UserMood.fromJson(Map<String, dynamic> json) => new UserMood(
      id: json["id"],
      user_id: json["user_id"],
      title: json["title"],
      file_name: json["file_name"],
      date_time: DateTime.parse(json["date_time"]),
      sent: json['sent']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": user_id,
    "title": title,
    "file_name": file_name,
    "date_time": date_time,
    "sent": sent
  };

  Map<String, dynamic> toJsonForServer() => {
    "patient_id": user_id,
    "title": title,
    "file_name": file_name,
    "date": date_time,
  };

  Future<bool> send() async {
    final url =
        Configs.ip+'api/patientmoods';
    DbUser userDb = await DBProvider.db.getUser();
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers:headers,
        body: json.encode(
            {
              "patient_id": userDb.id,
              "title": title,
              "file_name": file_name,
              "date": date_time,
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
UserMood userMoodFromJson(String str) {
  final jsonData = json.decode(str);
  return UserMood.fromJson(jsonData);
}

String userMoodToJson(UserMood data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
class UserMoodTotal{
  String file_name;
  String title;
  int count;


  UserMoodTotal({this.file_name, this.title, this.count});

  factory UserMoodTotal.fromJson(Map<String, dynamic> json) => new UserMoodTotal(
      title: json["title"],
      file_name: json["file_name"],
      count: json["count"]
  );
}