import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/pref_manager.dart';
import '../routes/routes.dart';
import '../utils/app_themes.dart';
import '../utils/constants.dart';
import '../utils/themebloc/theme_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 3), () => {_loadScreen()});
  }
  _loadScreen() async {
    await Prefs.load();
    context.bloc<ThemeBloc>().add(ThemeChanged(
    theme: Prefs.getBool(Prefs.DARKTHEME, def: false)
    ? AppTheme.DarkTheme
        : AppTheme.LightTheme));
    if(Prefs.getString('language') == null)
      Navigator.of(context).pushReplacementNamed(Routes.chooseLanguage);
    else
      Navigator.of(context).pushReplacementNamed(Routes.chooseRegistration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Theme.of(context).splashColor,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height:150,
                    child: Image.asset(
                      'assets/images/ribbon1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Center(
                    child: Text('Logo',
                      style:
                        TextStyle(
                            fontSize: 35,
                          color: Colors.white,
                        )
                      ,),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: kColorPink,
                        size: 48,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'HIV',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: 'APP',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 150,
              height: 2,
              child: LinearProgressIndicator(
                backgroundColor: kColorBlue,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
          ],
        ),
      ),
    );
  }
}
