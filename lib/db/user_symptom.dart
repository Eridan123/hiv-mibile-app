import 'dart:convert';

class UserSymptom {
  int id;
  int user_id;
  String title;
  String file_name;
  DateTime date_time;
  double rating;


  UserSymptom({this.id, this.user_id, this.title, this.file_name, this.date_time, this.rating});

  factory UserSymptom.fromJson(Map<String, dynamic> json) => new UserSymptom(
      id: json["id"],
      user_id: json["user_id"],
      title: json["title"],
      file_name: json["file_name"],
      date_time: DateTime.parse(json["date_time"]),
      rating: json['rating']
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": user_id,
    "title": title,
    "file_name": file_name,
    "date_time": date_time,
    "rating": rating,
  };
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