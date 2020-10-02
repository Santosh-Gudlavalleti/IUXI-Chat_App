import 'package:chat_app/views/createmessage.dart';
import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  final String source;
  final String message;
  final String name;

  Message({this.source, this.message, this.name});
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('From ${widget.source}', style: TextStyle(fontSize: 25)),
        content: Text(
          widget.message,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('Ok', style: TextStyle(fontSize: 21)),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          FlatButton(
              child: Text('Reply', style: TextStyle(fontSize: 21)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CreateMessage(source: widget.name)));
              }),
        ]);
  }
}
