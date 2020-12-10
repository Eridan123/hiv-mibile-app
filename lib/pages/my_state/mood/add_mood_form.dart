import 'package:HIVApp/components/custom_button.dart';
import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/db/db_provider.dart';
import 'package:HIVApp/db/user_mood.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/constants.dart';

class AddMoodForm extends StatefulWidget {
  String title;
  DateTime selectedDate;

  AddMoodForm({this.title, this.selectedDate});

  @override
  _AddMoodFormState createState() => _AddMoodFormState();
}

class _AddMoodFormState extends State<AddMoodForm> {

  DateTime _dateTime = new DateTime.now();
  final format = DateFormat("yyyy-MM-dd");
  String selectedSymptom = '';
  String selectedSymptomTitle = '';
  List<UserMood> _list = new List<UserMood>();
  String asset_path = "assets/images/moods/";

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

  @override
  void initState() {
    super.initState();
    _dateTime = widget.selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.tr()),
      ),
      body: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: <Widget>[
            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: dateTimePicker(),
            ),
            Divider(),*/
            Container(
              width: MediaQuery.of(context).size.width*1,
              height: MediaQuery.of(context).size.height*0.5,
//                padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Зол' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(asset_path+'angry.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Зол'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'angry.png';
                                  selectedSymptomTitle = 'Зол';
                                });
                              },),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Гневен' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(asset_path+'angry-1.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Гневен'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'angry-1.png';
                                  selectedSymptomTitle = 'Гневен';
                                });
                              },),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Скучно' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(asset_path+'bored.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Скучно'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'bored.png';
                                  selectedSymptomTitle = 'Скучно';
                                });
                              },),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Слёзы' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(asset_path+'crying.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Слёзы'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'crying.png';
                                  selectedSymptomTitle = 'Слёзы';
                                });
                              },),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Счастлив' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(asset_path+'happy.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Счастлив'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'happy.png';
                                  selectedSymptomTitle = 'Счастлив';
                                });
                              },),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Смушён' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(asset_path+'embarrassed.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Смушён'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'embarrassed.png';
                                  selectedSymptomTitle = 'Смушён';
                                });
                              },),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Благополучный' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(asset_path+'happy-1.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Благополучный', style: kTextStyleBody2.copyWith(fontSize: 13)),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'happy-1.png';
                                  selectedSymptomTitle = 'Благополучный';
                                });
                              },),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Болен' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(asset_path+'ill.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Болен'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'ill.png';
                                  selectedSymptomTitle = 'Болен';
                                });
                              },),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Грустно' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(asset_path+'sad.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Грустно'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'sad.png';
                                  selectedSymptomTitle = 'Грустно';
                                });
                              },),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Сумашедший' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(asset_path+'mad.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Сумашедший'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'mad.png';
                                  selectedSymptomTitle = 'Сумашедший';
                                });
                              },),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Влюблён' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(asset_path+'in-love.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Влюблён'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'in-love.png';
                                  selectedSymptomTitle = 'Влюблён';
                                });
                              },),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Улыбка' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(asset_path+'smile.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Улыбка'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'smile.png';
                                  selectedSymptomTitle = 'Улыбка';
                                });
                              },),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Несчастный' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(asset_path+'unhappy.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Несчастный'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'unhappy.png';
                                  selectedSymptomTitle = 'Несчастный';
                                });
                              },),
                          ),
                        ],
                      ),
                    ]
                )],
              ),
            ),
            Container(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              width: MediaQuery.of(context).size.width * 0.5,
              child: CustomButton(
                text: 'add'.tr(),
                onPressed: () async{
                  UserMood userMood = new UserMood();
                  userMood.title = selectedSymptomTitle;
                  userMood.file_name = selectedSymptom;
                  userMood.date_time = _dateTime;
                  userMood.user_id = 1;
                  await DBProvider.db.newUserMood(userMood);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Routes.mood);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
