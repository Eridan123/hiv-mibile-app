import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../components/custom_button.dart';
import '../../components/text_form_field.dart';
import '../../routes/routes.dart';
import '../../utils/constants.dart';

class SuccessfullRegistrationPage extends StatelessWidget {
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
                          height: 60,
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                'successfull_registration_text'.tr(),
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 5,
                                softWrap: true ,
                              ),
                            ),
                            CustomButton(
                              onPressed: () {
                                Navigator.of(context).popAndPushNamed(Routes.pin_code);
                              },
                              text: 'set_pin_code'.tr(),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              onPressed: () {
                                Navigator.of(context).popAndPushNamed(Routes.home);
                              },
                              text: 'no_need_pin_code'.tr(),
                            ),
                            SizedBox(
                              height: 40,
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
            ),
          );
        },
      ),
    );
  }
}

class SuccessfullRegistration extends StatefulWidget {
  @override
  _SuccessfullRegistrationState createState() => _SuccessfullRegistrationState();
}

class _SuccessfullRegistrationState extends State<SuccessfullRegistration> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'email_dot'.tr(),
          style: kInputTextStyle,
        ),
        CustomTextFormField(
          controller: _emailController,
          hintText: 'bhr.tawfik@gmail.com',
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
        ),
        SizedBox(
          height: 35,
        ),
        CustomButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed(Routes.home);
          },
          text: 'login'.tr(),
        )
      ],
    );
  }
}
