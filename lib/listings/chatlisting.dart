class ChatListing {
  String chatID;
  String chatTitle;
  String chatMessage;

  ChatListing({
    this.chatID,
    this.chatTitle,
    this.chatMessage,
  });

  factory ChatListing.fromJson(Map<String, dynamic> items) {
    return ChatListing(
      chatID: items["id"] as String,
      chatTitle: items["Messager"] as String,
      chatMessage: items["Message"] as String,
    );
  }
}
