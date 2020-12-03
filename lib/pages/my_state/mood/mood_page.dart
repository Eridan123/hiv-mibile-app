import 'package:HIVApp/db/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'calendar_widget.dart';
import 'add_mood_form.dart';
import 'total_widget.dart';
import '../../../utils/constants.dart';
import '../../../components/custom_button.dart';

class MoodPage extends StatefulWidget {
  @override
  _MoodPageState createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  int _currentWidget = 0;
  List<bool> isSelected;


  Widget getWidget(int type){
    if(type == 0)
      return MoodCalendarWidget();
    else if(type == 1)
      return MoodTotalWidget();
  }

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('my_condition'.tr() + ' / ' + 'mood'.tr()),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0,MediaQuery.of(context).size.width * 0.02,0,MediaQuery.of(context).size.height * 0),
//              width:MediaQuery.of(context).size.width * 1,
//              alignment: Alignment(-0.3,0),
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ToggleButtons(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    onPressed: (int index) {
                      setState(() {
                        _currentWidget = index;
                        for (int i = 0; i < isSelected.length; i++) {
                          isSelected[i] = i == index;
                        }
                      });
                    },
                    focusColor: Color(0xff293A79),
                    highlightColor: Color(0xff293A79),
                    fillColor: Color(0xff293A79),
                    isSelected: isSelected,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            'calendar'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(fontSize: 20,color: isSelected[0] == true ? Colors.white : kColorPrimary),
                          ),
                        ),
                      ),
                      Container(
                        width:MediaQuery.of(context).size.width * 0.40,
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text(
                            'summary'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(fontSize: 20,color: isSelected[1] == true ? Colors.white : kColorPrimary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
//            SizedBox(height: MediaQuery.of(context).size.height * 0,),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: getWidget(_currentWidget),
          ),
        ],
      ),
    );
  }
}
