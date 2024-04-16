import 'package:flutter/material.dart';
import 'package:flutter_chat_bot/features/chat/models/message.dart';

class MessageProvider extends ChangeNotifier {
  final List<Message> _messages = [
    Message(message: "Hello! How can I assist you today?", isBot: true),
  ];

  bool _loading = false;

  get messages => _messages;

  get loading => _loading;

  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }
}
