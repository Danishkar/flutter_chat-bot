import 'package:flutter/material.dart';
import 'package:flutter_chat_bot/features/chat/models/message.dart';
import 'package:flutter_chat_bot/features/chat/widgets/chat_input.dart';
import 'package:flutter_chat_bot/features/chat/widgets/chat_list.dart';
import 'package:flutter_chat_bot/provider/message_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_chat_bot/utils/notification.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatPageState();
}

class _ChatPageState extends State<Chat> {
  final _controller = TextEditingController();
  late MessageProvider provider;

  void onPressed() {
    var userMessage = _controller.text;
    provider = Provider.of<MessageProvider>(context, listen: false);
    if (userMessage != "") {
      provider.addMessage(Message(message: userMessage, isBot: false));
      provider.setLoading(true);
      _controller.clear();
      getChatCompletion(userMessage);
    } else {
      Notify.showMessage(context, "Enter a message");
    }
  }

  Future<void> getChatCompletion(String userMessage) async {
    var response = await http.post(
      Uri.parse(dotenv.env['CHAT_COMPLETION_URL']!),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'prompt': userMessage,
      }),
    );
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      provider
          .addMessage(Message(message: responseData["gptAnswer"], isBot: true));
      provider.setLoading(false);
    } else {
      provider.addMessage(Message(
          message: "An error occurred, please try again!!", isBot: true));
      provider.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final messageProvider = context.watch<MessageProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Chat Bot")),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[700],
      ),
      body: Column(
        children: [
          ChatList(messages: messageProvider.messages),
          messageProvider.loading
              ? LoadingAnimationWidget.waveDots(
                  color: const Color(0xFF1A1A3F),
                  size: 50,
                )
              : Container(),
          ChatInput(controller: _controller, onPressed: onPressed)
        ],
      ),
    );
  }
}
