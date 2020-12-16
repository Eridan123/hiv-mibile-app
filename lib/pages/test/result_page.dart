import 'package:HIVApp/components/custom_button.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class TestResultPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text('risk_result'.tr()),
        ),
        body: Container(
          child: CustomButton(
            text: 'home'.tr(),
            onPressed: (){
              Navigator.pushNamed(context, Routes.home);
            },
          )
        ));
  }
}
