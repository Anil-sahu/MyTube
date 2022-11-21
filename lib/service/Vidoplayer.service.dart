// import 'dart:io';

// import 'package:blackcoffer/controller/instance.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:video_player/video_player.dart';

// class VideoPlayerService extends GetxController{
//   late VideoPlayerController videoPlayerController;
//   Future initVideoPlayer(url) async {
//     try {
//       videoPlayerController = VideoPlayerController.network(url)
//         ..addListener(() {})
//         ..setLooping(false)
//         ..initialize().then((value) =>
        
//          videoPlayerController.pause()).onError((error, stackTrace){print("Error $error");});
//       InstanceMemb.videoController.getVideoDuration(
//          videoPlayerController.runtimeType,
//           await videoPlayerController.position);
//     } catch (error) {
//       print(error.toString());
//     }

//     // await _videoPlayerController.setLooping();
//   }
// }
