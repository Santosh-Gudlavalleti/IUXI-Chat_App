import 'package:chat_app/views/chats.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final myController = TextEditingController();

  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString("name");
    if (name != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Chats(
                    source: name,
                  )));
    }
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50.0),
              Container(
                child: Text(
                  "Hi There",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 18),
                ),
              ),
              SizedBox(height: 30.0),
              TextField(
                decoration: InputDecoration(hintText: "Enter your name"),
                controller: myController,
              ),
              SizedBox(height: 30.0),
              RaisedButton(
                child: Text("Register"),
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString("name", myController.text);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => Chats(source: myController.text)));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
