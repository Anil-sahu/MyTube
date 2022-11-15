import 'package:blackcoffer/controller/instance.dart';
import 'package:blackcoffer/widgets/videoplay.dart';
import 'package:flutter/material.dart';

class PlayVideoScreen extends StatefulWidget {
 var data;
  
   PlayVideoScreen({super.key, this.data,});

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  @override
  Widget build(BuildContext context) {
    print(InstanceMemb.loginController.id.value);
    return  Scaffold(
      body: PlyCard(data:widget.data,),
      
    );
  }
}