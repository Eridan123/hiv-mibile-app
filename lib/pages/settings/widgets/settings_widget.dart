import 'package:HIVApp/data/pref_manager.dart';
import 'package:HIVApp/model/user_registrations.dart';
import 'package:HIVApp/pages/settings/widgets/change_password.dart';
import 'package:HIVApp/utils/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:term_glyph/term_glyph.dart';

import '../../../routes/routes.dart';

class SettingsWidget extends StatefulWidget {
  final Color color;

  const SettingsWidget({Key key, @required this.color}) : super(key: key);
  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {

  @override
  void initState() {
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          color: widget.color,
          padding: EdgeInsets.all(15),
          child: Text(
            'settings'.tr(),
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ListTile(
          leading: Text(
                  'notification_settings'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
          onTap: () =>
              Navigator.of(context).pushNamed(Routes.notificationSettings),
        ),
        Prefs.getString(Prefs.USERNAME) != null ?ListTile(
          leading: Text(
            'password_change'.tr(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChangePasswordPage(true),
          ),),
        ) : Container(),
        ListTile(
          leading: Text(
            'password_reset'.tr(),
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.grey,
          ),
          onTap: () => Navigator.of(context).pushNamed(Routes.resetPassword),
        ),
      ],
    );
  }
}
