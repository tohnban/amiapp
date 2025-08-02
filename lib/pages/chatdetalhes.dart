import 'package:flutter/material.dart';

class ChatDetailPage extends StatelessWidget {
  final String title;
  final String message;

  const ChatDetailPage({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
