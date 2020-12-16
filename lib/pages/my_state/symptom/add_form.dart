import 'package:HIVApp/components/custom_button.dart';
import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/db/db_provider.dart';
import 'package:HIVApp/db/user_symptom.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../../utils/constants.dart';
import '../../../db/model/user.dart';

class SymptomViewModel{
  String fileName;
  String title;
  double rating;

  SymptomViewModel({this.fileName, this.title, this.rating});
}

class AddSymptomForm extends StatefulWidget {
  String title;

  AddSymptomForm({this.title});

  @override
  _AddSymptomFormState createState() => _AddSymptomFormState();
}

class _AddSymptomFormState extends State<AddSymptomForm> {

  DateTime _dateTime = new DateTime.now();
  final format = DateFormat("yyyy-MM-dd");
  String selectedSymptom = '';
  String selectedSymptomTitle = '';
  List<UserSymptom> _list = new List<UserSymptom>();
  double rating=0;
  List<SymptomViewModel> _symtopList = new List<SymptomViewModel>();
  String asset_path = "assets/images/symptoms/";
  DbUser dbUser = new DbUser();

  Widget dateTimePicker() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
//      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
      child: DateTimeField(
        resetIcon: Icon(FontAwesomeIcons.calendarAlt),
        format: format,
        initialValue: DateTime.now(),
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime.now());
          if (date != null) {
            setState(() {
              _dateTime = DateTime(
                  date.year, date.month, date.day);
            });
            return date;
          } else {
            return currentValue;
          }
        },
      ),
    );
  }

  fillTheSymptomList(){
    SymptomViewModel model =new SymptomViewModel(fileName: 'acne.png', title: 'Угревая сыпь', rating: 0.0);
    _symtopList.add(model);
    model =new SymptomViewModel(fileName: 'dizziness.png', title: 'Головокружение', rating: 0.0);
    _symtopList.add(model);
    model =new SymptomViewModel(fileName: 'fever.png', title: 'Лихородка', rating: 0.0);
    _symtopList.add(model);
    model =new SymptomViewModel(fileName: 'frontal-headaches.png', title: 'Мигрень', rating: 0.0);
    _symtopList.add(model);
    model =new SymptomViewModel(fileName: 'headache.png', title: 'Головная боль', rating: 0.0);
    _symtopList.add(model);
    model =new SymptomViewModel(fileName: 'inflammation.png', title: 'Боль в шее', rating: 0.0);
    _symtopList.add(model);
    model =new SymptomViewModel(fileName: 'shoulder.png', title: 'Боль в плечах', rating: 0.0);
    _symtopList.add(model);
  }

  getUser()async {
    DBProvider.db.getUser().then((value) {
      setState(() {
        dbUser = value;
      });
    });
  }
  
  @override
  void initState() {
    fillTheSymptomList();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.tr()),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: dateTimePicker(),
              ),
              Divider(),
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.separated(
                    itemBuilder: (context, index){
                      return ListTile(
                        leading: Image.asset(asset_path + _symtopList[index].fileName),
                        title: Text(_symtopList[index].title),
                        trailing: SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {
                            setState(() {
                              _symtopList[index].rating = v;
                            });
                          },
                          starCount: 5,
                          rating: _symtopList[index].rating,
                          size: 20.0,
                          isReadOnly:false,
                          color: kColorPrimary,
                          borderColor: kColorPrimaryDark,
                          spacing:0.0,
                        ),
                      );
                    },
                    separatorBuilder: (context, index){return Divider(); },
                    itemCount: _symtopList.length),
              ),
              Container(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.07),
                width: MediaQuery.of(context).size.width * 0.5,
                child: CustomButton(
                  text: 'add'.tr(),
                  onPressed: () async{
                    for(var i in _symtopList){
                      if(i.rating != 0.0){
                        UserSymptom userSymptom = new UserSymptom();
                        userSymptom.title = i.title;
                        userSymptom.file_name = i.fileName;
                        userSymptom.date_time = _dateTime;
                        userSymptom.user_id = dbUser.id;
                        userSymptom.rating = i.rating;
                        await DBProvider.db.newUserSymptom(userSymptom);
                      }
                    }
//                    super.initState();
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Routes.symptom);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
