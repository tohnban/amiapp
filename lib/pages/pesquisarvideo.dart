import 'package:ami_projecto/models/video.dart';
import 'package:ami_projecto/pages/videogridview.dart';
import 'package:flutter/material.dart';

class Pesquisarvideo extends StatefulWidget {
  const Pesquisarvideo({super.key});

  @override
  State<Pesquisarvideo> createState() => _PesquisarvideoState();
}

class _PesquisarvideoState extends State<Pesquisarvideo> {
  final TextEditingController _searchController = TextEditingController();
  List<Video> videos = [
    Video(id: 'ZkIvWLIWXwo', isLive: false),
    Video(id: 'aYLXpkWuGAU', isLive: false),
  ]; // Lista que irá conter os vídeos do YouTube.
  bool showSearchBox = false; // Controle de visibilidade da caixa de pesquisa.

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Função para simular a pesquisa e adicionar vídeos à lista.
  void _searchVideos() {
    setState(() {
      videos = [
        Video(id: 'ZkIvWLIWXwo', isLive: false),
        Video(id: 'aYLXpkWuGAU', isLive: false),
        Video(id: 'yjNp-ZGU8DM', isLive: false),
        Video(id: 'ZWdAv-0APjc', isLive: false),
        Video(id: 'aYLXpkWuGAU', isLive: false),
        // Adicione mais IDs de vídeos.
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ami',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontFamily: 'CustomFont',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.green),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              showSearchBox ? Icons.close : Icons.search,
              color: Colors.green,
            ),
            onPressed: () {
              setState(() {
                showSearchBox = !showSearchBox;
                if (!showSearchBox) {
                  _searchController.clear();
                  videos = [];
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            if (showSearchBox)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40, // Reduzindo a altura da TextField
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0, // Reduzindo o espaçamento interno
                            horizontal: 12.0,
                          ),
                          labelText: 'Escreva aqui...',
                          labelStyle: const TextStyle(
                            fontSize: 14, // Reduzindo o tamanho da fonte
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                                15.0), // Bordas arredondadas
                          ),
                          focusColor: Colors.green[700],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _searchVideos,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16, // Ajuste no tamanho do botão
                      ),
                    ),
                    child: Text(
                      'Pesquisar',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10),
            Expanded(
              child: videos.isEmpty
                  ? const Center(child: Text('Nenhum vídeo encontrado'))
                  : VideoGridView(videos: videos), // Utilizando o VideoGridView
            ),
          ],
        ),
      ),
    );
  }
}
