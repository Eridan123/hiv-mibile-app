import 'package:HIVApp/components/custom_button.dart';
import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/db/db_provider.dart';
import 'package:HIVApp/db/user_symptom.dart';
import 'package:HIVApp/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:easy_localization/easy_localization.dart';

import 'add_form.dart';

class TimeType{
  String name;
  int type;

  TimeType({this.name, this.type});
}

class SymptomTotalWidget extends StatefulWidget {
  @override
  _SymptomTotalWidgetState createState() => _SymptomTotalWidgetState();
}

class _SymptomTotalWidgetState extends State<SymptomTotalWidget> {

  List<UserSymptomTotal> _list = new List<UserSymptomTotal>();
  List<TimeType> _timeList = new List<TimeType>();
  TimeType timeType = new TimeType();
  DateTime initialDate = DateTime.now();
  Color _color;
  var _isDark = Prefs.getBool(Prefs.DARKTHEME, def: false);


  getList() async{
    if(_list.isNotEmpty)
      _list.clear();
    await DBProvider.db.getAllGroupedByTitle(timeType.type).then((value) {
      setState(() {
        _list.addAll(value);
      });
    });
  }

  @override
  void initState() {
    timeType = new TimeType(name: 'За последние 7 дней', type: 1);
    _timeList.add(timeType);
    timeType = new TimeType(name: 'За последние 30 дней', type: 2);
    _timeList.add(timeType);
    timeType = new TimeType(name: 'За последние 60 дней', type: 3);
    _timeList.add(timeType);
    timeType = new TimeType(name: 'За последние 90 дней', type: 4);
    _timeList.add(timeType);
    timeType = new TimeType(name: 'За последние 6 месяцев', type: 5);
    _timeList.add(timeType);
    timeType = new TimeType(name: 'За последний год', type: 6);
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
                    leading: Image.asset(_list[index].file_name),
                    title: Text(_list[index].title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(_list[index].count ==1 ?_list[index].count.toString() + ' день' : _list[index].count<5 ?_list[index].count.toString() + ' дня' : _list[index].count.toString() + ' дней',
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
