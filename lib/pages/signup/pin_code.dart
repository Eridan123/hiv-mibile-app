import 'package:HIVApp/model/user.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/text_form_field.dart';
import '../../utils/constants.dart';


class PinCodePage extends StatelessWidget {
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
                        'set_pin_code'.tr(),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    PinCode(),
                    Expanded(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
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

class PinCode extends StatefulWidget {
  @override
  PinCodeState createState() => PinCodeState();
}

class PinCodeState extends State<PinCode> {


  final _pinCodeController = TextEditingController();
  final _confirmPinCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 38),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'pin_code'.tr(),
                  style: kInputTextStyle,
                ),
                CustomTextFormField(
                  controller: _pinCodeController,
                  hintText: '* * * * * *',
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'isEmptyError'.tr();
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'confirm_pin_code'.tr(),
                  style: kInputTextStyle,
                ),
                CustomTextFormField(
                  controller: _confirmPinCodeController,
                  hintText: '* * * * * *',
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'isEmptyError'.tr();
                    }
                    else if (value != _pinCodeController.text) {
                      return 'pinCodeNotSameError'.tr();
                    }
                  },
                ),
                SizedBox(
                  height: 35,
                ),
                Center(
                  child: Text(
                    'step'.tr() + ' 1',
                    style: kInputTextStyle,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onPressed: () {
                    if (!_formKey.currentState.validate()) {
                      return;
                    }
                    else {
                      Provider.of<User>(context, listen: false).setPinCode(
                          _pinCodeController.text).then((value) =>
                          Navigator.of(context).pushNamed(Routes.home));
                    }
                  },
                  text: 'set_pin_code'.tr(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
