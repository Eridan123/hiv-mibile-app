import 'dart:io';

import 'package:HIVApp/db/map_point.dart';
import 'package:HIVApp/db/model/answer.dart';
import 'package:HIVApp/db/mood.dart';
import 'package:HIVApp/db/notification.dart';
import 'package:HIVApp/db/symptom.dart';
import 'package:HIVApp/db/user_mood.dart';
import 'package:HIVApp/db/user_symptom.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'model/category.dart';
import 'model/client.dart';
import 'model/consultation.dart';
import 'model/question.dart';
import 'model/user.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;
  Future<Database> get database async {
    if (_database != null)
      return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "hivapp.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      //region Models on create
      //region User
      await db.execute("CREATE TABLE users ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "username TEXT,"
          "password TEXT,"
          "token TEXT,"
          "pin_code INTEGER"
          ")");
      //endregion
      //region Categories
      await db.execute("CREATE TABLE test_categories ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name_ky TEXT,"
          "name_ru TEXT"
          ")");
      //endregion
      //region Questions
      await db.execute("CREATE TABLE test_questions ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name_ky TEXT,"
          "name_ru TEXT,"
          "category_id INTEGER,"
          "CONSTRAINT fk_category\n"
          "FOREIGN KEY(category_id)\n "
          "REFERENCES test_categories(id)"
          ")");
      //endregion
      //region Answers
      await db.execute("CREATE TABLE test_answers ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name_ky TEXT,"
          "name_ru TEXT,"
          "question_id INTEGER,"
          "CONSTRAINT fk_question\n"
          "FOREIGN KEY (question_id)\n"
          "REFERENCES test_questions(id)"
          ")");
      //endregion
      //region Consultation
      await db.execute("CREATE TABLE consultation ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "consultant_id INTEGER,"
          "name_ky TEXT,"
          "name_ru TEXT,"
          "whatsapp TEXT,"
          "telegram TEXT,"
          "facebook TEXT,"
          "messenger TEXT,"
          "phone_number TEXT,"
          "latitude REAL,"
          "longitude REAL"
          ")");
      //endregion
      //region ARVP
//      await db.execute("CREATE TABLE arvp ("
//          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
//          "consultant_id INTEGER,"
//          "name_ky TEXT"
//          ")");
      //endregion
      //region Symptoms
      await db.execute("CREATE TABLE symptoms ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name_ky TEXT,"
          "name_ru TEXT,"
          "image_name TEXT"
          ")");
      //endregion
      //region Moods
      await db.execute("CREATE TABLE moods ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name_ky TEXT,"
          "name_ru TEXT,"
          "image_name TEXT"
          ")");
      //endregion
      //region Notifications
      await db.execute("CREATE TABLE notifications ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "description TEXT,"
          "date_time DATETIME,"
          "time_type TEXT CHECK( time_type IN ('NotificationDbTimeType.Hour','NotificationDbTimeType.Day','NotificationDbTimeType.Month') )   NOT NULL DEFAULT 'NotificationDbTimeType.Hour',"
          "type TEXT CHECK( type IN ('NotificationDbType.Drug','NotificationDbType.Visit','NotificationDbType.Analysis') )   NOT NULL DEFAULT 'NotificationDbType.Drug'"
          ")");
      //endregion
      //region Map Points
      await db.execute("CREATE TABLE map_points ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name_ky TEXT,"
          "name_ru TEXT,"
          "description TEXT,"
          "latitude REAL,"
          "longitude REAL,"
          "type INTEGER"
          ")");
      //endregion
      //region User Symptoms
      await db.execute("CREATE TABLE user_symptoms ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "user_id INTEGER,"
          "symptom_id INTEGER,"
          "date_time DATETIME,"
          "CONSTRAINT fk_user\n"
          "FOREIGN KEY (user_id)\n"
          "REFERENCES users(id)\n"
          "CONSTRAINT fk_syptom\n"
          "FOREIGN KEY (symptom_id)\n"
          "REFERENCES symptoms(id)\n"
          ")");
      //endregion
      //region User Moods
      await db.execute("CREATE TABLE user_moods ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "user_id INTEGER,"
          "mood_id INTEGER,"
          "date_time DATETIME,"
          "CONSTRAINT fk_user\n"
          "FOREIGN KEY (user_id)\n"
          "REFERENCES users(id)\n"
          "CONSTRAINT fk_mood\n"
          "FOREIGN KEY (mood_id)\n"
          "REFERENCES moods(id)"
          ")");
      //endregion
      //endregion
    });
  }
  //region Database models' functions:
  //region User
    newUser(DbUser newUser) async {
      final db = await database;
      //get the biggest id in the table
      //insert to the table using the new id
      var raw = await db.rawInsert(
          "INSERT Into users(id,username,password, token, pin_code)"
              " VALUES (?,?,?,?,?)",
          [newUser.id, newUser.username, newUser.password, newUser.token, newUser.pin_code]);
      return raw;
    }
    getUser() async {
      final db = await database;
      var res =await  db.query("users", limit: 1);
      return res.isNotEmpty ? DbUser.fromJson(res.first) : Null ;
    }
    updateUser(DbUser newUser) async {
      final db = await database;
      var res = await db.update("users", newUser.toJson(),
          where: "id = ?", whereArgs: [newUser.id]);
      return res;
    }
    deleteUser(int id) async {
      final db = await database;
      db.delete("users", where: "id = ?", whereArgs: [id]);
    }
    deleteAllUsers() async {
      final db = await database;
      db.rawDelete("Delete * from users");
    }
    //endregion
  //region Categories
  newCategory(Category model) async {
    final db = await database;
    //get the biggest id in the table
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into test_categories(id,name_ky, name_ru)"
            " VALUES (?,?,?)",
        [model.id, model.name_ky, model.name_ru]);
    return raw;
  }
  getCategory(int id) async {
    final db = await database;
    var res =await  db.query("test_categories", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Category.fromJson(res.first) : Null ;
  }
  updateCategory(Category newModel) async {
    final db = await database;
    var res = await db.update("test_categories", newModel.toJson(),
        where: "id = ?", whereArgs: [newModel.id]);
    return res;
  }
  deleteCategory(int id) async {
    final db = await database;
    db.delete("test_categories", where: "id = ?", whereArgs: [id]);
  }
  deleteAllCategories() async {
    final db = await database;
    db.rawDelete("Delete * from test_categories");
  }
  //endregion
  //region Questions
  newQuestion(Question model) async {
    final db = await database;
    //get the biggest id in the table
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into test_questions(id, name_ky, name_ru, category_id)"
            " VALUES (?,?,?,?)",
        [model.id, model.name_ky, model.name_ru, model.category_id]);
    return raw;
  }
  getQuestion(int id) async {
    final db = await database;
    var res =await  db.query("test_questions", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Question.fromJson(res.first) : Null ;
  }
  updateQuestion(Question newModel) async {
    final db = await database;
    var res = await db.update("test_questions", newModel.toJson(),
        where: "id = ?", whereArgs: [newModel.id]);
    return res;
  }
  deleteQuestion(int id) async {
    final db = await database;
    db.delete("test_questions", where: "id = ?", whereArgs: [id]);
  }
  deleteAllQuestions() async {
    final db = await database;
    db.rawDelete("Delete * from test_questions");
  }
  //endregion
  //region Answers
  newAnswer(Answer model) async {
    final db = await database;
    //get the biggest id in the table
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into test_answers(id, name_ky, name_ru, question_id)"
            " VALUES (?,?,?,?)",
        [model.id, model.name_ky, model.name_ru, model.question_id]);
    return raw;
  }
  getAnswer(int id) async {
    final db = await database;
    var res =await  db.query("test_answers", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Answer.fromJson(res.first) : Null ;
  }
  updateAnswer(Answer newModel) async {
    final db = await database;
    var res = await db.update("test_answers", newModel.toJson(),
        where: "id = ?", whereArgs: [newModel.id]);
    return res;
  }
  deleteAnswer(int id) async {
    final db = await database;
    db.delete("test_answers", where: "id = ?", whereArgs: [id]);
  }
  deleteAllAnswers() async {
    final db = await database;
    db.rawDelete("Delete * from test_answers");
  }
  //endregion
  //region Consultations
  newConsultation(Consultation model) async {
    final db = await database;
    //get the biggest id in the table
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into consultation(id, consultant_id, name_ky, name_ru, whatsapp, telegram, facebook, messenger, phone_number, latitude, longitude)"
            " VALUES (?,?,?,?,?,?,?,?,?,?,?)",
        [model.id, model.consultant_id, model.name_ky, model.name_ru, model.whatsapp,
          model.telegram, model.facebook, model.messenger, model.phone_number, model.latitude, model.longitude]);
    return raw;
  }
  getConsultation(int id) async {
    final db = await database;
    var res =await  db.query("consultation", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Consultation.fromJson(res.first) : Null ;
  }
  updateConsultation(Answer newModel) async {
    final db = await database;
    var res = await db.update("consultation", newModel.toJson(),
        where: "id = ?", whereArgs: [newModel.id]);
    return res;
  }
  deleteConsultation(int id) async {
    final db = await database;
    db.delete("consultation", where: "id = ?", whereArgs: [id]);
  }
  deleteAllConsultations() async {
    final db = await database;
    db.rawDelete("Delete * from consultation");
  }
  //endregion
  //region Symptoms
  newSymptom(Symptom model) async {
    final db = await database;
    //get the biggest id in the table
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into symptoms(id, name_ky, name_ru, image_name)"
            " VALUES (?,?,?,?)",
        [model.id, model.name_ky, model.name_ru, model.image_name]);
    return raw;
  }
  getSymptom(int id) async {
    final db = await database;
    var res =await  db.query("symptoms", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Symptom.fromJson(res.first) : Null ;
  }
  updateSymptom(Symptom newModel) async {
    final db = await database;
    var res = await db.update("symptoms", newModel.toJson(),
        where: "id = ?", whereArgs: [newModel.id]);
    return res;
  }
  deleteSymptom(int id) async {
    final db = await database;
    db.delete("symptoms", where: "id = ?", whereArgs: [id]);
  }
  deleteAllSymptoms() async {
    final db = await database;
    db.rawDelete("Delete * from symptoms");
  }
  //endregion
  //region Moods
  newMood(Mood model) async {
    final db = await database;
    //get the biggest id in the table
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into moods(id, name_ky, name_ru, image_name)"
            " VALUES (?,?,?,?)",
        [model.id, model.name_ky, model.name_ru, model.image_name]);
    return raw;
  }
  getMood(int id) async {
    final db = await database;
    var res =await  db.query("moods", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Mood.fromJson(res.first) : Null ;
  }
  updateMood(Mood newModel) async {
    final db = await database;
    var res = await db.update("moods", newModel.toJson(),
        where: "id = ?", whereArgs: [newModel.id]);
    return res;
  }
  deleteMood(int id) async {
    final db = await database;
    db.delete("moods", where: "id = ?", whereArgs: [id]);
  }
  deleteAllMoods() async {
    final db = await database;
    db.rawDelete("Delete * from moods");
  }
  //endregion
  //region Notifications
  Future<int> newNotification(NotificationDb model) async {
    final db = await database;
    //get the biggest id in the table
    //insert to the table using the new id
    var raw = await db.insert(
        "notifications",
        model.toJson());
    return raw;
  }
  getNotification(int id) async {
    final db = await database;
    var res =await  db.query("notifications", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? NotificationDb.fromJson(res.first) : Null ;
  }
  Future<List<NotificationDb>> getAllNotifications() async {

    final db = await database;
    var res =await  db.query("notifications");
    List<NotificationDb> list = new List<NotificationDb>();
    for(var r in res){
      list.add(NotificationDb.fromJson(r));
    }
    return res.isNotEmpty ? list : Null ;
  }

  Future<List<NotificationDb>> getNotificationsByType(NotificationDbType type) async {

    final db = await database;
    var res =await  db.query("notifications" , where: "type = ?", whereArgs: [type.toString()]);
    List<NotificationDb> list = new List<NotificationDb>();
    for(var r in res){
      list.add(NotificationDb.fromJson(r));
    }
    return res.isNotEmpty ? list : Null ;
  }
  updateNotification(NotificationDb newModel) async {
    final db = await database;
    var res = await db.update("notifications", newModel.toJson(),
        where: "id = ?", whereArgs: [newModel.id]);
    return res;
  }
  deleteNotification(int id) async {
    final db = await database;
    db.delete("notifications", where: "id = ?", whereArgs: [id]);
  }
  deleteAllNotifications() async {
    final db = await database;
    db.rawDelete("Delete * from notifications");
  }
  //endregion
  //region Map Points
  newMapPoint(MapPoint model) async {
    final db = await database;
    //get the biggest id in the table
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into map_points(id, name_ky, name_ru, description, latitude, longitude, type)"
            " VALUES (?,?,?,?,?,?,?)",
        [model.id, model.name_ky, model.name_ru, model.description, model.latitude, model.longitude, model.type]);
    return raw;
  }
  getMapPoint(int id) async {
    final db = await database;
    var res =await  db.query("map_points", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? MapPoint.fromJson(res.first) : Null ;
  }
  updateMapPoint(MapPoint newModel) async {
    final db = await database;
    var res = await db.update("map_points", newModel.toJson(),
        where: "id = ?", whereArgs: [newModel.id]);
    return res;
  }
  deleteMapPoint(int id) async {
    final db = await database;
    db.delete("map_points", where: "id = ?", whereArgs: [id]);
  }
  deleteAllMapPoints() async {
    final db = await database;
    db.rawDelete("Delete * from map_points");
  }
  //endregion
  //region User Moods
  newUserMood(UserMood model) async {
    final db = await database;
    //get the biggest id in the table
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into user_moods(id, user_id, mood_id, date_time)"
            " VALUES (?,?,?,?)",
        [model.id, model.user_id, model.mood_id, model.date_time]);
    return raw;
  }
  getUserMood(int id) async {
    final db = await database;
    var res =await  db.query("user_moods", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? UserMood.fromJson(res.first) : Null ;
  }
  updateUserMood(UserMood newModel) async {
    final db = await database;
    var res = await db.update("user_moods", newModel.toJson(),
        where: "id = ?", whereArgs: [newModel.id]);
    return res;
  }
  deleteUserMood(int id) async {
    final db = await database;
    db.delete("user_moods", where: "id = ?", whereArgs: [id]);
  }
  deleteAllUserMoods() async {
    final db = await database;
    db.rawDelete("Delete * from user_moods");
  }
  //endregion
  //endregion
}