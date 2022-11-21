
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FullScreenMode extends StatefulWidget {
 
   const FullScreenMode({super.key,required this.controller});
    final VideoPlayerController controller;

  @override
  State<FullScreenMode> createState() => _FullScreenModeState();
}

class _FullScreenModeState extends State<FullScreenMode> {
  _landScapMode()async{
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }
  _setAllOrientation()async{
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  }
  @override
  void initState() {
    
    super.initState();
    _landScapMode();
  }
  @override
  void dispose() {
  
    super.dispose();
    _setAllOrientation();
  }
  @override
  Widget build(BuildContext context) {
    return VideoPlayer(widget.controller);
  }
}