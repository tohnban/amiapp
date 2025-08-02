import 'package:ami_projecto/pages/chatia.dart';
import 'package:ami_projecto/pages/chatlist.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mensagens'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.chat), text: 'Conversas'),
              Tab(icon: Icon(Icons.smart_toy), text: 'Ami-IA'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ChatListTab(),
            AmiIaTab(),
          ],
        ),
      ),
    );
  }
}
