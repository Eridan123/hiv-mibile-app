import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../db/notification.dart';
import '../../db/db_provider.dart';

class VisitPage extends StatefulWidget {
  @override
  _VisitPageState createState() => _VisitPageState();
}

class _VisitPageState extends State<VisitPage> {

  List<NotificationDb> _list = new List<NotificationDb>();

  _getListOfNotifications() async{
    await DBProvider.db.getNotificationsByType(NotificationDbType.Visit).then((value) {
      setState(() {
        _list = value;
      });
    });
  }

  @override
  void initState() {
    _getListOfNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('doctor_visit'.tr()),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text()
            ],
          ),
        )
    );
  }
}
