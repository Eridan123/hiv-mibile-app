import 'dart:convert';

class UserMood {
  int id;
  int user_id;
  int mood_id;
  DateTime date_time;


  UserMood({this.id, this.user_id, this.mood_id, this.date_time});

  factory UserMood.fromJson(Map<String, dynamic> json) => new UserMood(
      id: json["id"],
      user_id: json["user_id"],
      mood_id: json["mood_id"],
      date_time: json["date_time"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": user_id,
    "mood_id": mood_id,
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