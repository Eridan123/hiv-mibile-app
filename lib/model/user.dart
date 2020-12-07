import 'dart:convert';

import 'package:HIVApp/data/configs.dart';
import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/db/db_provider.dart';
import 'package:HIVApp/db/model/user.dart';
import 'package:HIVApp/db/user_mood.dart';
import 'package:HIVApp/db/user_symptom.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'auth.dart';
import 'http_exceptions.dart';

class User extends ChangeNotifier{

  int user_id;
  String username;
  String password;
  int first_question;
  String first_question_answer;
  int second_question;
  String second_question_answer;
  int gender;
  bool intersex;
  int sex;
  int birth_year;
  int pin_code;
  String token;


  Future<void> create() async {
    final url =
        Configs.ip+'api/users';
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers:headers,
        body: json.encode(
            userRequestBodyToJson(this)
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 999) {
        throw HttpException(responseData['status'].toString());
      }
      else if (responseData['status'] == 888) {
        throw HttpException(responseData['status'].toString());
      }
      else if(responseData['token'] != null) {
//        Prefs.setString(Prefs.TOKEN, responseData['token']);
//        Prefs.setInt(Prefs.USER_ID, responseData["id"]);
//        Prefs.setString(Prefs.USERNAME, username);
//        Prefs.setString('password', password);

        this.token = responseData['token'];
        this.token = responseData['token'];
        this.user_id = responseData['id'];

        await DBProvider.db.deleteAllUsers();
        DbUser dbUser = new DbUser();
        dbUser.username = username;
        dbUser.password = password;
        dbUser.token = responseData['token'];
        dbUser.id = responseData['id'];
        await DBProvider.db.newUser(dbUser);
        notifyListeners();
      }
    }
    catch (error) {
      throw error;
    }
  }

  Map<String, dynamic> userRequestBodyToJson(User user) =>
      {
        'username': user.username,
        'password': user.password,
        'question_id1': user.first_question,
        'answer1': user.first_question_answer,
        'question_id2': user.second_question,
        'answer2': user.second_question_answer,
        'gender_id': user.gender,
        'sex_id': user.sex,
        'intersex': user.intersex,
        'year_of_birth': user.birth_year,
        'pin_kod': user.pin_code,
      };

  bool get isAuth {
    return token != null;
  }

  Future<void> _authenticate(
      String username, String password) async {
    final url =
        Configs.ip+'api/login';
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers:headers,
        body: json.encode(
            loginRequestBodyToJson(username, password)
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 999) {
        throw HttpException(responseData['status'].toString());
      }
      else if (responseData['status'] == 888) {
        throw HttpException(responseData['status'].toString());
      }
      else if(responseData['token'] != null) {
        this.username = username;
        this.password = password;
        Prefs.setString('username', username);
        Prefs.setString('password', password);
        Prefs.setString(Prefs.USERNAME, username);
        Prefs.setString(Prefs.PASSWORD, password);
        Prefs.setString(Prefs.TOKEN, responseData["token"]);
        Prefs.setInt(Prefs.USER_ID, responseData["id"]);

        DbUser dbUser = new DbUser();
        dbUser.username = username;
        dbUser.password = password;
        dbUser.token = responseData['token'];
        dbUser.pin_code = responseData['pin_kod'];
        dbUser.id = responseData['id'];
        await DBProvider.db.newUser(dbUser);
        UserMood.getList();
        UserSymptom.getList();

        this.user_id = responseData["id"];
        this.token = responseData["token"];
        notifyListeners();
      }
    }
    catch (error) {
      throw error;
    }
  }

  Future<bool> checkUsername(String username) async {
    final url =
        Configs.ip+'api/userexist';
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers:headers,
        body: json.encode(
            {
              'username': username,
            }
        ),
      );
      return json.decode(response.body);
    }
    catch (error) {
      throw error;
    }
  }


  Future<void> login(String email, String password) async {
    return _authenticate(email, password);
  }

  Future<void> setPinCode(String pinCode) async {
    DbUser user = await DBProvider.db.getUser();
    final url =
        Configs.ip+'api/set_pin_kod/'+ user.id.toString();
    try {
      Map<String, String> headers = {"Content-type": "application/json","token": user.token};
      final response = await http.post(
        url,
        headers:headers,
        body: json.encode(
            {"pin_kod": pinCode}),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 999) {
        throw HttpException(responseData['status'].toString());
      }
      else if (responseData['status'] == 888) {
        throw HttpException(responseData['status'].toString());
      }
      else if(responseData['token'] != null) {
        Prefs.setString('pin_code', pinCode);
        this.pin_code = int.parse(pinCode);
        DbUser dbUser = await DBProvider.db.getUser();
        dbUser.pin_code = pinCode;
        await DBProvider.db.updateUser(dbUser);
        notifyListeners();
      }
    }
    catch (error) {
      throw error;
    }
  }

  Future<void> setPassword(String password) async {
    final url =
        Configs.ip+'api/change-password/'+ Prefs.getInt(Prefs.USER_ID).toString();
    try {
      Map<String, String> headers = {"Content-type": "application/json","token": Prefs.getString(Prefs.TOKEN)};
      final response = await http.put(
        url,
        headers:headers,
        body: json.encode(
            {"new_password": password}),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 999) {
        throw HttpException(responseData['status'].toString());
      }
      else if (responseData['status'] == 888) {
        throw HttpException(responseData['status'].toString());
      }
      else if(responseData['token'] != null) {
        Prefs.setString(Prefs.PASSWORD, password);
        Prefs.setInt(Prefs.USER_ID, responseData['id']);
        Prefs.setString(Prefs.TOKEN, responseData['token']);
        this.password = password;

//        DbUser dbUser = await DBProvider.db.getUser();
//        dbUser.password = password;
//        dbUser.token = responseData['token'];
//        await DBProvider.db.updateUser(dbUser);

        notifyListeners();
      }
    }
    catch (error) {
      throw error;
    }
  }

  Future<void> resetPassword(User user) async {
    final url =
        Configs.ip+'api/resetpassword/';
    try {
      Map<String, String> headers = {"Content-type": "application/json","token": Prefs.getString(Prefs.TOKEN)};
      final response = await http.post(
        url,
        headers:headers,
        body: json.encode(
            {
              "username": user.username,
              "question1_id": user.first_question,
              "answer1": user.first_question_answer,
              "question2_id": user.second_question,
              "answer2": user.second_question_answer,
            }),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 999) {
        throw HttpException(responseData['status'].toString());
      }
      else if (responseData['status'] == 888) {
        throw HttpException(responseData['status'].toString());
      }
      else if(responseData['token'] != null) {
        Prefs.setString(Prefs.TOKEN, responseData['token']);
        Prefs.setInt(Prefs.USER_ID, responseData['id']);
        notifyListeners();
      }
    }
    catch (error) {
      throw error;
    }
  }

  void logout() async{
    await DBProvider.db.getUser().then((value) async {
      final url =
          Configs.ip+'api/logged';
      try {
        Map<String, String> headers = {"Content-type": "application/json"};
        final response = await http.post(
          url,
          headers:headers,
          body: json.encode(
              {"id": value.id}),
        );
        final responseData = json.decode(response.body);
        if(responseData == "successfully") {
          await DBProvider.db.deleteAllNotifications();
          await DBProvider.db.deleteAllUsers();
          await DBProvider.db.deleteAllUserMoods();
          await DBProvider.db.deleteAllUserSymptom();
          await DBProvider.db.deleteAllUserImage();

          notifyListeners();
        }
      }
      catch (error) {
        throw error;
      }
    });
  }
  int getUserId(){
    return user_id;
  }

  String getName(){
    return username;
  }

  static Map<String, dynamic> loginRequestBodyToJson(String username, String password) =>
      {
        'username': username,
        'password': password,
      };
}