import 'package:HIVApp/db/db_provider.dart';
import 'package:HIVApp/db/user_symptom.dart';
import 'package:HIVApp/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../data/pref_manager.dart';
import '../../../components/custom_button.dart';
import '../symptom/add_form.dart';


class SymptomChronolgy extends StatefulWidget {

  @override
  _SymptomChronolgyState createState() => _SymptomChronolgyState();
}

class _SymptomChronolgyState extends State<SymptomChronolgy> with TickerProviderStateMixin {
  List<UserSymptom> _list = new List<UserSymptom>();
  DateTime initialDate = DateTime.now();
  String asset_path = "assets/images/symptoms/";

  getList() async{
    await DBProvider.db.getAllUserSymptoms().then((value) {
      if(value.length > 0)
      setState(() {
        _list.addAll(value);
        initialDate = _list.first.date_time;
      });
    });
  }

  @override
  void initState() {
    getList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool compareTwoDates(DateTime date1, DateTime date2){
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.65,
            child: GroupedListView<UserSymptom, String>(
              shrinkWrap: true,
              elements: _list,
              groupBy: (element) => formatter.format(element.date_time),
              groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Divider(),
                    Text(
                      value ,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                  ],
                ),
              ),
              itemBuilder: (context, UserSymptom element) {
                return Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width *0.01),
                  child: ListTile(
                    leading: Image.asset(asset_path + element.file_name),
                    title: Text(element.title.tr()),
                    trailing: SmoothStarRating(
                      allowHalfRating: false,
                      starCount: 5,
                      rating: element.rating,
                      size: 15.0,
                      isReadOnly:true,
                      color: kColorPrimary,
                      borderColor: kColorPrimaryDark,
                      spacing:0.0,
                    ),
                  ),
                );
              },
              itemComparator: (item1, item2) =>
                  item1.date_time.compareTo(item2.date_time),
              order: GroupedListOrder.DESC,
            ),
          ),
        ],
      ),
    );
  }
}
