import 'dart:io';

import 'package:blackcoffer/controller/instance.dart';
import 'package:blackcoffer/service/location.service.dart';
import 'package:blackcoffer/service/uploadvideo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final String filePath;
  var file;

  VideoPage({Key? key, required this.filePath, required this.file})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoPlayerController;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController category = TextEditingController();
  var thubmnail;
  var imgagepath;
  GPService gps = GPService();

  UploadVideo upload = UploadVideo();

  _initVideoPlayer() {
    _videoPlayerController = VideoPlayerController.file(File(widget.filePath))
      ..addListener(() {})
      ..setLooping(true)
      ..initialize().then((value) => _videoPlayerController.pause());
  }

  Future getImages() async {
    var _picker = ImagePicker();
    var img = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imgagepath = img!.path;
      thubmnail = File(img.path);
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initVideoPlayer();
    gps.getLocation();
    super.initState();
  }

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
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: FutureBuilder(
                        future: _initVideoPlayer(),
                        builder: (context, state) {
                          if (state.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            return Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                VideoPlayer(_videoPlayerController),
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: thubmnail != null
                                      ? Container(
                                          alignment: Alignment.bottomRight,
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: FileImage(thubmnail),
                                                  fit: BoxFit.fill)),
                                          child: Container(
                                            width: 180,
                                            height: 50,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: const BoxDecoration(),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            117, 0, 106, 245)),
                                                onPressed: () {
                                                  getImages();
                                                },
                                                child: Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.image,
                                                      color: Colors.white,
                                                    ),
                                                    Text("Change Thumbnail",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))
                                                  ],
                                                )),
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color.fromARGB(
                                                      118, 4, 102, 250)),
                                              child: IconButton(
                                                  onPressed: () {
                                                    if (_videoPlayerController
                                                        .value.isPlaying) {
                                                      _videoPlayerController
                                                          .pause();
                                                    } else {
                                                      _videoPlayerController
                                                          .play();
                                                    }
                                                  },
                                                  icon: _videoPlayerController
                                                          .value.isPlaying
                                                      ? const Icon(
                                                          Icons.pause,
                                                          color: Colors.white,
                                                        )
                                                      : const Icon(
                                                          Icons.play_arrow,
                                                          color: Colors.white,
                                                        )),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            139, 0, 106, 245)),
                                                onPressed: () {
                                                  getImages();
                                                },
                                                child: Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.image,
                                                      color: Colors.white,
                                                    ),
                                                    Text("Pick Thumbnail",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))
                                                  ],
                                                )),
                                          ],
                                        ),
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(125, 226, 226, 226),
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              children: [
                                const Icon(Icons.location_on),
                                Obx(
                                  () => InstanceMemb.videoController.location
                                          .value.isNotEmpty
                                      ? Text(InstanceMemb
                                          .videoController.location.value)
                                      : const CircularProgressIndicator(),
                                ),
                              ],
                            ),
                          ),
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
                                hintText: "Enter video title",
                                filled: true,
                                fillColor: Color.fromARGB(125, 226, 226, 226),
                              ),
                            ),
                          ),
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
                                hintText: "Enter video category...",
                                filled: true,
                                fillColor: Color.fromARGB(125, 226, 226, 226),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: TextField(
                              controller: description,
                              maxLines: 3,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "Enter video description...",
                                filled: true,
                                fillColor: Color.fromARGB(125, 226, 226, 226),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: 100,
                        height: 50,
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 1, 97, 241)),
                            onPressed: () {
                              Get.back();
                              Get.back();
                            
                              if (widget.file != null &&
                                  thubmnail != null &&
                                  title.text.isNotEmpty) {
                                      InstanceMemb.loginController.isLodingUpdate(true);
                                       showDialog(
                                        barrierColor: Colors.white,
                                        context: context, builder: ((context) {
                                        return AlertDialog(
                                          elevation: 0,
                                          backgroundColor: Colors.white,
                                          title: Obx(() => InstanceMemb
                                          .loginController.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Column(
                                        children: [
                                          Row(
                                            children: const [
                                              Icon(Icons.check_circle,color: Colors.green,),
                                              Text(
                                                "upload successfull",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                          TextButton(
                                            
                                            onPressed: (){Get.back();},child: Row(
                                              children: [
                                                const Icon(Icons.arrow_back_ios,color: Color.fromARGB(255, 41, 41, 41),),
                                                const Text("Back",style: TextStyle(color: Color.fromARGB(255, 39, 39, 39),fontWeight: FontWeight.bold),),
                                              ],
                                            )),
                                        ],
                                      )),
                                          
                                        );
                                      }));
                          
                                upload.upload(
                                    widget.file,
                                    widget.filePath,
                                    thubmnail,
                                    imgagepath,
                                    title.text,
                                    description.text,
                                    category.text,
                                    InstanceMemb
                                        .videoController.location.value);
                              
                              } else {
                                Get.defaultDialog(
                                    title: "Error",
                                    content: Container(
                                      padding: const EdgeInsets.all(12),
                                      color: const Color.fromARGB(
                                          255, 250, 199, 195),
                                      child: const Text(
                                        "Video, thumbnail and title shuold not be empty",
                                        style:
                                            TextStyle(color: Colors.red),
                                      ),
                                    ));
                              }
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
