import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../empty_page.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage>
    with AutomaticKeepAliveClientMixin<TestPage> {

  bool _isdark = Prefs.getBool(Prefs.DARKTHEME, def: false);

  var _kTabs = [
    Tab(
      text: 'Секс',
    ),
    Tab(
      text: 'Кровь',
    ),
    Tab(
      text: 'Симптомы',
    ),
  ];

  final _kTabTextStyle = TextStyle(
    color: kColorBlue,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
  );

  final _kTabPages = [
    EmptyPage(),
    EmptyPage(),
    EmptyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('screening_on_hiv'.tr()),
      ),
      body: Column(
        children: [
          Expanded(
            child: DefaultTabController(
              length: _kTabs.length,
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: _isdark
                          ? Colors.white.withOpacity(0.12)
                          : Color(0xfffbfcff),
                      border: Border(
                        top: BorderSide(
                          width: 1,
                          color: _isdark ? Colors.black87 : Colors.grey[200],
                        ),
                        bottom: BorderSide(
                          width: 1,
                          color: _isdark ? Colors.black87 : Colors.grey[200],
                        ),
                      ),
                    ),
                    child: TabBar(
                      indicatorColor: kColorBlue,
                      labelStyle: _kTabTextStyle,
                      unselectedLabelStyle:
                      _kTabTextStyle.copyWith(color: Colors.grey),
                      labelColor: kColorBlue,
                      unselectedLabelColor: Colors.grey,
                      tabs: _kTabs,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: _kTabPages,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
