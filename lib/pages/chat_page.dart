import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  final List _entries = [
    {'message': "Hello, How can I help?", 'isBot': true},
    {'message': "Hello", 'isBot': false},
  ];

  void onPressed() {
    var userMessage = _controller.text;
    if (userMessage != "") {
      setState(() {
        _entries.add({'message': userMessage, 'isBot': false});
        _controller.clear();
      });
    } else {
      print("no Message");
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
                  itemCount: _entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.all(5),
                      width: 10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: _entries[index]['isBot']
                              ? const Color.fromARGB(255, 224, 224, 224)
                              : Colors.blue[100]),
                      child: Text(
                        '${_entries[index]['message']}',
                        textDirection: _entries[index]['isBot']
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
