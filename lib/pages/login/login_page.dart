import 'dart:io';

import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/model/auth.dart';
import 'package:HIVApp/model/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../components/custom_button.dart';
import '../../components/text_form_field.dart';
import '../../routes/routes.dart';
import '../../utils/constants.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 38),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: 80,
                        ),
                      ),
                      Text(
                        'sign_in'.tr(),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      WidgetSignin(),
                      Center(
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(Routes.forgotPassword);
                          },
                          child: Text(
                            'forgot_yout_password'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(fontSize: 12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 20,
                        ),
                      ),
                      SafeArea(
                        child: Column(
                          children: [
                            Center(
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      'dont_have_an_account'.tr(),
                                      style: TextStyle(
                                        color: Color(0xffbcbcbc),
                                        fontSize: 12,
                                        fontFamily: 'NunitoSans',
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(2),
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushNamed(Routes.signup);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'register_now'.tr(),
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
                            Center(
                              child: Wrap(
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(2),
                                    onTap: () {
                                      Prefs.setBool(Prefs.WITH_REGISTRATION, false);
                                      Navigator.of(context).popAndPushNamed(Routes.home);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        'without_registration'.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .copyWith(fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class WidgetSignin extends StatefulWidget {
  @override
  _WidgetSigninState createState() => _WidgetSigninState();
}

class _WidgetSigninState extends State<WidgetSignin> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isLoading = false;

  Map<String, String> _authData = {
    'username': '',
    'password': '',
  };

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

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }

    _checkInternetConnection().then((value) async {
      if(value){
        _formKey.currentState.save();
        setState(() {
          _isLoading = true;
        });
        try{
          await Provider.of<User>(context, listen: false).login(
            _authData['username'],
            _authData['password'],
          ).then((value) => Navigator.of(context).pushNamed(Routes.home));
        }
        on HttpException catch (error) {
          var errorMessage = 'Аутентификация не выполнено!';
          if (error.toString().contains('INVALID_EMAIL')) {
            errorMessage = 'Не првильный логин';
          } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
            errorMessage = 'Логин не существует';
          } else if (error.toString().contains('INVALID_PASSWORD')) {
            errorMessage = 'Не правильный пароль';
          }
          _showErrorDialog(errorMessage);
        } catch (error) {
          var errorMessage = "notAuthenticatedError".tr();
          if(error.message == 999.toString()){
            errorMessage = "wrongPasswordError".tr();
          }
          else if(error.message == 888.toString()){
            errorMessage = "wrongUsernameError".tr();
          }
          _showErrorDialog(errorMessage);
        }
        setState(() {
          _isLoading = false;
        });
      }
      else{
        _showErrorDialog('connect_to_internet'.tr());
      }
    });

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
          Text(
            'login'.tr(),
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
              _authData['username'] = value;
            },
          ),
          SizedBox(
            height: 20,
          ),
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
              else if (value.length < 3) {
                return 'passwordIsShortError'.tr();
              }
            },
            onSaved: (value) {
              _authData['password'] = value;
            },
          ),
          SizedBox(
            height: 35,
          ),
          if (_isLoading)
            Center(child: CircularProgressIndicator())
          else
          CustomButton(
            onPressed: () {
              _submit(context);
//              Navigator.popAndPushNamed(context, Routes.home);
            },
            text: 'login'.tr(),
          )
        ],
      ),
    );
  }
}
