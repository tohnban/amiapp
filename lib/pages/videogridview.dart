import 'package:ami_projecto/models/video.dart';
import 'package:ami_projecto/pages/videoplayerscreen.dart';
import 'package:flutter/material.dart';

class VideoGridView extends StatelessWidget {
  final List<Video> videos;

  const VideoGridView({Key? key, required this.videos}) : super(key: key);

  String getThumbnailUrl(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/0.jpg'; // URL da miniatura
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        Video video = videos[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    VideoPlayerScreen(videos: videos, initialIndex: index),
              ),
            );
          },
          child: Card(
            child: Center(
              child: Image.network(
                getThumbnailUrl(video.id), // Exibe a miniatura do vídeo
                fit: BoxFit.cover, // Ajusta o tamanho da imagem
                width: double.infinity,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey[700],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
