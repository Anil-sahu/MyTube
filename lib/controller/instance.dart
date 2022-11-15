import 'package:blackcoffer/controller/video.controller.dart';
import 'package:blackcoffer/controller/login.controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class InstanceMemb {
  static VideoController videoController = Get.put(VideoController());
  static LoginController loginController =Get.put(LoginController());
  static final FirebaseStorage storage = FirebaseStorage.instance;
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore=FirebaseFirestore.instance;
  
}