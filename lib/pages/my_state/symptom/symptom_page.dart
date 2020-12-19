import 'package:HIVApp/components/custom_button.dart';
import 'package:HIVApp/db/db_provider.dart';
import 'package:HIVApp/pages/basic_information/widgets/text.dart';
import 'package:HIVApp/pages/basic_information/widgets/video.dart';
import 'package:HIVApp/pages/my_state/symptom/chronology_widget.dart';
import 'package:HIVApp/pages/my_state/symptom/total_widget.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:HIVApp/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'add_form.dart';

class SymptomPage extends StatefulWidget {
  @override
  _SymptomPageState createState() => _SymptomPageState();
}

class _SymptomPageState extends State<SymptomPage> {

  int _currentWidget = 0;
  List<bool> isSelected;
  bool logged = false;


  Widget getWidget(int type){
    if(type == 0)
      return SymptomChronolgy();
    else if(type == 1)
      return SymptomTotalWidget();
  }

  isLoggedIn() async {
    await DBProvider.db.getUserId().then((value) {
      if(value != null)
        setState(() {
          logged = true;
        });
    });
  }

  @override
  void initState() {
    isSelected = [true, false];
    isLoggedIn();
    super.initState();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        child: AlertDialog(
          title: Text(''),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('back'.tr()),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            FlatButton(
              child: Text('continue'.tr()),
              onPressed: () {
                Navigator.of(ctx).popAndPushNamed(Routes.login);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('my_condition'.tr() + ' / ' + 'symptoms'.tr()),
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
                            'chronology'.tr(),
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
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: CustomButton(
              text: 'add'.tr(),
              onPressed: (){
                if(logged){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AddSymptomForm(title: 'set_symptom'),
                  ),);
                }
                else{
                  _showErrorDialog('login_or_sign_up_to_add'.tr());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
