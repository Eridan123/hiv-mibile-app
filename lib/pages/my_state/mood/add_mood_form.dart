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

  AddMoodForm({this.title});

  @override
  _AddMoodFormState createState() => _AddMoodFormState();
}

class _AddMoodFormState extends State<AddMoodForm> {

  DateTime _dateTime = new DateTime.now();
  final format = DateFormat("yyyy-MM-dd");
  String selectedSymptom = '';
  String selectedSymptomTitle = '';
  List<UserMood> _list = new List<UserMood>();

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: dateTimePicker(),
            ),
            Divider(),
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
                                    Image.asset('assets/images/moods/angry.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Зол'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/angry.png';
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
                                    Image.asset('assets/images/moods/angry-1.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Гневен'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/angry-1.png';
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
                                    Image.asset('assets/images/moods/bored.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Скучно'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/bored.png';
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
                            color: selectedSymptomTitle == 'Тоскливо' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/moods/bored-1.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Тоскливо'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/bored-1.png';
                                  selectedSymptomTitle = 'Тоскливо';
                                });
                              },),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Невесело' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/moods/bored-2.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Невесело'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/bored-2.png';
                                  selectedSymptomTitle = 'Невесело';
                                });
                              },),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Слёзы' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/moods/crying.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Слёзы'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/crying.png';
                                  selectedSymptomTitle = 'Слёзы';
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
                            color: selectedSymptomTitle == 'Смушён' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/moods/embarrassed.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Смушён'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/embarrassed.png';
                                  selectedSymptomTitle = 'Смушён';
                                });
                              },),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Плачь' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/moods/crying-1.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Плачь'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/crying-1.png';
                                  selectedSymptomTitle = 'Плачь';
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
                                    Image.asset('assets/images/moods/happy.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Счастлив'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/happy.png';
                                  selectedSymptomTitle = 'Счастлив';
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
                                    Image.asset('assets/images/moods/happy-2.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Благополучный'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/happy-2.png';
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
                                    Image.asset('assets/images/moods/ill.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Болен'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/ill.png';
                                  selectedSymptomTitle = 'Болен';
                                });
                              },),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Блаженный' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/moods/happy-4.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Блаженный'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/happy-4.png';
                                  selectedSymptomTitle = 'Блаженный';
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
                                    Image.asset('assets/images/moods/mad.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Сумашедший'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/mad.png';
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
                                    Image.asset('assets/images/moods/in-love.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Влюблён'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/in-love.png';
                                  selectedSymptomTitle = 'Влюблён';
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
                                    Image.asset('assets/images/moods/sad.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Грустно'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/sad.png';
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
                            color: selectedSymptomTitle == 'Несчастный' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/moods/unhappy.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Несчастный'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/unhappy.png';
                                  selectedSymptomTitle = 'Несчастный';
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
                                    Image.asset('assets/images/moods/smile.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Улыбка'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/smile.png';
                                  selectedSymptomTitle = 'Улыбка';
                                });
                              },),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.width * 0.3,
                            color: selectedSymptomTitle == 'Улыбчивый' ? kColorPrimary : Colors.transparent,
                            child: InkWell(
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset('assets/images/moods/smiling.png', height: MediaQuery.of(context).size.height * 0.06,),
                                    Text('Улыбчивый'),
                                  ],
                                ),
                              ),
                              onTap: (){
                                setState(() {
                                  selectedSymptom = 'assets/images/moods/smiling.png';
                                  selectedSymptomTitle = 'Улыбчивый';
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
//                    super.initState();
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
