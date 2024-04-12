import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatInput extends StatelessWidget {
  const ChatInput(
      {super.key, required this.controller, required this.onPressed});

  final TextEditingController controller;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            width: 100,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.chat),
                hintText: 'Enter Your Message....',
                filled: true,
              ),
            ),
          ),
        ),
        IconButton.filledTonal(
          onPressed: onPressed,
          icon: const Icon(Icons.send),
          padding: const EdgeInsets.all(10),
        )
      ],
    );
  }
}
