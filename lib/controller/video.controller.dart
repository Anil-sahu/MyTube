
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';


class VideoController extends GetxController {
  var lat = 0.obs;
  var long = 0.obs;
  var location = "".obs;
  var currentIndex = 0.obs;
  var videos = [].obs;
  var video = {}.obs;
  var totalLike = 0.obs;
  var likeByUsers = [].obs;
  var totalDislike = 0.obs;
  var disLikeByUsers = [].obs;
  var postedUserId ="".obs;
  var userName="".obs;
  var postion =const Duration().obs;
  var runTime = const Duration().obs;
  var viewUsers=[].obs;
  var countViews = 0.obs;
var videoPlayerController;
  onInit() {
    super.onInit();
  }

getVideoDuration(duration,position){
  runTime.value = duration;
  postion.value = position;

}
   
  Future initVideoPlayer(url) async {
    try {
      videoPlayerController.value = VideoPlayerController.network(url);
      update();

      videoPlayerController.addListener(() {});
      await videoPlayerController.setLooping(false);
      await videoPlayerController.initialize().then((value) => null);
      videoPlayerController.play();
    } catch (error) {
      print(error.toString());
    }

    // await _videoPlayerController.setLooping();
    update();
  }

  updateCurrentIndex(index) {
    currentIndex.value = index;
  }

  getVideo(video) {
    videos.value = video;
  }
getAllVideos()async{
  var firstore = await FirebaseFirestore.instance.collection("post").get();
  videos.value =firstore.docs;
}

getUser(id)async{
  var firestore = await FirebaseFirestore.instance.collection("user").doc(id).get();
  userName.value =firestore.data()!['username'];

}

  getLike(id) async {
    var firstore =
        await FirebaseFirestore.instance.collection("post").doc(id).get();
    video.value = firstore.data()!;
    postedUserId.value =video['userId'];
    getUser(firstore.data()!['userId']);


    totalLike.value = firstore.data()!['like']['countLike'];
    likeByUsers.value = firstore.data()!['like']['user'];
    

    totalDislike.value = firstore.data()!['dislike']['countDislike'];
    disLikeByUsers.value = firstore.data()!['dislike']['user'];

    viewUsers.value = firstore.data()!['views']['user'];
    countViews.value = firstore.data()!['views']['countView'];
  }
// -------------------STORE DATA INTO FIRESTORE-------------------------------//

}
