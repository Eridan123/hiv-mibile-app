import 'package:HIVApp/model/question.dart';
import 'package:HIVApp/model/user.dart';
import 'package:HIVApp/model/user_registrations.dart';
import 'package:HIVApp/pages/signup/questionary.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/text_form_field.dart';
import '../../utils/constants.dart';

enum Gender { male, female }

class QuestionnairePage extends StatefulWidget {

  final User user;


  QuestionnairePage({this.user});

  @override
  _QuestionnairePageState createState() => _QuestionnairePageState();
}

class _QuestionnairePageState extends State<QuestionnairePage> {

  final User user;
  final _firstQuestionAnswerController = TextEditingController();
  final _secondQuestionAnswerController = TextEditingController();
  UserQuestion _question1 = new UserQuestion();
  UserQuestion _question2 = new UserQuestion();
  List<UserQuestion> _questions = new List<UserQuestion>();
  User _user;

  final GlobalKey<FormState> _formKey = GlobalKey();

  _QuestionnairePageState({this.user});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = widget.user;
    _questions = Provider.of<UserRegistation>(context, listen: false).userQuestions;
    _question1 = _questions.first;
    _question2 = _questions.first;
  }

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
                        'questions'.tr(),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 38),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(children: [
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: 10,),
                                      Text("first_question".tr(), textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(fontWeight: FontWeight.bold)),
                                      Icon(Icons.ac_unit,size: 10,color: Colors.red,),
                                    ],
                                  ),
                                  DropdownButton<UserQuestion>(
                                    isExpanded: true,
                                    hint: Text("first_question".tr()),
                                    value: _question1,
                                    elevation: 16,
                                    style: TextStyle(
                                        color: Colors.deepPurple
                                    ),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.blue,
                                    ),
                                    onChanged: (UserQuestion newValue) {
                                      setState(() {
                                        _question1 = newValue;
                                      });
                                    },
                                    items: _questions
                                        .map<DropdownMenuItem<UserQuestion>>((UserQuestion value) {
                                      return DropdownMenuItem<UserQuestion>(
                                        value: value,
                                        child: Text(value.ru) ,
                                      );
                                    }).toList(),
                                  ),
                                ],),
                                Text(
                                  'answer'.tr(),
                                  style: kInputTextStyle,
                                ),
                                CustomTextFormField(
                                  controller: _firstQuestionAnswerController,
                                  hintText: '',
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'fillThisFieldError'.tr();
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 10,),
                                    Text("second_question".tr(), textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                    Icon(Icons.ac_unit,size: 10,color: Colors.red,),
                                  ],
                                ),
                                DropdownButton<UserQuestion>(
                                  isExpanded: true,
                                  hint: Text("second_question".tr()),
                                  value: _question2,
                                  elevation: 16,
                                  style: TextStyle(
                                      color: Colors.deepPurple
                                  ),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blue,
                                  ),
                                  onChanged: (UserQuestion newValue) {
                                    setState(() {
                                      _question2 = newValue;
                                    });
                                  },
                                  items: _questions
                                      .map<DropdownMenuItem<UserQuestion>>((UserQuestion value) {
                                    return DropdownMenuItem<UserQuestion>(
                                      value: value,
                                      child: Text(value.ru) ,
                                    );
                                  }).toList(),
                                ),
                                Text(
                                  'answer'.tr(),
                                  style: kInputTextStyle,
                                ),
                                CustomTextFormField(
                                  controller: _secondQuestionAnswerController,
                                  hintText: '',
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'fillThisFieldError'.tr();
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                                Center(
                                  child: Text(
                                    'step'.tr() + ' 2',
                                    style: kInputTextStyle,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                LinearProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  value: 0.7,
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
                                      _user.first_question = _question1.id;
                                      _user.second_question = _question2.id;
                                      _user.first_question_answer = _firstQuestionAnswerController.text;
                                      _user.second_question_answer = _secondQuestionAnswerController.text;

                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => Questionary(user: _user),
                                      ),);
                                    }
                                  },
                                  text: 'next_step'.tr(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

