import 'package:flutter/foundation.dart';
import 'package:sparrow/models/chat_model.dart';


class MessageProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  addNewMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }
}