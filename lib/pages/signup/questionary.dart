import 'package:HIVApp/model/auth.dart';
import 'package:HIVApp/model/user.dart';
import 'package:HIVApp/model/user_registrations.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/text_form_field.dart';
import '../../utils/constants.dart';

//enum Gender { male, female }

class Questionary extends StatefulWidget {

  final User user;


  Questionary({this.user});

  @override
  _QuestionaryState createState() => _QuestionaryState();
}

class _QuestionaryState extends State<Questionary> {

  final _birthYearController = TextEditingController();
  Gender _gender = new Gender();
  Sex _sex = new Sex();
  List<Gender> _genders = new List<Gender>();
  List<Sex> _sexes = new List<Sex>();
  User _user;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _sexes = Provider.of<UserRegistation>(context, listen: false).sexes;
    _genders = Provider.of<UserRegistation>(context, listen: false).genders;
    _sex = _sexes.first;
    _gender = _genders.first;
  }

  bool rememberMe = false;
  void _onRememberMeChanged(bool newValue) => setState(() {
    rememberMe = newValue;

    if (rememberMe) {
      // TODO: Here goes your functionality that remembers the user.
    } else {
      // TODO: Forget the user
    }
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 38),
                      child: Text(
                        'questionary'.tr(),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 38),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 10,),
                                    Text("gender_dot".tr(), textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                    Icon(Icons.ac_unit,size: 10,color: Colors.red,),
                                  ],
                                ),
                                DropdownButton<Gender>(
                                  isExpanded: true,
                                  hint: Text("gender_dot".tr()),
                                  value: _gender,
                                  elevation: 16,
                                  style: TextStyle(
                                      color: Colors.deepPurple
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blue,
                                  ),
                                  onChanged: (Gender newValue) {
                                    setState(() {
                                      _gender = newValue;
                                    });
                                  },
                                  items: _genders
                                      .map<DropdownMenuItem<Gender>>((Gender value) {
                                    return DropdownMenuItem<Gender>(
                                      value: value,
                                      child: Text(value.ru) ,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                    value: rememberMe,
                                    onChanged: _onRememberMeChanged
                                ),
                                Text('intersex'.tr(), style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 38),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 10,),
                                    Text("gender_dot".tr(), textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                    Icon(Icons.ac_unit,size: 10,color: Colors.red,),
                                  ],
                                ),
                                DropdownButton<Sex>(
                                  isExpanded: true,
                                  hint: Text("gender_dot".tr()),
                                  value: _sex,
                                  elevation: 16,
                                  style: TextStyle(
                                      color: Colors.deepPurple
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blue,
                                  ),
                                  onChanged: (Sex newValue) {
                                    setState(() {
                                      _sex = newValue;
                                    });
                                  },
                                  items: _sexes
                                      .map<DropdownMenuItem<Sex>>((Sex value) {
                                    return DropdownMenuItem<Sex>(
                                      value: value,
                                      child: Text(value.ru) ,
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                Text("birth_year".tr(), textAlign: TextAlign.left,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                CustomTextFormField(
                                  controller: _birthYearController,
                                  keyboardType: TextInputType.number,
                                  hintText: '1999',
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'fillThisFieldError'.tr();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 38),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 35,
                                ),
                                Center(
                                  child: Text(
                                    'step'.tr() + ' 3',
                                    style: kInputTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                LinearProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  value: 1,
                                  minHeight: 5,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  onPressed: () {
                                    if (!_formKey.currentState.validate()) {
                                      return;
                                    }
                                    else{
                                      _user.gender = _gender.id;
                                      _user.sex = _sex.id;
                                      _user.intersex = rememberMe;
                                      _user.birth_year = int.parse(_birthYearController.text);

                                      _user.create().then((value){
                                        Navigator.pushNamed(context, Routes.successfull_registration);
                                      });
                                    }
                                  },
                                  text: 'next_step'.tr(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}