import 'package:ami_projecto/pages/diretogridview.dart';
import 'package:flutter/material.dart';

import '../models/video.dart';

class DiretoScreen extends StatelessWidget {
  final List<Video> liveVideos = [
    Video(id: 'ZkIvWLIWXwo', isLive: true),
    Video(id: 'aYLXpkWuGAU', isLive: true),
    Video(id: 'yjNp-ZGU8DM', isLive: true),
    Video(id: 'ZWdAv-0APjc', isLive: true),
    Video(id: 'aYLXpkWuGAU', isLive: true),
  ];

  final List<Video> endedVideos = [
    Video(id: 'aYLXpkWuGAU', isLive: false),
    Video(id: 'ZWdAv-0APjc', isLive: false),
    Video(id: '2izp7IJVugs', isLive: false),
    Video(id: 'ZkIvWLIWXwo', isLive: false),
    Video(id: 'aYLXpkWuGAU', isLive: false),
    Video(id: 'yjNp-ZGU8DM', isLive: false),
    Video(id: 'ZWdAv-0APjc', isLive: false),
    Video(id: 'aYLXpkWuGAU', isLive: false),
    Video(id: '2izp7IJVugs', isLive: false),
    Video(id: 'aYLXpkWuGAU', isLive: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text('Directo'),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.green),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de Vídeos ao Vivo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Vídeos ao Vivo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            VideoGridView(videos: liveVideos),

            // Seção de Transmissões Terminadas
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Transmissões Terminadas',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            VideoGridView(videos: endedVideos),
          ],
        ),
      ),
    );
  }
}
