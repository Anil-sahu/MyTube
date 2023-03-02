import 'dart:ffi';

import 'package:blackcoffer/controller/instance.dart';
import 'package:blackcoffer/controller/pushData.dart';
import 'package:blackcoffer/model/user.model.dart';
import 'package:blackcoffer/service/login.service.dart';
import 'package:blackcoffer/widgets/TextField.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController smsCode = TextEditingController();
  bool isLogin = false;
  final focusNode = FocusNode();
  final login = Login();

  @override
  Widget build(BuildContext context) {
    var focusedBorderColor = const Color.fromRGBO(23, 171, 144, 1);
    var fillColor = const Color.fromRGBO(243, 246, 249, 0);
    var borderColor = const Color.fromRGBO(23, 171, 144, 0.4);
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(248, 20, 20, 20),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Expanded(
              child: Container(
                  width: width,
                  height: width,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 55, 207),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(width),
                      // topLeft: Radius.circular(width),
                    ),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        child: const Icon(
                          Icons.person_rounded,
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 100,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 23),
                        child:
                            Obx(() => InstanceMemb.loginController.isLogin.value
                                ? const Text(
                                    "Verification",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )
                                : const Text(
                                    "Login With Mobile",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )),
                      )
                    ],
                  ),
             
                  Obx(
                    () => InstanceMemb.loginController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Obx(() => InstanceMemb.loginController.isLogin.value
                            ? Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Enter the code send to the number",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 177, 177, 177),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "+91 ${mobile.text}",
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 231, 231, 231),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  Directionality(
                                    // Specify direction if desired
                                    textDirection: TextDirection.ltr,
                                    child: Pinput(
                                      length: 6,
                                      controller: smsCode,
                                      focusNode: focusNode,
                                      hapticFeedbackType:
                                          HapticFeedbackType.lightImpact,
                                      onCompleted: (pin) {
                                        debugPrint('onCompleted: $pin');
                                        print("-------------------value");
                                        print(pin);
                                      },
                                      onChanged: (value) {
                                        debugPrint('onChanged: $value');
                                        print("====================pin");
                                        print(value);
                                      },
                                      cursor: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 9),
                                            width: 22,
                                            height: 1,
                                            color: focusedBorderColor,
                                          ),
                                        ],
                                      ),
                                      focusedPinTheme: defaultPinTheme.copyWith(
                                        decoration: defaultPinTheme.decoration!
                                            .copyWith(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: focusedBorderColor),
                                        ),
                                      ),
                                      submittedPinTheme:
                                          defaultPinTheme.copyWith(
                                        decoration: defaultPinTheme.decoration!
                                            .copyWith(
                                          color: fillColor,
                                          borderRadius:
                                              BorderRadius.circular(19),
                                          border: Border.all(
                                              color: focusedBorderColor),
                                        ),
                                      ),
                                      errorPinTheme:
                                          defaultPinTheme.copyBorderWith(
                                        border:
                                            Border.all(color: Colors.redAccent),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      height: 50,
                                      width: 150,
                                      margin: const EdgeInsets.all(20),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 2,
                                              shadowColor: Colors.white,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 72, 104, 248)),
                                          onPressed: () {
                                            print(smsCode.text);
                                            UserData user = UserData(
                                                username: name.text,
                                                mobile: mobile.text.trim());
                                          
                                           
                                            login.signIn(smsCode.text.trim(),
                                                user);
                                             
                                                 ;
                                          },
                                          child: const Text(
                                            "Verify",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                  const Text(
                                    "Didn't recieve code?",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 196, 202, 255),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        // print(mobile.text);
                                        InstanceMemb.loginController
                                            .isLodingUpdate(true);
                                        if (mobile.text.trim().isNotEmpty) {
                                          login.verifyPhoneNumber(
                                              mobile.text.trim());
                                        } else {
                                          Get.showSnackbar(const GetSnackBar(
                                            titleText: Text(
                                                "Phone Number and username canot be empty"),
                                            messageText: null,
                                          ));
                                        }
                                      },
                                      child: const Text(
                                        "Resend OTP",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.transparent),
                                          onPressed: () {
                                            InstanceMemb.loginController
                                                .signInStep(false);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_back_ios,
                                                color: Colors.white,
                                              ),
                                              Text("Back")
                                            ],
                                          ))
                                    ],
                                  )
                                ],
                              )
                            : Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextFields(
                                    controller: name,
                                    pref: Icons.person_rounded,
                                    suf: Icons.close,
                                    hint: "Enter user name..",
                                    label: "username",
                                    keyType: TextInputType.name,
                                  ),
                                  TextFields(
                                    controller: mobile,
                                    pref: Icons.phone_rounded,
                                    suf: Icons.close,
                                    hint: "Enter mobile number..",
                                    label: "mobile",
                                    keyType: TextInputType.phone,
                                  ),
                                  Container(
                                      height: 50,
                                      width: 150,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 2,
                                              shadowColor: Colors.white,
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 72, 104, 248)),
                                          onPressed: () {
                                            UserData user = UserData(
                                                username: name.text,
                                                mobile: mobile.text.trim());
                                            if (mobile.text.trim().isNotEmpty &&
                                                name.text.trim().isNotEmpty) {
                                              InstanceMemb.loginController
                                                  .isLodingUpdate(true);
                                              login.verifyPhoneNumber(
                                                  user.mobile);
                                            } else {
                                              Get.showSnackbar(
                                                  const GetSnackBar(
                                                titleText: Text(
                                                    "Phone Number and username canot be empty"),
                                                messageText: null,
                                              ));
                                            }

                                    
                                          },
                                          child: const Text(
                                            "Login",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )))
                                ],
                              )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
