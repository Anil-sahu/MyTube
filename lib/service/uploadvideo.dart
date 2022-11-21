import 'package:blackcoffer/controller/instance.dart';
import 'package:blackcoffer/controller/pushData.dart';
import 'package:blackcoffer/model/video.model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadVideo {
  String? thumb, video;

  uploadVideo(video, videopath, thumbnail, thumbnailPath) async {
    var videoRef = FirebaseStorage.instance
        .ref()
        .child(InstanceMemb.loginController.id.value)
        .child(videopath);
    await videoRef
        .putFile(video, SettableMetadata(contentType: "video/mp4"))
        .whenComplete(() async {
      this.video = await videoRef.getDownloadURL();
    }).catchError((error) {
       Get.defaultDialog(
          title: "",
          content: Container(
            padding: const EdgeInsets.all(12),
            color: const Color.fromARGB(255, 250, 199, 195),
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ));
    });

    var thumbRef = FirebaseStorage.instance
        .ref()
        .child(InstanceMemb.loginController.id.value)
        .child(thumbnailPath);
    await thumbRef.putFile(thumbnail).whenComplete(() async {
      thumb = await thumbRef.getDownloadURL();
    }).catchError((onError) {
        Get.defaultDialog(
          title: "",
          content: Container(
            padding: const EdgeInsets.all(12),
            color: const Color.fromARGB(255, 250, 199, 195),
            child: Text(
              onError.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ));
    });
  }

  upload(_video, videopath, thumbnail, thumbnailPath, title, desc, category,
      location) async {
    try {
      uploadVideo(_video, videopath, thumbnail, thumbnailPath).whenComplete(() {
        Video video = Video(
            videoUrl: this.video.toString(),
            thumbnail: this.thumb.toString(),
            title: title,
            category: category,
            description: desc,
            userId: InstanceMemb.loginController.id.value,
            location: location,
            userName: InstanceMemb.loginController.userName.value);
        PushData pushData = PushData();
        pushData.pushVideo(video);

        InstanceMemb.loginController.isLodingUpdate(false);
      });
    } catch (error) {
      Get.back();
      Get.defaultDialog(
          title: "",
          content: Container(
            padding: const EdgeInsets.all(12),
            color: const Color.fromARGB(255, 250, 199, 195),
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ));
    }
  }
}
