import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  var location = "".obs;
  var currentIndex = 0.obs;
   var pagecurrentIndex = 0.obs;
  var videos = [].obs;
  var video = {}.obs;
  var totalLike = 0.obs;
  var likeByUsers = [].obs;
  var totalDislike = 0.obs;
  var disLikeByUsers = [].obs;
  var postedUserId = "".obs;
  var userName = "".obs;
  var viewUsers = [].obs;
  var countViews = 0.obs;
  var comments = [].obs;
  var countComments = 0.obs;
  var isComment = false.obs;
  var isSearch = false.obs;
  var isReply =false.obs;
  var replayCommentIndex = 0.obs;
  var isVideoDisplay=false.obs;

  var cameraDirection = CameraLensDirection.front.obs;
  var isFrontCamera = false.obs;

 
onInit(){
  getAllVideos();
  super.onInit();
}
  //--------------------------------GET VIDEO DURATION -------------------------------//

  
//-------------------------------------COMMENT FIELD OPEN OR CLOSE-------------------//
  isWantComment(value) {
    isComment.value = value;
  }


 isWantReply(value){
  isReply.value = value;
 }

replyIndex(index){
  replayCommentIndex.value = index;
}

//-----------------------------------TOGGLE SEARCH FIELD-----------------------------//
  isSearchUpdate(value) {
    isSearch.value = value;
  }

// ----------------------------------CAMERA LENS DIREDCTION------------------//
  backORfron(value, isfront) {
    cameraDirection.value = value;
    isFrontCamera.value = isfront;
  }

//------------------------------GET LOCATION----------------------------//
  getLocation(locations){
    location.value = locations;
  }
 

  updateCurrentIndex(index) {
    currentIndex.value = index;
  }

  isVideoDisplayOrNot(value){
    isVideoDisplay.value = value;
  }

  updatepageCurrentIndex(index) {
    pagecurrentIndex.value = index;
  }

  // getVideo(video) {
  //   videos.value = video;
  // }


//-----------------------------FETCH ALL POSTED VIDEOS-------------------------------//
  getAllVideos() async {
    var firstore = await FirebaseFirestore.instance.collection("post").get();
    videos.value = firstore.docs;
    print(videos.value);
  }



//-----------------------UPLOADING DATE ----------------------------------------//

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }


  getUser(id) async {
    var firestore =
        await FirebaseFirestore.instance.collection("user").doc(id).get();
    userName.value = firestore.data()!['username'];
  }


//-----------------------get user details-------------------------------//
  getLike(id) async {
    var firstore =
        await FirebaseFirestore.instance.collection("post").doc(id).get();
    video.value = firstore.data()!;
    postedUserId.value = video['userId'];
    getUser(firstore.data()!['userId']);

//---------------------get like --------------------------------------//
    totalLike.value = await firstore.data()!['like']['countLike'];
    likeByUsers.value = await firstore.data()!['like']['user'];

//---------------------get dislike---------------------------------------//
    totalDislike.value = await firstore.data()!['dislike']['countDislike'];
    disLikeByUsers.value = await firstore.data()!['dislike']['user'];

//--------------------get views----------------------------------------//
    viewUsers.value = await firstore.data()!['views']['user'];
    countViews.value = await firstore.data()!['views']['countView'];

    //-------------------------get comments--------------------------------//

    comments.value = await firstore.data()!['comments']['user'];
    countComments.value = await firstore.data()!['comments']['countComment'];
  }
// -------------------STORE DATA INTO FIRESTORE-------------------------------//

}
