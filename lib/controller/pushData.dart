

import 'package:blackcoffer/model/user.model.dart';
import 'package:blackcoffer/model/video.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'instance.dart';

class PushData {
  var isLiked = false;
 
  pushVideo(Video video) async{
   
    
    InstanceMemb.firestore.collection("post").add(video.toMap());
  
    print("----------------------success");
  }

//-----------------------LIKE FUNCTIONALITY-------------------------------//
  likeVideo(id, likeList, countLike) async {

    InstanceMemb.videoController.getLike(id);

    if (InstanceMemb.videoController.likeByUsers.contains(InstanceMemb.loginController.id.value)) {
        
      InstanceMemb.firestore.collection("post").doc(id).update(
         {
          'like.countLike': InstanceMemb.videoController.totalLike.value - 1,
          'like.user':FieldValue.arrayRemove([InstanceMemb.loginController.id.value]) });
    } else {
      if (InstanceMemb.videoController.disLikeByUsers
          .contains(InstanceMemb.loginController.id.value)) {
        InstanceMemb.firestore.collection("post").doc(id).update({
            'dislike.countDislike': InstanceMemb.videoController.totalDislike.value - 1,
            'dislike.user': FieldValue.arrayRemove([
              InstanceMemb.loginController.id.value,
            ])
        });
      }
        // InstanceMemb.videoController.likeByUsers.add(InstanceMemb.loginController.id.value);
     await InstanceMemb.firestore.collection("post").doc(id).update({
          'like.countLike': InstanceMemb.videoController.totalLike.value + 1,
          'like.user': FieldValue.arrayUnion([InstanceMemb.loginController.id.value]),
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
      
          'dislike.countDislike': FieldValue.increment(-1),
          'dislike.user': FieldValue.arrayRemove([
            InstanceMemb.loginController.id.value,
          ])
        
      });
    } else {
      if (InstanceMemb.videoController.likeByUsers
          .contains(InstanceMemb.loginController.id.value)) {
        InstanceMemb.firestore.collection("post").doc(id).update({
            'like.countLike': FieldValue.increment(-1),
            'like.user':
                FieldValue.arrayRemove([InstanceMemb.loginController.id.value])});
      }
      InstanceMemb.firestore.collection("post").doc(id).update({
          'dislike.countDislike': FieldValue.increment(1),
          'dislike.user': FieldValue.arrayUnion([InstanceMemb.loginController.id.value]) });
    }
    InstanceMemb.videoController.getLike(id);
  }


//--------------------------VIEW SECTION----------------------------//
  views(id) {
    InstanceMemb.videoController.getLike(id);

    if (InstanceMemb.videoController.viewUsers.contains(InstanceMemb.loginController.id.value) == false) {
         
      InstanceMemb.firestore.collection("post").doc(id).update({
          'views.countView':FieldValue.increment(1),
          'views.user': FieldValue.arrayUnion(
           [InstanceMemb.loginController.id.value]
          )
      });
    }
    InstanceMemb.videoController.getLike(id);
  }


//--------------------Comment section------------------------------//

  comments(id,Comment comment) {
    InstanceMemb.videoController.getLike(id);
      InstanceMemb.firestore.collection("post").doc(id).update({
          'comments.countComment':FieldValue.increment(1),
          'comments.user': FieldValue.arrayUnion([
         comment.toMap()
          ])
      });
    
    InstanceMemb.videoController.getLike(id);
  }

  
  reply(id,reply,index) {
    InstanceMemb.videoController.getLike(id);
      InstanceMemb.firestore.collection("post").doc(id).update({
          // 'comments.countComment': FieldValue.increment(1),
          'comments.user.$index.reply': FieldValue.arrayUnion([
         reply
          ])
      });
    
    InstanceMemb.videoController.getLike(id);
  }




  pushUserData(UserData user, userId) async {
    await InstanceMemb.firestore
        .collection("user")
        .doc(userId)
        .set(user.toMap());
  }
}
