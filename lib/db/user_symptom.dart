import 'dart:convert';

import 'package:HIVApp/data/configs.dart';
import 'package:http/http.dart' as http;

import 'db_provider.dart';
import 'model/user.dart';

class UserSymptom {
  int id;
  int sent;
  int user_id;
  String title;
  String file_name;
  DateTime date_time;
  double rating;


  UserSymptom({this.id, this.user_id, this.title, this.file_name, this.date_time, this.rating, this.sent});

  factory UserSymptom.fromJson(Map<String, dynamic> json) => new UserSymptom(
      id: json["id"],
      user_id: json["user_id"],
      title: json["title"],
      file_name: json["file_name"],
      date_time: DateTime.parse(json["date_time"]),
      rating: json['rating'],
      sent: json['sent']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": user_id,
    "title": title,
    "file_name": file_name,
    "date_time": date_time,
    "rating": rating,
    "sent": sent,
  };

  Future<bool> send() async {
    final url =
        Configs.ip+'api/patientsymptoms';
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
              "level": rating,
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
UserSymptom userSymptomFromJson(String str) {
  final jsonData = json.decode(str);
  return UserSymptom.fromJson(jsonData);
}

String userSymptomToJson(UserSymptom data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class UserSymptomTotal{
  String file_name;
  String title;
  int count;


  UserSymptomTotal({this.file_name, this.title, this.count});

  factory UserSymptomTotal.fromJson(Map<String, dynamic> json) => new UserSymptomTotal(
      title: json["title"],
      file_name: json["file_name"],
      count: json["count"]
  );
}