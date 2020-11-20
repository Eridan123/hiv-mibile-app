import 'dart:convert';

class UserSymptom {
  int id;
  int user_id;
  int symptom_id;
  DateTime date_time;


  UserSymptom({this.id, this.user_id, this.symptom_id, this.date_time});

  factory UserSymptom.fromJson(Map<String, dynamic> json) => new UserSymptom(
      id: json["id"],
      user_id: json["user_id"],
      symptom_id: json["symptom_id"],
      date_time: json["date_time"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": user_id,
    "symptom_id": symptom_id,
    "date_time": date_time,
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