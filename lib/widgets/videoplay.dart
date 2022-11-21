import 'package:blackcoffer/controller/instance.dart';
import 'package:blackcoffer/controller/pushData.dart';
import 'package:blackcoffer/model/video.model.dart';
import 'package:blackcoffer/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../Screen/FullScreenMode.dart';

// ignore: must_be_immutable
class PlyCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables

  const PlyCard({
    super.key,
  });

  @override
  State<PlyCard> createState() => _PlyCardState();
}

class _PlyCardState extends State<PlyCard> {
  PushData pushData = PushData();
  TextEditingController comment = TextEditingController();

  late VideoPlayerController videoController;

  playVideo({int index = 0, bool init = false}) {
    try {
      if (InstanceMemb.videoController.currentIndex.value < 0 ||
          InstanceMemb.videoController.currentIndex.value >=
              InstanceMemb.videoController.videos.length) {
        return;
      }
      if (!init) {
        videoController.pause();
      }
      videoController = VideoPlayerController.network(InstanceMemb
          .videoController
          .videos[InstanceMemb.videoController.currentIndex.value]['url'])
        ..addListener(() {
          setState(() {});
        })
        ..setLooping(true)
        ..initialize().then((value) => videoController.play());
      pushData.views(InstanceMemb.videoController
          .videos[InstanceMemb.videoController.currentIndex.value].id);
      // ignore: empty_catches
    } catch (error) {}
  }

  videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minuts = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minuts, seconds].join(":");
  }

  @override
  void initState() {
    super.initState();
    playVideo(init: true);
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape?VideoPlayer(videoController): Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: videoController.value.isInitialized?videoController.value.aspectRatio:16/9,
                  child: videoController.value.isInitialized
                      ? VideoPlayer(videoController)
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                ),
               
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(36, 114, 114, 114),
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
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.play_arrow_rounded,
                                size: 30,
                                color: Colors.white,
                              ),
                    //  ),
                    onPressed: () {
                      setState(() {
                        videoController.value.isPlaying
                            ? videoController.pause()
                            : videoController.play();
                      });
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ValueListenableBuilder(
                          valueListenable: videoController,
                          builder: (context, VideoPlayerValue value, child) {
                            return Text(
                              videoDuration(value.position),
                               style: const TextStyle(color: Color.fromARGB(255, 209, 209, 209),fontSize: 12,fontWeight: FontWeight.bold)
                            );
                          }),
                      Container(
                        width: MediaQuery.of(context).size.width - 210,
                        margin:
                            const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        height: 10,
                        child: VideoProgressIndicator(
                          videoController,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                              backgroundColor:
                                  Color.fromARGB(255, 247, 247, 247),
                              bufferedColor: Color.fromARGB(255, 190, 220, 255),
                              playedColor: Color.fromARGB(255, 35, 149, 255)),
                        ),
                      ),
                      Text(
                        videoDuration(videoController.value.duration),
                        style: const TextStyle(color: Color.fromARGB(255, 209, 209, 209),fontSize: 12,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {

                       Get.to(()=>FullScreenMode(controller:videoController)) ;
                      },
                      icon: const Icon(
                        Icons.fullscreen,
                        color: Colors.white,
                      ))
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Text(
              InstanceMemb.videoController
                      .videos[InstanceMemb.videoController.currentIndex.value]
                  ['title'],
              style: const TextStyle(
                  color: Color.fromARGB(255, 48, 47, 47),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      pushData.likeVideo(
                          InstanceMemb
                              .videoController
                              .videos[InstanceMemb
                                  .videoController.currentIndex.value]
                              .id,
                          InstanceMemb.videoController.videos[InstanceMemb
                              .videoController.currentIndex.value]['like'],
                          InstanceMemb.videoController.videos[InstanceMemb
                              .videoController
                              .currentIndex
                              .value]['like']['countLike']);
                    },
                    icon: Obx(
                      () => InstanceMemb.videoController.likeByUsers
                              .contains(InstanceMemb.loginController.id.value)
                          ? const Icon(
                              Icons.thumb_up_rounded,
                              size: 20,
                              color: Color.fromARGB(255, 3, 112, 255),
                            )
                          : const Icon(Icons.thumb_up_outlined,
                              size: 20,
                              color: Color.fromARGB(255, 117, 117, 117)),
                    )),
                Obx(() => Text(
                    InstanceMemb.videoController.totalLike.toString(),
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)))
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    pushData.disLikeVideo(InstanceMemb
                        .videoController
                        .videos[InstanceMemb.videoController.currentIndex.value]
                        .id);
                  },
                  icon: Obx(
                    () => InstanceMemb.videoController.disLikeByUsers
                            .contains(InstanceMemb.loginController.id.value)
                        ? const Icon(
                            Icons.thumb_down,
                            size: 20,
                            color: Color.fromARGB(255, 3, 112, 255),
                          )
                        : const Icon(
                            Icons.thumb_down_outlined,
                            size: 20,
                            color: Color.fromARGB(255, 122, 121, 121),
                          ),
                  ),
                ),
                Obx(() => Text(
                    InstanceMemb.videoController.totalDislike.toString(),
                    style: const TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)))
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
                  child: Text("Share",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold)),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      InstanceMemb.videoController.isComment.value
                          ? InstanceMemb.videoController.isWantComment(false)
                          : InstanceMemb.videoController.isWantComment(true);
                    },
                    icon: Obx(() => InstanceMemb.videoController.isComment.value
                        ? const Icon(
                            Icons.comment_bank_rounded,
                            size: 16,
                            color: Color.fromARGB(255, 3, 138, 248),
                          )
                        : const Icon(
                            Icons.add_comment_rounded,
                            size: 16,
                            color: Colors.grey,
                          )),
                  ),
                  Obx(() => Text(
                      InstanceMemb.videoController.countComments.value
                          .toString(),
                      style: const TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold)))
                ],
              ),
            )
          ],
        ),
        Obx(
          () => InstanceMemb.videoController.isComment.value
              ? const Divider(
                  height: 3,
                  color: Colors.grey,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Obx(
                            () => Text(
                              "${InstanceMemb.videoController.countViews.value} views",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Obx(
                              () => Text(
                                  InstanceMemb.videoController.timeAgo(
                                      InstanceMemb
                                          .videoController
                                          .videos[InstanceMemb.videoController
                                              .currentIndex.value]['postDate']
                                          .toDate()),
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold)),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(255, 25, 25, 26),
                                  ),
                                  child: Text(
                                    InstanceMemb.videoController.videos[
                                        InstanceMemb.videoController
                                            .currentIndex.value]['username'][0],
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    InstanceMemb.videoController.videos[
                                        InstanceMemb.videoController
                                            .currentIndex.value]['username'],
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 2, 60, 252)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              color: InstanceMemb
                                      .videoController.isVideoDisplay.value
                                  ? const Color.fromARGB(255, 234, 242, 248)
                                  : Colors.transparent,
                              margin: const EdgeInsets.only(right: 20),
                              child: TextButton(
                                onPressed: () {
                                  if (InstanceMemb
                                      .videoController.isVideoDisplay.value) {
                                    InstanceMemb.videoController
                                        .isVideoDisplayOrNot(false);
                                  } else {
                                    InstanceMemb.videoController.getAllVideos();
                                    InstanceMemb.videoController
                                        .isVideoDisplayOrNot(true);
                                  }
                                },
                                child: Row(
                                  children: [
                                    Obx(() => InstanceMemb.videoController
                                            .isVideoDisplay.value
                                        ? const Icon(
                                            Icons.arrow_drop_down,
                                            size: 30,
                                            color: Colors.grey,
                                          )
                                        : const Icon(
                                            Icons.arrow_left_rounded,
                                            size: 30,
                                            color: Colors.grey,
                                          )),
                                    const Text("View all Video",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 58, 58, 58))),
                                  ],
                                ),
                              ))
                        ]),
                  ],
                ),
        ),
        Obx(() => InstanceMemb.videoController.isComment.value
            ? Obx(
                () => InstanceMemb.videoController.comments.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                            itemCount:
                                InstanceMemb.videoController.comments.length,
                            itemBuilder: ((context, index) {
                              return Column(
                                children: [
                                  commentsWidget(
                                      InstanceMemb.videoController
                                          .comments[index]['comment'],
                                      context),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        barrierColor: Colors.white,
                                        context: context, builder: ((context) {
                                        return AlertDialog(
                                          elevation: 0,
                                          backgroundColor: Colors.white,
                                          title: Row(children: const [Icon(Icons.error_outline,color: Colors.red,),Text("Not Imeplemented")],),
                                          content: ElevatedButton(
                                            style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 3, 61, 250)),
                                            onPressed: (){Get.back();},child: Text("Ok",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                        );
                                      }));
                                   
                                      // InstanceMemb.videoController
                                      //     .replyIndex(index);
                                      // InstanceMemb.videoController
                                      //     .isWantReply(true);
                                    },
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.reply),
                                          Text("reply")
                                        ]),
                                  ),
                                  Obx(
                                    () => InstanceMemb.videoController
                                                .comments[index]['replay'] !=
                                            null
                                        ? ListView.builder(
                                            itemCount: InstanceMemb
                                                .videoController
                                                .comments[index]['replay']
                                                .length,
                                            itemBuilder: (context, index) {
                                              return replyCard(
                                                  context,
                                                  InstanceMemb.videoController
                                                          .comments[index]
                                                      ['replay']);
                                            })
                                        : const SizedBox(),
                                  )
                                ],
                              );
                            })),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.chat_bubble,
                              color: Color.fromARGB(117, 158, 158, 158),
                            ),
                            Text("No Comment")
                          ],
                        ),
                      ),
              )
            : Obx(
                () => InstanceMemb.videoController.isVideoDisplay.value
                    ? Expanded(
                        child: AnimationLimiter(
                          child: ListView.builder(
                              itemCount:
                                  InstanceMemb.videoController.videos.length,
                              itemBuilder: ((context, index) {
                                return AnimationConfiguration.staggeredList(
                                     position: index,
            duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 12),
                                        child: Card(
                                          child: GestureDetector(
                                              onTap: () {
                                                InstanceMemb.videoController
                                                    .updateCurrentIndex(index);
                                                playVideo(index: index);
                                              },
                                              child: Row(
                                                children: [
                                                  Obx(() => Container(
                                                        width: 150,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                  InstanceMemb
                                                                          .videoController
                                                                          .videos[index]
                                                                      ['thumbnail'],
                                                                ),
                                                                fit: BoxFit.cover)),
                                                      )),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(left: 12),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceAround,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              180,
                                                          child: Obx(() => Text(
                                                              InstanceMemb
                                                                      .videoController
                                                                      .videos[index]
                                                                  ['title'],
                                                              style: const TextStyle(
                                                                  color: Color.fromARGB(
                                                                      255, 70, 70, 70),
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight
                                                                      .bold))),
                                                        ),
                                                        Obx(
                                                          () => Text(
                                                              InstanceMemb
                                                                      .videoController
                                                                      .videos[index]
                                                                  ['username'],
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors.grey,
                                                                  fontWeight:
                                                                      FontWeight.bold)),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            Obx(
                                                              () => Text(
                                                                  "${InstanceMemb.videoController.videos[index]['views']['countView']} Views",
                                                                  style: const TextStyle(
                                                                      fontSize: 12,
                                                                      color:
                                                                          Colors.grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                            ),
                                                            Obx(() => Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .only(
                                                                          left: 20.0),
                                                                  child: Text(
                                                                      InstanceMemb
                                                                          .videoController
                                                                          .timeAgo(InstanceMemb
                                                                              .videoController
                                                                              .videos[
                                                                                  index]
                                                                                  [
                                                                                  'postDate']
                                                                              .toDate()),
                                                                      style: const TextStyle(
                                                                          fontSize: 12,
                                                                          color: Colors
                                                                              .grey,
                                                                          fontWeight:
                                                                              FontWeight
                                                                                  .bold)),
                                                                ))
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })),
                        ),
                      )

                    //------------------------DESCRIPTION SECTION-------------------------------------//
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Description: \n",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 99, 99, 99),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Obx(() => Text(
                                  InstanceMemb.videoController.videos[
                                      InstanceMemb.videoController.currentIndex
                                          .value]['description'],
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 128, 127, 127),
                                      fontSize: 16),
                                )),
                          ],
                        ),
                      ),
              ))
      ]),

      //-----------------------------COMMENT TEXT FIELD------------------------------//
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(
        () => InstanceMemb.videoController.isComment.value
            ? FloatingActionButton.extended(
                clipBehavior: Clip.hardEdge,
                backgroundColor: const Color.fromARGB(255, 248, 248, 248),
                onPressed: () {},
                label: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 219, 219, 219),
                      border: Border.all(width: 2, color: Colors.black)),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 50,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(),
                        child: TextField(
                          controller: comment,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 70, 69, 69)),
                          decoration: const InputDecoration(
                            prefix: Text("    "),
                            // filled: true,
                            // fillColor: Colors.black,
                            hintText: "comment...",
                          ),
                        ),
                      ),
                      Obx(
                        () => InstanceMemb.videoController.isComment.value &&
                                InstanceMemb.videoController.isReply.value
                            ? IconButton(
                                onPressed: () {
                                  if (comment.text.trim().isNotEmpty) {
                                    // Comment comm = Comment(
                                    //     username:
                                    //         InstanceMemb.videoController.userName.value,
                                    //     comment: comment.text,
                                    //     commentDate: DateTime.now());
                                    // pushData.reply(
                                    //     widget.data.id,
                                    //     comment.text,
                                    //     InstanceMemb
                                    //         .videoController.replayCommentIndex.value);
                                    comment.clear();
                                    InstanceMemb.videoController
                                        .isWantReply(false);
                                  }
                                },
                                icon: const Icon(
                                  Icons.reply,
                                  color: Color.fromARGB(255, 51, 51, 51),
                                ))
                            : Obx(
                                () => InstanceMemb
                                            .videoController.isComment.value &&
                                        InstanceMemb.videoController.isReply
                                                .value ==
                                            false
                                    ? IconButton(
                                        onPressed: () {
                                          if (comment.text.trim().isNotEmpty) {
                                            Comment comm = Comment(
                                                username: InstanceMemb
                                                    .videoController
                                                    .userName
                                                    .value,
                                                comment: comment.text,
                                                commentDate: DateTime.now());
                                            pushData.comments(
                                                InstanceMemb
                                                        .videoController.videos[
                                                    InstanceMemb.videoController
                                                        .currentIndex.value],
                                                comm);
                                            comment.clear();
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.send,
                                          color:
                                              Color.fromARGB(255, 51, 51, 51),
                                        ))
                                    : const SizedBox(),
                              ),
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
