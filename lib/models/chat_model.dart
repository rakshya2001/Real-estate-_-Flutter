import 'package:flutter/cupertino.dart';

class ChatMessage {
  String messageContent;
  String messageType;
  String username;
  ChatMessage({required this.messageContent, required this.messageType,
  required this.username
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageContent: json['messageContent'],
      messageType: json['messageType'],
      username: json['username'],
    );
  }
}
