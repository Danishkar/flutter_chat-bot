import 'package:flutter/material.dart';
import 'package:flutter_chat_bot/features/chat/widgets/chat_message.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key, required this.messages});

  final List messages;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return ChatMessage(messages: messages, index: index);
        },
      ),
    );
  }
}
