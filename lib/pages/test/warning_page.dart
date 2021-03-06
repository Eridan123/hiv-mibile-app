import 'package:HIVApp/components/custom_button.dart';
import 'package:HIVApp/pages/test/result_page.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class WarningPage extends StatelessWidget {
  double value;
  double total;


  WarningPage({this.value, this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 1,
        title: Text('warning'.tr()),
    ),
        body:Container(
      child: Center(
          child: Column(
          children: [
            Image.asset('assets/images/warning.png'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text('test_result_warning'.tr(), textAlign: TextAlign.center,),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            CustomButton(
              text: 'continue'.tr(),
              textSize: 25,
              onPressed: (){
                Route route =
                MaterialPageRoute(builder: (context) => TestResultPage(value: value, total: total,));
                Navigator.push(context,route);
              },
            )
          ],
        )
      ),
    )
    );
  }
}
