import 'package:blackcoffer/controller/instance.dart';
import 'package:blackcoffer/controller/pushData.dart';
import 'package:blackcoffer/model/video.model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class UploadVideo {
  upload(url, title, desc, category, filepfath) async {
    var ref = InstanceMemb.storage
        .ref()
        .child(InstanceMemb.loginController.id.value)
        .child(filepfath);
    var uploadTask = await ref
        .putFile(url, SettableMetadata(contentType: 'video/mp4'))
        .whenComplete(() async {
      var link = await ref.getDownloadURL();
      Video video = Video(
          videoUrl: link.toString(),
          title: title,
          category: category,
          description: desc,
          userId: InstanceMemb.loginController.id.value);
      PushData pushData = PushData();
      pushData.pushVideo(video);
      Get.back();
      InstanceMemb.loginController.isLodingUpdate(false);
    });
  }
}
