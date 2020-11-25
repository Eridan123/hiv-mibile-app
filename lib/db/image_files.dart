import 'dart:convert';

class UserImageFile {
  int id;
  int user_id;
  int type;
  String path;
  String file_name;
  DateTime date_time;


  UserImageFile({this.id, this.user_id, this.path, this.file_name, this.type, this.date_time});

  factory UserImageFile.fromJson(Map<String, dynamic> json) => new UserImageFile(
      id: json["id"],
      user_id: json["user_id"],
      path: json["path"],
      type: json["type"],
      file_name: json["file_name"],
      date_time: DateTime.parse(json["date_time"])
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": user_id,
    "path": path,
    "type": type,
    "file_name": file_name,
    "date_time": date_time,
  };
}
UserImageFile userImageFileFromJson(String str) {
  final jsonData = json.decode(str);
  return UserImageFile.fromJson(jsonData);
}

String userImageFileToJson(UserImageFile data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}