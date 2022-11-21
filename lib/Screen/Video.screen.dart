import 'package:blackcoffer/controller/instance.dart';
import 'package:blackcoffer/widgets/videoplay.dart';
import 'package:flutter/material.dart';

class PlayVideoScreen extends StatefulWidget {

  
   PlayVideoScreen({super.key,});

  @override
  State<PlayVideoScreen> createState() => _PlayVideoScreenState();
}

class _PlayVideoScreenState extends State<PlayVideoScreen> {
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: PlyCard(),
      
    );
  }
}