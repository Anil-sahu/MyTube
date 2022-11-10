import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'Video..dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CameraPageState createState() => _CameraPageState();
}
class _CameraPageState extends State<CameraPage> {
  bool _isLoading = true;
  bool _isRecording = false;
  late CameraController _cameraController;
  
  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
  final cameras = await availableCameras();
  final front = cameras.firstWhere((camera) => camera.lensDirection == CameraLensDirection.front);
  _cameraController = CameraController(front, ResolutionPreset.low);
  await _cameraController.initialize();
  setState(() => _isLoading = false);
}

_recordVideo() async {
  if (_isRecording) {
    final file = await _cameraController.stopVideoRecording();
    setState(() => _isRecording = false);
    File myFile = File(file.path);
    final route = MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => VideoPage(filePath: file.path,file:myFile),
    );
    Navigator.push(context, route);
  } else {
    await _cameraController.prepareForVideoRecording();
    await _cameraController.startVideoRecording();
    setState(() => _isRecording = true);
  }
}
@override
void initState() {
  super.initState();
  _initCamera();
}

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Center(
  child: Stack(
    alignment: Alignment.bottomCenter,
    children: [
      CameraPreview(_cameraController),
      Padding(
        padding: const EdgeInsets.all(25),
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(_isRecording ? Icons.stop : Icons.circle),
          onPressed: () => _recordVideo(),
        ),
      ),
    ],
  ),
);
    }
  }
}