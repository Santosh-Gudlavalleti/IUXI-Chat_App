import 'dart:convert';
import 'package:chat_app/listings/chat_insert.dart';
import 'package:http/http.dart' as http;
import '../listings/apiresponse.dart';
import '../listings/chatlisting.dart';

class ChatService {
  static const API = 'https://acmcfi.herokuapp.com/v1/graphql';
  var headers = {
    'x-hasura-admin-secret': '*****',
    'content-type': 'application/json'
  };
  //  {
  // 'content-type': 'application/json',
  // 'x-hasura-admin-secret': 'santoshg@18'
  // };

  Future<APIResponse<List<ChatListing>>> getChatList() {
    var data =
        ('{"query":"query MyQuery {\n Chats {\n Message\n Messager\n id\n }\n}\n","variables":null,"operationName":"MyQuery"}');
    return http.post(API, headers: headers, body: data).then((res) {
      if (res.statusCode == 200) {
        final jsonDatas = json.decode(res.body);
        final note = <ChatListing>[];
        for (var items in jsonDatas["data"]["Chats"]) {
          note.add(ChatListing.fromJson(items));
        }
        return APIResponse<List<ChatListing>>(data: note);
      }
      return APIResponse<List<ChatListing>>(
          error: true, errorMessage: 'An Error Occurred');
    }).catchError((_) => APIResponse<List<ChatListing>>(
        error: true, errorMessage: 'An Error  Occurred'));
  }

  Future<APIResponse<bool>> createChat(ChatInsert item) {
    var req =
        '{"query":"mutation MyMutation {\\n  insert_Chats(objects: {Message: \\"${item.chatMessage}\\" , Messager: \\"${item.chatTitle}\\"}) {\\n    affected_rows\\n  }\\n}\\n","variables":null,"operationName":"MyMutation"}';
    return http.post(API, headers: headers, body: req).then((val) {
      if (val.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An Error Occurred');
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: 'An Error Occurred'));
  }
}
