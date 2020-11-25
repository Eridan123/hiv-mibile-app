import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/db/db_provider.dart';
import 'package:HIVApp/db/notification.dart';
import 'package:HIVApp/db/user_mood.dart';
import 'package:HIVApp/db/user_symptom.dart';
import 'package:HIVApp/pages/examination/examination_page.dart';
import 'package:HIVApp/pages/test/test_page.dart';
import 'package:HIVApp/pages/visit/visit_page.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:HIVApp/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  List<NotificationDb> _notificationList = new List<NotificationDb>();
  List<UserSymptom> _userSymptomList = new List<UserSymptom>();
  List<UserMood> _userMoodList = new List<UserMood>();

  double moodHeight = 0;
  double symptomHeight = 0;
  double notificationHeight = 0;

  _getUserSymptomList() async{
    if(_userSymptomList.isNotEmpty)
      _userSymptomList.clear();
    await DBProvider.db.getAllUserSymptoms().then((value) {
      setState(() {
        _userSymptomList.addAll(value);
      });
    });
  }

  _getListOfNotifications() async{
    await DBProvider.db.getAllNotifications().then((value) {
      setState(() {
        _notificationList = value;
      });
    });
  }

  _getUserMoodList() async{
    if(_userMoodList.isNotEmpty)
      _userMoodList.clear();
    await DBProvider.db.getAllUserMoods().then((value) {
      setState(() {
        _userMoodList.addAll(value);
      });
    });
  }

  Widget getNotifications(){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          child: ListTile(
            title: Text('notes'.tr(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(notificationHeight == 0 ? FontAwesomeIcons.sortDown : FontAwesomeIcons.sortUp),
            onTap: (){
              setState(() {
                if(notificationHeight == 0)
                  notificationHeight = MediaQuery.of(context).size.height * 0.08 * 5;
                else
                  notificationHeight = 0;
              });
            },
          ),
        ),
        Container(
          height: notificationHeight,
          child: ListView.builder(
//                      separatorBuilder: (context, index) => Divider(),
              padding: const EdgeInsets.all(8),
              itemCount: _notificationList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text(
                    '${_notificationList[index].datetime.year}-${_notificationList[index]
                        .datetime.month}-${_notificationList[index].datetime
                        .day}\n${_notificationList[index].datetime
                        .hour}:${_notificationList[index].datetime.minute}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Text('${_notificationList[index].description}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }
  Widget getUserSymptoms(){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          child: ListTile(
            title: Text('symptoms'.tr(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(symptomHeight == 0 ? FontAwesomeIcons.sortDown : FontAwesomeIcons.sortUp),
            onTap: (){
              setState(() {
                if(symptomHeight == 0)
                  symptomHeight = MediaQuery.of(context).size.height * 0.08 * 5;
                else
                  symptomHeight = 0;
              });
            },
          ),
        ),
        Container(
          height: symptomHeight,
          child: ListView.builder(
//                      separatorBuilder: (context, index) => Divider(),
              padding: const EdgeInsets.all(8),
              itemCount: _userSymptomList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text(
                    '${_userSymptomList[index].date_time.year}-${_userSymptomList[index]
                        .date_time.month}-${_userSymptomList[index].date_time
                        .day}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Text('${_userSymptomList[index].title}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }
  Widget getUserMoods(){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
          child: ListTile(
            title: Text('mood'.tr(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Icon(moodHeight == 0 ? FontAwesomeIcons.sortDown : FontAwesomeIcons.sortUp),
            onTap: (){
              setState(() {
                if(moodHeight == 0)
                  moodHeight = MediaQuery.of(context).size.height * 0.08 * 5;
                else
                  moodHeight = 0;
              });
            },
          ),
        ),
        Container(
          height: moodHeight,
          child: ListView.builder(
//                      separatorBuilder: (context, index) => Divider(),
              padding: const EdgeInsets.all(8),
              itemCount: _userMoodList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text(
                    '${_userMoodList[index].date_time.year}-${_userMoodList[index]
                        .date_time.month}-${_userMoodList[index].date_time
                        .day}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Text('${_userMoodList[index].title}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    _getListOfNotifications();
    _getUserSymptomList();
    _getUserMoodList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height * 20,
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          getNotifications(),
          getUserSymptoms(),
          getUserMoods(),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
