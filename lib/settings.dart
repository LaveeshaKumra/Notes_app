import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:todolist/theme.dart';

import 'custom_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  static bool isSwitched=false;
  //SharedPreferences prefs = await SharedPreferences.getInstance();

  void _changeTheme(BuildContext buildContext, MyThemeKeys key) {
    CustomTheme.instanceOf(buildContext).changeTheme(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body:Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Night mode',style: TextStyle(fontSize: 16.0),),
              ),),

              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    if(isSwitched==true) {
                      _changeTheme(context, MyThemeKeys.DARKER);
                    }
                    else {
                      _changeTheme(context, MyThemeKeys.LIGHT);
                    }

                  });
                },
                activeTrackColor: Colors.grey,
                activeColor: Colors.black,
              ),



            ],
          ),
          Divider(),

        ],
      ),
    );
  }
}
