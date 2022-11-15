import 'package:blackcoffer/model/user.model.dart';
import 'package:blackcoffer/model/video.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'instance.dart';

class PushData {
  var isLiked = false;
  pushVideo(Video video) {
    InstanceMemb.firestore.collection("post").add(video.toMap());
  }


//-----------------------LIKE FUNCTIONALITY-------------------------------//
  likeVideo(id, likeList, countLike) async {
    InstanceMemb.videoController.getLike(id);

    if (InstanceMemb.videoController.likeByUsers
        .contains(InstanceMemb.loginController.id.value)) {
      InstanceMemb.firestore.collection("post").doc(id).update({
        "like": {
          'countLike': InstanceMemb.videoController.totalLike.value - 1,
          'user':
              FieldValue.arrayRemove([InstanceMemb.loginController.id.value])
        }
      });
    } else {
      if (InstanceMemb.videoController.disLikeByUsers
          .contains(InstanceMemb.loginController.id.value)) {
        InstanceMemb.firestore.collection("post").doc(id).update({
          "dislike": {
            'countDislike': InstanceMemb.videoController.totalDislike.value - 1,
            'user': FieldValue.arrayRemove([
              InstanceMemb.loginController.id.value,
            ])
          }
        });
      }
      InstanceMemb.firestore.collection("post").doc(id).update({
        "like": {
          'countLike': InstanceMemb.videoController.totalLike.value + 1,
          'user': FieldValue.arrayUnion([InstanceMemb.loginController.id.value])
        }
      });
    }
    InstanceMemb.videoController.getLike(id);
  }

// ------------------------------DISLIKE FUNCTIONALITY --------------------------//
  disLikeVideo(id) async {
    //  InstanceMemb.firestore.collection("user").doc(InstanceMemb.loginController.id.value).collection("post").doc(id)
    //   .update({"like":{'count':InstanceMemb.loginController.totalLike.value+1,'user':FieldValue.arrayUnion([video.toMap()])}});
    InstanceMemb.videoController.getLike(id);
    if (InstanceMemb.videoController.disLikeByUsers
        .contains(InstanceMemb.loginController.id.value)) {
      InstanceMemb.firestore.collection("post").doc(id).update({
        "dislike": {
          'countDislike': InstanceMemb.videoController.totalDislike.value - 1,
          'user': FieldValue.arrayRemove([
            InstanceMemb.loginController.id.value,
          ])
        }
      });
    } else {
      if (InstanceMemb.videoController.likeByUsers
          .contains(InstanceMemb.loginController.id.value)) {
        InstanceMemb.firestore.collection("post").doc(id).update({
          "like": {
            'countLike': InstanceMemb.videoController.totalLike.value - 1,
            'user':
                FieldValue.arrayRemove([InstanceMemb.loginController.id.value])
          }
        });
      }
      InstanceMemb.firestore.collection("post").doc(id).update({
        "dislike": {
          'countDislike': InstanceMemb.videoController.totalDislike.value + 1,
          'user': FieldValue.arrayUnion([InstanceMemb.loginController.id.value])
        }
      });
    }
    InstanceMemb.videoController.getLike(id);
  }

  views(id){
     InstanceMemb.videoController.getLike(id);

     if (InstanceMemb.videoController.viewUsers
        .contains(InstanceMemb.loginController.id.value)==false) {
      InstanceMemb.firestore.collection("post").doc(id).update({
        "views": {
          'countView': InstanceMemb.videoController.totalDislike.value ,
          'user': FieldValue.arrayUnion([
            InstanceMemb.loginController.id.value,
          ])
        }
      });
    } 
 InstanceMemb.videoController.getLike(id);
  }

  pushUserData(UserData user, userId) async {
    await InstanceMemb.firestore
        .collection("user")
        .doc(userId)
        .set(user.toMap());
  }
}
