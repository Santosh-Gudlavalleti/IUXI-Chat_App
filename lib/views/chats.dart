import 'package:chat_app/apis/api.dart';
import 'package:chat_app/login/logout.dart';
import 'package:chat_app/views/message.dart';
import 'package:chat_app/views/createmessage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../listings/apiresponse.dart';
import '../listings/chatlisting.dart';

class Chats extends StatefulWidget {
  final String source;

  Chats({this.source});
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  ChatService get service => GetIt.instance<ChatService>();

  APIResponse<List<ChatListing>> _response;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchNote();
    super.initState();
  }

  _fetchNote() async {
    setState(() {
      _isLoading = true;
    });

    _response = await service.getChatList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hi ${widget.source}'),
          centerTitle: true,
        ),
        floatingActionButton: SpeedDial(
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 30.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          visible: true,
          // If true user is forced to close dial manually
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,

          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.blue[200],
          foregroundColor: Colors.black,
          elevation: 60.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.message),
                backgroundColor: Colors.blue,
                label: 'Send Message',
                labelStyle: TextStyle(fontSize: 21.0),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CreateMessage(source: widget.source)))),
            SpeedDialChild(
                child: Icon(Icons.power_settings_new),
                backgroundColor: Colors.red,
                label: 'Logout',
                labelStyle: TextStyle(fontSize: 21.0),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => LogOut(name: widget.source)))),
          ],
        ),
        body: Builder(builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_response.error) {
            return Center(child: Text(_response.errorMessage));
          }

          return ListView.separated(
            separatorBuilder: (_, __) =>
                Container(child: Divider(height: 25, color: Colors.blue)),
            itemBuilder: (_, index) => ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  _response.data[index].chatTitle,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 21),
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  _response.data[index].chatMessage,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 15),
                  maxLines: 1,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => Message(
                          source: _response.data[index].chatTitle,
                          message: _response.data[index].chatMessage,
                          name: widget.source,
                        )));
              },
            ),
            itemCount: _response.data.length,
          );
        }));
  }
}
