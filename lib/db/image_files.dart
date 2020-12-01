import 'dart:convert';

import 'package:HIVApp/data/configs.dart';
import 'package:http/http.dart' as http;
import 'dart:io' as Io;

import 'db_provider.dart';
import 'model/user.dart';

class UserImageFile {
  int id;
  int sent;
  int user_id;
  int type;
  String path;
  String file_name;
  DateTime date_time;


  UserImageFile({this.id, this.user_id, this.path, this.file_name, this.type, this.date_time, this.sent});

  factory UserImageFile.fromJson(Map<String, dynamic> json) => new UserImageFile(
      id: json["id"],
      user_id: json["user_id"],
      path: json["path"],
      type: json["type"],
      file_name: json["file_name"],
      date_time: DateTime.parse(json["date_time"]),
      sent: json["sent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": user_id,
    "path": path,
    "type": type,
    "file_name": file_name,
    "date_time": date_time,
    "sent": sent
  };

  Map<String, dynamic> toJsonForServer(int id) => {
    "patient_id": id,
    "type": convertTypeToString(type),
    "img_base_64": imageToBase64(path),
    "date": date_time,
  };

  imageToBase64(String filePath){
    final bytes = Io.File(filePath).readAsBytesSync();
    String base64Encode(List<int> bytes) => base64.encode(bytes);
    return base64Encode(bytes);
  }

  Future<bool> send() async {
    final url =
        Configs.ip+'api/patientresultimages';
    DbUser userDb = await DBProvider.db.getUser();
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers:headers,
        body: json.encode(
            {
              "patient_id": userDb.id,
              "type": convertTypeToString(type),
              "img_base_64": file_name,
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

  String convertTypeToString(int type){
    if(type ==1)
      return "doctors_appointment";
    else
      return "test_result";
  }
}
UserImageFile userImageFileFromJson(String str) {
  final jsonData = json.decode(str);
  return UserImageFile.fromJson(jsonData);
}

String userImageFileToJson(UserImageFile data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}