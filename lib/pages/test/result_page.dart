import 'dart:ffi';

import 'package:HIVApp/components/custom_button.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TestResultPage extends StatelessWidget {
  double value;


  TestResultPage({this.value});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text('risk_result'.tr()),
        ),
        body: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.2,),
          child: Center(
            child: Column(
              children: [
                CircularPercentIndicator(
                  radius: MediaQuery.of(context).size.width * 0.6,
                  lineWidth: 20.0,
                  percent: value==100 ? value/100 :value%100/100,
                  center: new Text(value.toString()+'%'),
                  progressColor: value <30 ? Colors.green : value <60 ? Colors.blue : Colors.red,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: CustomButton(
                    text: 'home'.tr(),
                    onPressed: (){
                      Navigator.pushNamed(context, Routes.home);
                    },
                  ),
                ),
              ],
            ),
          )
        ));
  }
}
