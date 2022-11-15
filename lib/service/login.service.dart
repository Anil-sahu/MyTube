import 'package:blackcoffer/Screen/Main.screen.dart';
import 'package:blackcoffer/controller/instance.dart';
import 'package:blackcoffer/controller/pushData.dart';
import 'package:blackcoffer/model/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Login {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> verifyPhoneNumber(phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: "+91" + phoneNumber,
        timeout: const Duration(minutes: 2),
        verificationCompleted: (AuthCredential authCredential) {
          InstanceMemb.loginController.isLodingUpdate(false);
          InstanceMemb.loginController
              .loginStatus("Your account is successfully verified");
          print("login successful");
          print("--------------------uid");
          print(auth.currentUser!.uid);
        },
        verificationFailed: (authException) async {
          InstanceMemb.loginController.loginStatus("Authentication failed");
          print("===========================");
          print("failse ===============");
        },
        codeSent: (String verId, [int? forceCodeResent]) {
          InstanceMemb.loginController.isLodingUpdate(false);
          InstanceMemb.loginController.signInStep(true);

          InstanceMemb.loginController.verifyUpdate(verId);
          InstanceMemb.loginController
              .loginStatus("OTP has been successfully send");

          print("===============================");
          print("otp send successfull ${verId}");
             print("===========================cuid==");
             InstanceMemb.loginController.currentUserId(auth.currentUser!.uid);
          print(" ${auth.currentUser!.uid}");
        },
        codeAutoRetrievalTimeout: (String verId) {
          InstanceMemb.loginController.isLodingUpdate(false);
          InstanceMemb.loginController.verifyUpdate(verId);
          InstanceMemb.loginController.loginStatus("TIMEOUT");
          print("=============================");
          print("otp timeout ${auth.currentUser!.uid}");
        },
      );
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> signIn(String otp, UserData user) async {
      InstanceMemb.loginController.isLodingUpdate(true);
    print(InstanceMemb.loginController.verificationId.value);
      PushData pushData = PushData();
    
      await auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: InstanceMemb.loginController.verificationId.value,
        smsCode: otp,
      ));

      
      print("---------------------------------------------uid---------");
      print(auth.currentUser!.uid);
      InstanceMemb.loginController
          .saveUserData(user.username,user.mobile, auth.currentUser!.uid);
      InstanceMemb.loginController.getUserData();

      InstanceMemb.loginController.isLodingUpdate(false);
       pushData.pushUserData(user,auth.currentUser!.uid);
      //  InstanceMemb.loginController.saveUserData(name.text, mobile.text.trim());
      Get.offAll(() => MainScreen());
   
  }
}
