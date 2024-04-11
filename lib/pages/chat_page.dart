import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  void onPressed() {
    print("Justt");
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
          Expanded(child: Container(child: const Text("Hello"))),
          Container(
              child: Row(
            children: [
              const Expanded(
                child: SizedBox(
                  width: 100,
                  child: TextField(
                    decoration: InputDecoration(
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
          ))
        ],
      ),
    );
  }
}
