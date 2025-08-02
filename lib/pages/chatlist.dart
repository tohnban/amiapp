import 'package:ami_projecto/pages/chatdetalhes.dart';
import 'package:flutter/material.dart';

class ChatListTab extends StatelessWidget {
  const ChatListTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Simulação de 10 conversas
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            child: Text('C$index'),
          ),
          title: Text('Conversa $index'),
          subtitle: Text('Última mensagem da conversa $index'),
          trailing: Text('12:00'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailPage(
                  title: 'Conversa $index',
                  message: 'Última mensagem da conversa $index',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
