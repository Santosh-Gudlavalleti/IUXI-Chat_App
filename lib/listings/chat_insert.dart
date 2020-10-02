class ChatInsert {
  String chatTitle;
  String chatMessage;

  ChatInsert({
    this.chatTitle,
    this.chatMessage,
  });

  Map<String, dynamic> toJson() {
    return {'Messager': chatTitle, 'Message': chatMessage};
  }
}
