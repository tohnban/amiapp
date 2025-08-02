import 'package:flutter/material.dart';

import '../models/video.dart';
import 'videoplayerscreen.dart';

class VideoList extends StatefulWidget {
  final List<Video> videos;

  const VideoList({Key? key, required this.videos}) : super(key: key);

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  int? _visibleOptionsIndex;

  String getThumbnailUrl(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.videos.length,
      itemBuilder: (context, index) {
        Video video = widget.videos[index];

        return Card(
          color: Theme.of(context).cardColor,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 70,
                  child: Image.network(
                    getThumbnailUrl(video.id),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child:
                            Icon(Icons.broken_image, color: Colors.grey[700]),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                              videos: widget.videos, initialIndex: index),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                            Row(
                              children: [
                                const Icon(Icons.play_arrow,
                                    color: Colors.green),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _visibleOptionsIndex =
                                          _visibleOptionsIndex == index
                                              ? null
                                              : index;
                                    });
                                  },
                                  child: const Icon(Icons.more_vert),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (_visibleOptionsIndex == index)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    widget.videos.removeAt(index);
                                    _visibleOptionsIndex = null;
                                  });
                                },
                                child: const Text('Remover'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _visibleOptionsIndex = null;
                                  });
                                },
                                child: const Text('Editar'),
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
      },
    );
  }
}
