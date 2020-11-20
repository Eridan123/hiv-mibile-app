//import 'dart:convert';
//
//import 'package:HIVApp/data/pref_manager.dart';
//import 'package:flutter/widgets.dart';
//import 'package:http/http.dart' as http;
//
//import '../model/http_exceptions.dart';
//import '../data/configs.dart';
//
//class Auth extends ChangeNotifier{
//  String _token;
//  int _user_id ;
//  String _username;
//  String _password;
//
//
//  setToken(String value) {
//    _token = value;
//    notifyListeners();
//  }
//  setUser_id(int value) {
//    _user_id = value;
//  }
//
//  setUsername(String value) {
//    _username = value;
//    notifyListeners();
//  }
//
//  setPassword(String value) {
//    _password = value;
//  }
//
//  Auth(){}
//
//  bool get isAuth {
//    return _token != null;
//  }
//
//  String get token{
//    if(_token != null){
//      return _token;
//    }
//    return null;
//  }
//
//
//}
