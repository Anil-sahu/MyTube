
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlay extends StatefulWidget {
  var video;
   FullScreenPlay({super.key,required this.video});

  @override
  State<FullScreenPlay> createState() => _FullScreenPlayState();
}

class _FullScreenPlayState extends State<FullScreenPlay> {
  
  late VideoPlayerController videoController;
  playVideo() {
    videoController = VideoPlayerController.network(widget.video['url'])
      ..addListener(() {setState(() {
        
      });})
      ..setLooping(true)
      ..initialize().then((value) => videoController.play());
  }
  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    playVideo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: AlignmentDirectional.center,
        children: [
           videoController.value.isInitialized
                    ? VideoPlayer(videoController)
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                         Container(
                height: 300,
                color: Color.fromARGB(0, 255, 255, 255),
                width: MediaQuery.of(context).size.width,
                child: Flex(direction: Axis.horizontal, children: [
                  Expanded(
                    child: GestureDetector(
                      onVerticalDragDown: (drage) {
                        print(drage.localPosition);
                      },
                      onVerticalDragEnd: (details) {
                        print("details : $details");
                      },
                      child: Icon(Icons.arrow_downward),
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      videoController.value.isPlaying?
                      videoController.pause():
                      videoController.play();
                      print("oooooooo");
                    },
                    child: videoController.value.isPlaying
                        ? Icon(Icons.pause)
                        : Icon(Icons.play_arrow),
                  )),
                  Expanded(
                      child: GestureDetector(
                    onVerticalDragEnd: (drage) {
                      print(drage.velocity);
                    },
                    child: Icon(Icons.arrow_upward),
                  ))
                ]),
              )
        ],
      ),),
    );
  }
}