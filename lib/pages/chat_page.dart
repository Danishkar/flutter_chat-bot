import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  final List _messages = [
    {'message': "Hello! How can I assist you today?", 'isBot': true},
  ];

  void onPressed() {
    var userMessage = _controller.text;
    if (userMessage != "") {
      setState(() {
        _messages.add({'message': userMessage, 'isBot': false});
        _controller.clear();
      });
      getChatCompletion(userMessage);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Center(child: Text("Enter a message")),
        duration: const Duration(milliseconds: 900),
        width: 150.0,
        padding: const EdgeInsets.all(10.0),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ));
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
        _messages.add({'message': responseData["gptAnswer"], 'isBot': true});
      });
    } else {
      setState(() {
        _messages.add({
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
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(5),
                      width: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: _messages[index]['isBot']
                              ? const Color.fromARGB(255, 224, 224, 224)
                              : Colors.blue[100]),
                      child: Text(
                        '${_messages[index]['message']}',
                        textDirection: _messages[index]['isBot']
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        style: const TextStyle(fontSize: 15),
                      ),
                    );
                  })),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: 100,
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.chat),
                      hintText: 'Enter Your Message....',
                      filled: true,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.send),
                padding: const EdgeInsets.all(10),
              )
            ],
          )
        ],
      ),
    );
  }
}
