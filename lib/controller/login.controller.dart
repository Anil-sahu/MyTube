import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{
  var isLogin =false.obs;
  var status ="".obs;
  var verificationId = "".obs;
  var isLoading =false.obs;
  var userName = "".obs;
  var mobile ="".obs;
  var id = "".obs;

@override
  onInit(){
    getUserData();
  super.onInit();
}
verifyUpdate(values){
    verificationId.value = values;
  }

  loginStatus(value){
    status.value = value;
  }

  signInStep(value){
    isLogin.value=value;
  }

  isLodingUpdate(value){
    isLoading.value =value;
  }

saveUserData(name,mobile,id)async{
  final preferences =await SharedPreferences.getInstance();
  preferences.setString("name", name);
  preferences.setString("mobile",mobile);
  preferences.setString("id",id);
  
}

getUserData()async{
  final preferences = await SharedPreferences.getInstance();
  userName.value = preferences.getString("name")??"";
  mobile.value=preferences.getString("mobile")??"";
  id.value = preferences.getString("id")??"";
}


}