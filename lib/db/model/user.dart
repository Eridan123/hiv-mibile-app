import 'dart:convert';

class DbUser {
  int id;
  String username;
  String password;
  int pin_code;
  String token;

  DbUser({this.id, this.username, this.password, this.token});

  factory DbUser.fromJson(Map<String, dynamic> json) => new DbUser(
    id: json["id"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}

DbUser userFromJson(String str) {
  final jsonData = json.decode(str);
  return DbUser.fromJson(jsonData);
}

String userToJson(DbUser data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}