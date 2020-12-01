import 'package:HIVApp/model/user.dart';
import 'package:HIVApp/model/user_model.dart';
import 'package:HIVApp/model/user_registrations.dart';
import 'package:HIVApp/pages/signup/questionary.dart';
import 'package:HIVApp/pages/signup/questionnaire.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/text_form_field.dart';
import '../../utils/constants.dart';

enum Gender { male, female }

class SignupPage extends StatelessWidget {
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
                        'sign_up'.tr(),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    WidgetSignup(),
                    Expanded(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 38),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${'already_a_member'.tr()}',
                              style: TextStyle(
                                color: Color(0xffbcbcbc),
                                fontSize: 12,
                                fontFamily: 'Nunito',
                              ),
                            ),
                            Text('   '),
                            InkWell(
                              borderRadius: BorderRadius.circular(2),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  'login'.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .button
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
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

class WidgetSignup extends StatefulWidget {
  @override
  _WidgetSignupState createState() => _WidgetSignupState();
}

class _WidgetSignupState extends State<WidgetSignup> {


  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final User _user = new User();
  bool _password_satisfy = true;
  bool _userExists = false;

  @override
  void initState() {
    super.initState();
    Provider.of<UserRegistation>(context, listen: false).getList();
  }

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
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                    else if(_userExists){
                      return 'usernameExists'.tr();
                    }
                  },
                  onSaved: (value) {
                    _user.username = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'login_recommend_text'.tr(),
                  style: kTextStyleSubtitle2,
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'password_dot'.tr(),
                  style: kInputTextStyle,
                ),
                CustomTextFormField(
                  controller: _passwordController,
                  hintText: '* * * * * *',
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'passwordIsEmptyError'.tr();
                    }
                    else if (value.length < 5) {
                      return 'passwordIsShortError'.tr();
                    }
                  },
                  onSaved: (value) {
                    _user.password = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'confirm_password_dot'.tr(),
                  style: kInputTextStyle,
                ),
                CustomTextFormField(
                  controller: _confirmPasswordController,
                  hintText: '* * * * * *',
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'passwordIsEmptyError'.tr();
                    }
                    else if(value != _passwordController.text){
                      return 'passwordDoesntSatisfy'.tr();
                    }
                  },
                  error: _confirmPasswordController.text != _passwordController.text ? 'passwordDoesntSatisfy'.tr() : null,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                ),
                Center(
                  child: Text(
                    'step'.tr() + ' 1',
                    style: kInputTextStyle,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  value: 0.3,
                  minHeight: 5,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onPressed: () async{
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    else{
                      _user.username = _usernameController.text;
                      _user.password = _passwordController.text;
                      _checkInternetConnection().then((value) async {
                        if(value){
                          bool userExists = await Provider.of<User>(context, listen: false).checkUsername(_user.username);
                          setState(() {
                            _userExists = userExists;
                          });
                          if(_userExists == false){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => QuestionnairePage(user: _user),
                            ),);
                          }
                          else{
                            _formKey.currentState.validate();
                            setState(() {
                              _userExists = false;
                            });
                          }
                        }
                        else{
                          _showErrorDialog('connect_to_internet'.tr());
                        }
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
    );
  }
}
