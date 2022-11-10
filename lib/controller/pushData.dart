import 'package:blackcoffer/model/user.model.dart';
import 'package:blackcoffer/model/video.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'instance.dart';

class PushData{
   pushVideo(Video video){
      InstanceMemb.firestore.collection("user").doc(InstanceMemb.loginController.id.value).
      update({"post":FieldValue.arrayUnion([video.toMap()])});
  }

pushUserData(UserData user)async{
  
InstanceMemb.firestore.collection("user").doc(InstanceMemb.loginController.id.value).set(user.toMap());

}
}