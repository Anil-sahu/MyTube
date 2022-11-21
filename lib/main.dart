import 'package:blackcoffer/Screen/Main.screen.dart';
import 'package:blackcoffer/Screen/login.screen.dart';
import 'package:blackcoffer/controller/instance.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzMOfz0',
        appId: '1:448618578101:web:0b650370bb29e29cac3efc',
        messagingSenderId: '448618578101',
        projectId: 'react-native-firebase-testing',
        authDomain: 'react-native-firebase-testing.firebaseapp.com',
        databaseURL: 'https://react-native-firebase-testing.firebaseio.com',
        storageBucket: 'react-native-firebase-testing.appspot.com',
        measurementId: 'G-F79DJ0VFGS',
      ),
    );
  }
  InstanceMemb.loginController.getUserData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BlackCoffer',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 54, 54, 54),
        accentColor: Colors.black45,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 245, 245, 245),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color.fromARGB(255, 1, 45, 243)),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(circularTrackColor: Colors.white),
      ),
      home: Obx(() => InstanceMemb.loginController.userName.value != "" &&
              InstanceMemb.loginController.mobile.value != ""
          ? const MainScreen()
          : const LoginScreen()),
      debugShowCheckedModeBanner: false,
    );
  }
}
