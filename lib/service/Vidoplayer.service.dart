import 'dart:io';

import 'package:blackcoffer/controller/instance.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerService {
  late VideoPlayerController videoPlayerController;
  Future initVideoPlayer(url) async {
    try {
      videoPlayerController = VideoPlayerController.network(url);

      videoPlayerController.addListener(() {});
      await videoPlayerController.setLooping(false);
      await videoPlayerController.initialize().then((value) =>  videoPlayerController.play());
      InstanceMemb.videoController.getVideoDuration(await videoPlayerController.runtimeType, await videoPlayerController.position);

     

    } catch (error) {
      print(error.toString());
    }


    // await _videoPlayerController.setLooping();
  }
}
