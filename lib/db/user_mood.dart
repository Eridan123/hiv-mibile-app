import 'dart:convert';

class UserMood {
  int id;
  int user_id;
  String title;
  String file_name;
  DateTime date_time;


  UserMood({this.id, this.user_id, this.title, this.file_name, this.date_time});

  factory UserMood.fromJson(Map<String, dynamic> json) => new UserMood(
      id: json["id"],
      user_id: json["user_id"],
      title: json["title"],
      file_name: json["file_name"],
      date_time: DateTime.parse(json["date_time"])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": user_id,
    "title": title,
    "file_name": file_name,
    "date_time": date_time,
  };
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