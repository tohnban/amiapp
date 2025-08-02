import 'package:ami_projecto/pages/videoplayerscreen.dart';
import 'package:flutter/material.dart';

import '../models/video.dart';

class VideoGridView extends StatelessWidget {
  final List<Video> videos;

  const VideoGridView({Key? key, required this.videos}) : super(key: key);

  String getThumbnailUrl(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/0.jpg'; // URL da miniatura
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(videos.length, (index) {
          Video video = videos[index];
          bool isLive = video.isLive; // Indicador de se o vídeo está ao vivo

          return Card(
            color: Theme.of(context).cardColor,
            margin:
                EdgeInsets.symmetric(vertical: 8.0), // Espaçamento entre vídeos
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Alinhamento do topo
                children: [
                  // Coluna A: Miniatura
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Miniatura
                      Container(
                        width: 100, // Largura da miniatura
                        height: 70, // Altura da miniatura
                        child: Image.network(
                          getThumbnailUrl(
                              video.id), // Exibe a miniatura do vídeo
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: Icon(Icons.broken_image,
                                  color: Colors.grey[700]),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 12), // Espaço entre a coluna A e B
                  // Coluna B: Título e Ícone com ação ao clicar
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Ação ao clicar na coluna
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                                videos: videos, initialIndex: index),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Alinhamento à esquerda
                        children: [
                          // Título
                          Text(
                            'Vídeo ${index + 1}',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (isLive)
                            Text(
                              'Ao Vivo',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Espaço reservado para o título
                              Expanded(
                                child: Text(
                                  'Clique para mais detalhes',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontSize: 12,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Ícone alinhado à direita
                              Icon(
                                isLive ? Icons.live_tv : Icons.play_arrow,
                                color: isLive ? Colors.red : Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
