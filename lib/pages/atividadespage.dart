import 'package:ami_projecto/models/modelatividade.dart';
import 'package:flutter/material.dart';

class AtividadePage extends StatelessWidget {
  final List<Atividade> atividades;

  AtividadePage({required this.atividades});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: atividades.length,
        itemBuilder: (context, index) {
          final atividade = atividades[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12.0),
              leading: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(
                      atividade.imagemUrl ??
                          "https://via.placeholder.com/150", // Imagem padrão
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                atividade.titulo,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Data: ${atividade.data.day}/${atividade.data.month}/${atividade.data.year}",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    atividade.descricao,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetalhesAtividadePage(atividade: atividade),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetalhesAtividadePage extends StatelessWidget {
  final Atividade atividade;

  DetalhesAtividadePage({required this.atividade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(atividade.titulo),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.green),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                      atividade.imagemUrl ??
                          "https://via.placeholder.com/150", // Imagem padrão
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              atividade.titulo,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Data: ${atividade.data.day}/${atividade.data.month}/${atividade.data.year}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              atividade.descricao,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
