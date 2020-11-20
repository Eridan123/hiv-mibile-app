import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MoodPage extends StatefulWidget {
  @override
  _MoodPageState createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('my_condition'.tr() + ' / ' + 'mood'.tr()),
      ),
      body: Container(),
    );
  }
}
