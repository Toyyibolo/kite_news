import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {


  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  String videoUrl = "https://media-hosting.imagekit.io/56587fe5ee8b45f9/Red and White General News Breaking News Video.mp4?Expires=1839767960&Key-Pair-Id=K2ZIVPTIP2VGHC&Signature=KMP1gLMJprYImmnOX7rVg2enVpzsY8L75rgnSs~OPKLjwV5-kuO3oY1ARiwOnz5F4JJHCcl0EHMIlH4Op-xAjCFuVfjsUESI7f4bgyz6ocotRX2XaWneKfP6b8Xd5B43TmKs~dNgEkJZAeUlykiI3EZ3Qz8kL0TRRTdJPEHsNhlmiCPPtf8y9nEb2lNNYMInphIqDLWfqf0~xK4fipDUd6Yul6gewgNrg-6Nn6ER9NJ3xpsTmBvliA1m5soBr-Zu8HcI0sZxGsCUTOdjTgoz2udFtiWWKScdk-ID2AAUqHEec6yVKcU0No4gzUGKrgZo3gfE5enhfBqvfzZtjCXcvA__ ";


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        debugPrint("Video initialized");
        setState(() {});
        _controller.play();
      }).catchError((e) {
        debugPrint("Failed to initialize: $e");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: _controller.value.isInitialized
            ? SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: FittedBox(
            fit: BoxFit.cover,
            clipBehavior: Clip.hardEdge,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            ),
          ),
        )
            : SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Center(child: const CircularProgressIndicator())),
      );

  }
}
