import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/model/user.dart';
import 'package:HIVApp/pages/diary/diary_page.dart';
import 'package:HIVApp/pages/map/map_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../routes/routes.dart';
import '../../utils/constants.dart';
import '../settings/settings_page.dart';
import 'home_page.dart';
import 'widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  int _selectedIndex = 0;

  var _isDark = Prefs.getBool(Prefs.DARKTHEME, def: false);
  Color _color;
  String image_file_path = 'assets/images/';

  @override
  void initState() {
    super.initState();
    _color = _isDark ? Colors.indigo[100] : Colors.grey[200];
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _selectPage(int index) {
    if(index == 0)
      return HomePage();
    else if(index == 1)
      return DiaryPage();
    else if(index == 2)
      return MapPage();
    else
      return SettingsPage();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
//        HomePage(),
        ClipRRect(
          child: Scaffold(
//              backgroundColor: _color,
            appBar: AppBar(
              elevation: 0,
//                backgroundColor: Colors.indigo[100],
              leading:  Container(
                padding: EdgeInsets.all(5),
                child: Image.asset(
                  image_file_path+'ribbon1.png',
//                  color: _isDark ? Colors.white : kColorPrimary,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                Prefs.getString(Prefs.USERNAME) == null ? 'guest'.tr() : Prefs.getString(Prefs.USERNAME),
                style: TextStyle(
                  color: Theme.of(context).focusColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    if (Prefs.USER_ID != null)
                    Provider.of<User>(context, listen: false).logout();
                    Navigator.of(context)
                        .popAndPushNamed(Routes.login);
                  },
                  child: FaIcon(FontAwesomeIcons.signOutAlt, color: Theme.of(context).focusColor,),
                ),
              ],
            ),
            body: Container(
              child: _selectPage(_selectedIndex),
            ),
            floatingActionButton: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0x202e83f8),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    Navigator.of(context).pushNamed(Routes.add);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).buttonColor,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: ClipRect(
              child: BottomAppBar(
                color: Theme.of(context).bottomAppBarColor,
                elevation: 0,
                shape: CircularNotchedRectangle(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: NavBarItemWidget(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                        iconData: Icons.home,
                        text: 'home'.tr(),
                        color: _selectedIndex == 0 ? kColorLightBlue : Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: NavBarItemWidget(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                        iconData: Icons.account_box,
                        text: 'diary'.tr(),
                        color: _selectedIndex == 1 ? kColorLightBlue : Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 1,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: NavBarItemWidget(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        },
                        iconData: Icons.location_on,
                        text: 'map'.tr(),
                        color: _selectedIndex == 2 ? kColorLightBlue : Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: NavBarItemWidget(
                        onTap: () {
                          setState(() {
                            _selectedIndex = 3;
                          });
                        },
                        iconData: Icons.more_horiz,
                        text: 'more'.tr(),
                        color: _selectedIndex == 3 ? kColorLightBlue : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
