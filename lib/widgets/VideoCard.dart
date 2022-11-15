import 'package:blackcoffer/Screen/Video.screen.dart';
import 'package:blackcoffer/service/Vidoplayer.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  var data;

   VideoCard({super.key,required this.data});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  VideoPlayerService
   vds = VideoPlayerService();
   @override
  void initState() {
  vds.initVideoPlayer(widget.data['url']);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              print(widget.data['like']['countLike']);
              Get.to(()=>PlayVideoScreen(data:widget.data,));
            },
            child: Container(
              height: 300,
              color: const Color.fromARGB(255, 233, 233, 233),
              child: VideoPlayer(vds.videoPlayerController),
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                      ),
                       Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(widget.data['title']),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("UserName"),
                      const Text("23K Veiw"),
                      const Text("2year ago")
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
