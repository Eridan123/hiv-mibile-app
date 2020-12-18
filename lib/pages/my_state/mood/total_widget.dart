import 'package:HIVApp/components/custom_button.dart';
import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/db/db_provider.dart';
import 'package:HIVApp/db/user_mood.dart';
import 'package:HIVApp/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

class TimeType{
  String name;
  int type;

  TimeType({this.name, this.type});
}

class MoodTotalWidget extends StatefulWidget {
  @override
  _MoodTotalWidgetState createState() => _MoodTotalWidgetState();
}

class _MoodTotalWidgetState extends State<MoodTotalWidget> {

  List<UserMoodTotal> _list = new List<UserMoodTotal>();
  List<TimeType> _timeList = new List<TimeType>();
  TimeType timeType = new TimeType();
  DateTime initialDate = DateTime.now();
  Color _color;
  var _isDark = Prefs.getBool(Prefs.DARKTHEME, def: false);
  String asset_path = "assets/images/moods/";


  getList() async{
    if(_list.isNotEmpty)
      _list.clear();
    await DBProvider.db.getAllUserMoodsGroupedByTitle(timeType.type).then((value) {
      setState(() {
        _list.addAll(value);
      });
    });
  }

  @override
  void initState() {
    timeType = new TimeType(name: 'last7Days'.tr(), type: 1);
    _timeList.add(timeType);
    timeType = new TimeType(name: 'last30Days'.tr(), type: 2);
    _timeList.add(timeType);
    timeType = new TimeType(name: 'last60Days'.tr(), type: 3);
    _timeList.add(timeType);
    timeType = new TimeType(name: 'last90Days'.tr(), type: 4);
    _timeList.add(timeType);
    timeType = new TimeType(name: 'last6Months'.tr(), type: 5);
    _timeList.add(timeType);
    timeType = new TimeType(name: 'lastYear'.tr(), type: 6);
    _timeList.add(timeType);
    getList();
    super.initState();
    _color = _isDark ? Colors.white.withOpacity(0.12) : Colors.grey[200];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.5,
            child: DropdownButton<TimeType>(
              isExpanded: true,
              value: timeType,
              elevation: 16,
              style: Theme.of(context).textTheme.bodyText1,
              underline: Container(),
              icon: Icon(FontAwesomeIcons.sortDown),
              onChanged: (TimeType newValue) {
                setState(() {
                  timeType = newValue;
                  getList();
                });
              },
              items: _timeList
                  .map<DropdownMenuItem<TimeType>>((TimeType value) {
                return DropdownMenuItem<TimeType>(
                  value: value,
                  child: Text(value.name) ,
                );
              }).toList(),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.57,
            child: ListView.separated(
                itemBuilder: (context, index){
                  return ListTile(
                    tileColor: index%2==0 ? _color: Colors.transparent,
                    leading: Image.asset(asset_path + _list[index].file_name),
                    title: Text(_list[index].title.tr(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(_list[index].count ==1 ?_list[index].count.toString() +' '+ 'day'.tr() : _list[index].count<5 ?_list[index].count.toString() + ' ' + 'days1'.tr() : _list[index].count.toString() + ' '+'days2'.tr(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index){
                  return Divider();
                },
                itemCount: _list.length),
          ),
        ],
      ),
    );
  }
}
