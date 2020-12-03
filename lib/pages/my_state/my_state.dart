import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/db/db_provider.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MyStatePage extends StatefulWidget {
  @override
  _MyStatePageState createState() => _MyStatePageState();
}

class _MyStatePageState extends State<MyStatePage> {

  String image_file_path = 'assets/images/';
  var dark = Prefs.getBool(Prefs.DARKTHEME, def: false) ? '1.png':'.png';

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('my_condition'.tr()),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment(-0.3,-1.0),
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(5),
                        child: Image.asset(
                          image_file_path+'symptoms'+dark,
                          fit: BoxFit.fill,
                        ),
                      ),
                      title: Text(
                        'symptoms'.tr(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () => Navigator.pushNamed(context, Routes.symptom)
                  ),
                  SizedBox(height: 10,),
                  ListTile(
                      leading: Container(
                        padding: EdgeInsets.all(5),
                        child: Image.asset(
                          image_file_path+'mood'+dark,
                          fit: BoxFit.fill,
                        ),
                      ),
                      title: Text(
                        'mood'.tr(),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                      onTap: () => Navigator.pushNamed(context, Routes.mood)
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


