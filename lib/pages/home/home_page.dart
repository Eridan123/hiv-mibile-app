import 'package:HIVApp/model/consultation.dart';
import 'package:HIVApp/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage> {

  @override
  Widget build(BuildContext context) {
    print('Enter home page');
    super.build(context);
    Provider.of<Consultation>(context, listen: false).getConsultants();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
//              color: Colors.indigo[200],
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/information.png',
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  'information_about_hiv'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).cursorColor,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.basic_information),
              ),
            ),
            Card(
//              color: Colors.indigo[200],
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/test.png',
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  'get_tested_to_hiv'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).cursorColor,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.test_information),
              ),
            ),
            Card(
//              color: Colors.indigo[200],
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/oxygen.png',
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  'hiv_treatment'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).cursorColor,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.treatment),
              ),
            ),
            Card(
//              color: Colors.indigo[200],
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/consult.png',
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  'receive_consultation'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).cursorColor,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.consultation),
              ),
            ),
            Card(
//              color: Colors.indigo[200],
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/add.png',
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  'information_on_arv'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).cursorColor,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.schema_of_arv),
              ),
            ),
            Card(
//              color: Colors.indigo[200],
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/conditions.png',
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  'my_condition'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).cursorColor,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.my_state),
              ),
            ),
            Card(
//              color: Colors.indigo[200],
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(5),
                  child: Image.asset(
                    'assets/images/doc_visit.png',
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                'doctor_visit'.tr(),
                  style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).cursorColor,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.visit_doctor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
