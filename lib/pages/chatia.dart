import 'package:ami_projecto/pages/chatdetalhes.dart';
import 'package:flutter/material.dart';

class AmiIaTab extends StatelessWidget {
  const AmiIaTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 15, // Mensagens simuladas
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: index % 2 == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatDetailPage(
                            title: 'Ami-IA Mensagem $index',
                            message: index % 2 == 0
                                ? 'Mensagem da Ami-IA $index'
                                : 'Minha mensagem $index',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.blue[100]
                            : Colors.green[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        index % 2 == 0
                            ? 'Mensagem da Ami-IA $index'
                            : 'Minha mensagem $index',
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Digite sua mensagem...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  // Função para enviar mensagem
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
