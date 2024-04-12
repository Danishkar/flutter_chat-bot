import 'package:flutter/material.dart';
import 'package:flutter_chat_bot/features/chat/widgets/chat_input.dart';
import 'package:flutter_chat_bot/features/chat/widgets/chat_list.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_chat_bot/utils/notification.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatPageState();
}

class _ChatPageState extends State<Chat> {
  final _controller = TextEditingController();

  final List messages = [
    {'message': "Hello! How can I assist you today?", 'isBot': true},
  ];
  bool loading = false;

  void onPressed() {
    var userMessage = _controller.text;
    if (userMessage != "") {
      setState(() {
        messages.add({'message': userMessage, 'isBot': false});
        _controller.clear();
        loading = true;
      });
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
      setState(() {
        loading = false;
        messages.add({'message': responseData["gptAnswer"], 'isBot': true});
      });
    } else {
      setState(() {
        loading = false;
        messages.add({
          'message': "An error occurred, please try again!!",
          'isBot': true
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Chat Bot")),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[700],
      ),
      body: Column(
        children: [
          ChatList(messages: messages),
          loading
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
