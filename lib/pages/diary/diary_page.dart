import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/pages/examination/examination_page.dart';
import 'package:HIVApp/pages/test/test_page.dart';
import 'package:HIVApp/pages/visit/visit_page.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:HIVApp/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final _kTabTextStyle = TextStyle(
    color: kColorBlue,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  final _kTabPages = [
    VisitPage(),
    ExaminationPage(),
    TestPage(),
  ];

  @override
  Widget build(BuildContext context) {
    print('Enter profile');
//    super.build(context);
    bool _isdark = Prefs.getBool(Prefs.DARKTHEME, def: false);

    var _kTabs = [
      Tab(
        text: 'Секс',
      ),
      Tab(
        text: 'Кровь'.tr(),
      ),
      Tab(
        text: 'Симптомы'.tr(),
      ),
    ];

    return Column(
      children: <Widget>[
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
