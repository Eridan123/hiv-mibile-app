import 'package:HIVApp/components/custom_button.dart';
import 'package:HIVApp/components/text_form_field.dart';
import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/model/user.dart';
import 'package:HIVApp/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangePasswordPage extends StatefulWidget {

  bool fromChangePassword = true;

  ChangePasswordPage(this.fromChangePassword);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  final _passwordController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _oldPasswordIsSame = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _fromChangePassword = true;

  void _checkOldPassword(String old_password){
    setState(() {
      _oldPasswordIsSame = old_password != Prefs.getString(Prefs.PASSWORD);
    });
  }

  @override
  void initState() {
    _fromChangePassword = widget.fromChangePassword;
    super.initState();
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 38),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _fromChangePassword ? Text(
                              'old_password'.tr(),
                              style: kInputTextStyle.copyWith(fontSize: 20),
                            ): Container(),
                            _fromChangePassword ? CustomTextFormField(
                              controller: _oldPasswordController,
                              hintText: '* * * * * *',
                              obscureText: true,
                              onChanged: (value){_checkOldPassword(value);},
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'passwordIsEmptyError'.tr();
                                }
                                else if(_oldPasswordIsSame){
                                  return 'passwordDoesntSatisfy'.tr();
                                }
                              },
                            ) : Container(),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                            Text(
                              'password'.tr(),
                              style: kInputTextStyle.copyWith(fontSize: 20),
                            ),
                            CustomTextFormField(
                              controller: _passwordController,
                              hintText: '* * * * * *',
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'confirm_password_dot'.tr(),
                              style: kInputTextStyle.copyWith(fontSize: 20),
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
                            ),
                            SizedBox(
                              height: 35,
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
                                  Prefs.setString(Prefs.PASSWORD, _passwordController.text);
                                  Provider.of<User>(context, listen: false).setPassword(_passwordController.text).then((value) {
                                    Navigator.of(context).pop();
                                    if(!_fromChangePassword){
                                      Navigator.of(context).pop();
                                    }
                                    });
                                }
                              },
                              text: 'change_password'.tr(),
                            ),
                          ],
                        ),
                      ),
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
