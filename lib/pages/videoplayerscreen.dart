import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/video.dart';

class VideoPlayerScreen extends StatefulWidget {
  final List<Video> videos;
  final int initialIndex;

  const VideoPlayerScreen({
    Key? key,
    required this.videos,
    required this.initialIndex,
  }) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late PageController _pageController;
  late YoutubePlayerController _youtubeController;
  bool isLive = false;

  @override
  void initState() {
    super.initState();
    isLive = widget.videos[widget.initialIndex].isLive == true;
    _pageController = PageController(initialPage: widget.initialIndex);
    _youtubeController = YoutubePlayerController(
      initialVideoId: widget.videos[widget.initialIndex].id,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )..addListener(_checkVideoEnd);
  }

  void _checkVideoEnd() {
    if (isLive) return; // Não verificar o fim para vídeos ao vivo

    final controllerValue = _youtubeController.value;
    if (controllerValue.isReady &&
        !controllerValue.isPlaying &&
        controllerValue.position >= controllerValue.metaData.duration) {
      _youtubeController.seekTo(Duration.zero);
      _youtubeController.play();
    }
  }

  @override
  void dispose() {
    _youtubeController.removeListener(_checkVideoEnd);
    _youtubeController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ami',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontFamily: 'CustomFont',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.green),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: widget.videos.length,
        itemBuilder: (context, index) {
          final video = widget.videos[index];
          final controller = YoutubePlayerController(
            initialVideoId: video.id,
            flags: YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          );

          bool isRestarting = false;

          controller.addListener(() {
            if (video.isLive == false) {
              if (controller.value.isReady) {
                final position = controller.value.position;
                final duration = controller.metadata.duration;

                if (duration.inSeconds > 0 &&
                    position.inSeconds >= duration.inSeconds - 1 &&
                    !isRestarting) {
                  isRestarting = true;
                  controller.seekTo(Duration.zero);
                  controller.play();
                }

                if (position == Duration.zero && isRestarting) {
                  isRestarting = false;
                }
              }
            }
          });

          return YoutubePlayer(
            controller: controller,
            showVideoProgressIndicator: true,
            progressColors: const ProgressBarColors(
              playedColor: Colors.green, // Barra de progresso verde
              handleColor: Colors.greenAccent, // Manipulador verde claro
            ),
          );
        },
      ),
    );
  }
}
