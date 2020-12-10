import 'package:HIVApp/components/custom_button.dart';
import 'package:HIVApp/components/text_form_field.dart';
import 'package:HIVApp/model/user_registrations.dart';
import 'package:HIVApp/model/user.dart';
import 'package:HIVApp/pages/settings/widgets/change_password.dart';
import 'package:HIVApp/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:connectivity/connectivity.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  final _firstQuestionAnswerController = TextEditingController();
  final _secondQuestionAnswerController = TextEditingController();
  final _usernameController = TextEditingController();
  UserQuestion _question1 = new UserQuestion();
  UserQuestion _question2 = new UserQuestion();
  List<UserQuestion> _questions = new List<UserQuestion>();
  User _user = new User();

  final GlobalKey<FormState> _formKey = GlobalKey();

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    }
    else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    else{
      return false;
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => Center(
        child: AlertDialog(
          title: Text('error'.tr()),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('okay'.tr()),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                                  Text(
                                    'first_name_dot'.tr(),
                                    style: kInputTextStyle,
                                  ),
                                  CustomTextFormField(
                                    controller: _usernameController,
                                    hintText: 'логин',
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'loginIsEmptyError'.tr();
                                      }
                                    },
                                    onSaved: (value) {
                                      _user.username = value;
                                    },
                                  ),
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
                                CustomButton(
                                  onPressed: () {
                                    if (!_formKey.currentState.validate()) {
                                      return;
                                    }
                                    else{
                                      _checkInternetConnection().then((value) {
                                        if(value){
                                          _user.first_question = _question1.id;
                                          _user.username = _usernameController.text;
                                          _user.second_question = _question2.id;
                                          _user.first_question_answer = _firstQuestionAnswerController.text;
                                          _user.second_question_answer = _secondQuestionAnswerController.text;
                                          _user.resetPassword(_user).then((value) {
                                            Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => ChangePasswordPage(false),
                                            ),);
                                          });
                                        }
                                        else{
                                          _showErrorDialog('connect_to_internet'.tr());
                                        }
                                      });
                                    }
                                  },
                                  text: 'reset_password'.tr(),
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
