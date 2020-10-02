import 'package:chat_app/login/register.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogOut extends StatefulWidget {
  final String name;
  LogOut({this.name});

  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Warning', style: TextStyle(fontSize: 25)),
        content: Text('Are you sure to Log Out'),
        actions: <Widget>[
          FlatButton(
              child: Text('Yes', style: TextStyle(fontSize: 18)),
              onPressed: () async {
                //  DefaultCacheManager manager = new DefaultCacheManager();
                //     manager.emptyCache(); //clears all data in cache.
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("name");

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => Register()),
                    (Route<dynamic> route) => false);
              }),
          FlatButton(
            child: Text('No', style: TextStyle(fontSize: 18)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ]);
  }
}
