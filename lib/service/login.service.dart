import 'package:blackcoffer/Screen/Main.screen.dart';
import 'package:blackcoffer/controller/instance.dart';
import 'package:blackcoffer/controller/pushData.dart';
import 'package:blackcoffer/model/user.model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Login {
 
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> verifyPhoneNumber(phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91"+phoneNumber,
      timeout: const Duration(minutes: 2),
      verificationCompleted: (AuthCredential authCredential) {
        InstanceMemb.loginController.isLodingUpdate(false);
        InstanceMemb.loginController
            .loginStatus("Your account is successfully verified");
        print("login successful");
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
      },
      codeAutoRetrievalTimeout: (String verId) {
        InstanceMemb.loginController.isLodingUpdate(false);
        InstanceMemb.loginController.verifyUpdate(verId);
        InstanceMemb.loginController.loginStatus("TIMEOUT");
        print("=============================");
        print("otp timeout ${verId}");
      },
    );
    
  }

  Future<void> signIn(String otp) async {
    print(InstanceMemb.loginController.verificationId.value);
    InstanceMemb.loginController.isLodingUpdate(true);
    await auth.signInWithCredential(PhoneAuthProvider.credential(
      verificationId: InstanceMemb.loginController.verificationId.value,
      smsCode: otp,
    ));
      
  
 
      
    
    InstanceMemb.loginController.isLodingUpdate(false);
    Get.offAll(() => MainScreen());
  }
}
