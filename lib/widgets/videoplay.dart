import 'package:blackcoffer/Screen/playfullSceen.screen.dart';
import 'package:blackcoffer/controller/instance.dart';
import 'package:blackcoffer/controller/pushData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class PlyCard extends StatefulWidget {
  var data;
  PlyCard({
    super.key,
    required this.data,
  });

  @override
  State<PlyCard> createState() => _PlyCardState();
}

class _PlyCardState extends State<PlyCard> {
  PushData pushData = PushData();

  late VideoPlayerController videoController;
  playVideo() {
    videoController = VideoPlayerController.network(widget.data['url'])
      ..addListener(() {setState(() {
        
      });})
      ..setLooping(true)
      ..initialize().then((value) => videoController.play());
      pushData.views(widget.data.id);
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  void initState() {
    // InstanceMemb.videoController.getLike(widget.data.id);
    playVideo();
    // print(videoController.value.isInitialized);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(videoController.value.isInitialized);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Column(
//alignment: AlignmentDirectional.bottomCenter,
        children: [
          Stack(
            children: [
              Container(
                height: 300,
                color: Color.fromARGB(255, 107, 107, 107),
                child: videoController.value.isInitialized
                    ? VideoPlayer(videoController)
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                // child: FutureBuilder(
                //   future: vds.initVideoPlayer(widget.data!['url']),
                //   builder: (context, state) {
                //     if (state.connectionState == ConnectionState.waiting) {
                //       return const Center(child: CircularProgressIndicator());
                //     } else {
                //       return VideoPlayer(videoController);
                //     }
                //   },
                // ),
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
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(34, 255, 255, 255),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon:
                      //  Obx(() =>
                      videoController.value.isPlaying
                          ? const Icon(
                              Icons.pause,
                              size: 30,
                            )
                          : const Icon(
                              Icons.play_arrow_rounded,
                              size: 30,
                            ),
                  //  ),
                  onPressed: () {
                    videoController.value.isPlaying
                        ? videoController.pause()
                        : videoController.play();
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(() => Text(InstanceMemb.videoController.runTime.value
                        .toString()
                        .split(".")[0])),
                    Container(
                      width: MediaQuery.of(context).size.width - 210,
                      margin:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      height: 15,
                      child: VideoProgressIndicator(
                        videoController,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                            backgroundColor: Color.fromARGB(255, 247, 247, 247),
                            bufferedColor: Color.fromARGB(255, 248, 248, 248),
                            playedColor: Colors.blueAccent),
                      ),
                    ),
                    Obx(() => Text(InstanceMemb.videoController.runTime.value
                        .toString()
                        .split(".")[0]))
                  ],
                ),
                IconButton(onPressed: () {
                  Get.to(()=>FullScreenPlay(video: widget.data));
                }, icon: const Icon(Icons.fullscreen))
              ],
            ),
          )
        ],
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          widget.data!['title'],
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      pushData.likeVideo(widget.data.id, widget.data!['like'],
                          widget.data!['like']['countLike']);
                      // InstanceMemb.videoController.getLike(widget.data.id);
                    },
                    icon: Obx(
                      () => InstanceMemb.videoController.likeByUsers
                              .contains(InstanceMemb.loginController.id.value)
                          ? const Icon(
                              Icons.thumb_up,
                              size: 20,
                              color: Color.fromARGB(255, 46, 46, 46),
                            )
                          : const Icon(Icons.thumb_up_outlined,
                              size: 20, color: Color.fromARGB(255, 46, 46, 46)),
                    )),
                Obx(() =>
                    Text(InstanceMemb.videoController.totalLike.toString()))
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    pushData.disLikeVideo(widget.data.id);
                  },
                  icon: Obx(
                    () => InstanceMemb.videoController.disLikeByUsers
                            .contains(InstanceMemb.loginController.id.value)
                        ? const Icon(
                            Icons.thumb_down,
                            size: 20,
                            color: Color.fromARGB(255, 46, 46, 46),
                          )
                        : const Icon(
                            Icons.thumb_down_outlined,
                            size: 20,
                            color: Color.fromARGB(255, 46, 46, 46),
                          ),
                  ),
                ),
                Obx(() =>
                    Text(InstanceMemb.videoController.totalDislike.toString()))
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                    color: Colors.grey,
                    size: 16,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Share"),
                )
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children:  [
            Obx(()=>Text(InstanceMemb.videoController.countViews.value.toString()+"views")),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text("1 year ago"),
            )
          ],
        ),
      ),
      const Divider(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Text("A"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  InstanceMemb.videoController.userName.value,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.only(right: 20),
            child: const Text(
              "View all Video",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ))
      ])
    ]);
  }
}
