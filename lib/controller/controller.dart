import 'package:blackcoffer/controller/instance.dart';
import 'package:get/get.dart';

class VideoController extends GetxController{
  var lat =0.obs;
  var long=0.obs;
  var location ="".obs;
  var currentIndex =0.obs;

  updateCurrentIndex(index){
    currentIndex.value=index;
  }

// -------------------STORE DATA INTO FIRESTORE-------------------------------//
 

}