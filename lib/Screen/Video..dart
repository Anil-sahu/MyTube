import 'dart:io';

import 'package:blackcoffer/controller/instance.dart';
import 'package:blackcoffer/service/uploadvideo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String filePath;
  var file;

  VideoPage({Key? key, required this.filePath, required this.file})
      : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController category = TextEditingController();
  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath));


    await _videoPlayerController.initialize();
    // await _videoPlayerController.setLooping();
    await _videoPlayerController.play();
    await _videoPlayerController.pause();
  }

  UploadVideo upload = UploadVideo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        elevation: 0,
        backgroundColor: Colors.black26,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              print('do something with the file');
            },
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Obx(
        () => InstanceMemb.loginController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: FutureBuilder(
                        future: _initVideoPlayer(),
                        builder: (context, state) {
                          if (state.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return VideoPlayer(_videoPlayerController);
                          }
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Container(
                              margin: const EdgeInsets.only(left: 20, top: 20),
                              child: const Text(
                                "Video title",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              )),
                          Container(
                            margin: const EdgeInsets.all(10),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: TextField(
                              controller: title,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  filled: true,
                                  fillColor:
                                      Color.fromARGB(255, 202, 202, 202)),
                            ),
                          ),
                            ],
                          ),

                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                 Container(
                              margin: const EdgeInsets.only(left: 20, top: 20),
                              child: const Text(
                                "Video categori",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              )),
                              Container(
                                margin: const EdgeInsets.all(10),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextField(
                                  controller: category,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 202, 202, 202)),
                                ),
                              ),
                            ],
                          ),
                          Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                 Container(
                              margin: const EdgeInsets.only(left: 20, top: 20),
                              child: const Text(
                                "Video Description",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                              )),
                              Container(
                                margin: const EdgeInsets.all(10),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                child: TextField(
                                  controller: description,
                                  maxLines: 5,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 202, 202, 202)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: 100,
                        height: 60,
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 39, 39, 39)),
                            onPressed: () {
                              InstanceMemb.loginController.isLodingUpdate(true);
                              upload.upload(
                                  widget.file,
                                  title.text,
                                  category.text,
                                  description.text,
                                  widget.filePath);
                              Get.back();
                            },
                            child: const Text(
                              "Upload",
                              style: TextStyle(fontSize: 20),
                            )))
                  ],
                ),
              ),
      ),
    );
  }
}
