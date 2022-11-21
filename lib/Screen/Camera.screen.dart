import 'dart:io';

import 'package:blackcoffer/controller/instance.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'Videoupload.screen.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool _isLoading = true;
  bool _isRecording = false;
  var aspectRatio =16/9;

  late CameraController _cameraController;

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere((camera) =>
        camera.lensDirection ==
        InstanceMemb.videoController.cameraDirection.value);

    _cameraController = CameraController(front, ResolutionPreset.medium);
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  cameraDirection(cameraD) {
    return cameraD;
  }

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      File myFile = File(file.path);

      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPage(filePath: file.path, file: myFile),
      );
      // ignore: use_build_context_synchronously
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
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Ratio  ",style: TextStyle(color: Colors.white,fontSize: 20),),
                    Container(
                      color: aspectRatio==16/9?const Color.fromARGB(255, 71, 71, 71):Colors.transparent,
                      child: TextButton(onPressed: (){
                        setState(() {
                          aspectRatio = 16/9;
                        });
                      }, child:const Text("16:9",style: TextStyle(color: Colors.white),)),
                      
                    ),
                     Container(
                      color: aspectRatio==4/3?const Color.fromARGB(255, 71, 71, 71):Colors.transparent,
                      child: TextButton(onPressed: (){
                        setState(() {
                          aspectRatio = 4/3;
                        });
                      }, child:const Text("4:3",style: TextStyle(color: Colors.white),)),
                    ),
                     Container(
                      color: aspectRatio==1/1?const Color.fromARGB(255, 71, 71, 71):Colors.transparent,
                      child: TextButton(onPressed: (){
                        setState(() {
                          aspectRatio = 1/1;
                        });
                      }, child:const Text("1:1",style: TextStyle(color: Colors.white),)),
                    ),
                     Container(
                      color: aspectRatio==4/5?const Color.fromARGB(255, 71, 71, 71):Colors.transparent,
                      child: TextButton(onPressed: (){
                        setState(() {
                          aspectRatio =4/5;
                        });
                      }, child:const Text("4/5",style: TextStyle(color: Colors.white),)),
                    ),
                  ],
                ),
              ),
              AspectRatio(aspectRatio: aspectRatio,child: CameraPreview(_cameraController)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: FloatingActionButton(
                      heroTag: "record",
                      backgroundColor: Colors.red,
                      child: Icon(_isRecording ? Icons.stop : Icons.circle),
                      onPressed: () => _recordVideo(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: FloatingActionButton(
                      heroTag: "camera",
                      backgroundColor: const Color.fromARGB(255, 29, 29, 29),
                      child: Obx(() =>
                          InstanceMemb.videoController.isFrontCamera.value
                              ? const Icon(Icons.camera_front)
                              : const Icon(Icons.camera_rear)),
                      onPressed: () {
                        if (InstanceMemb.videoController.isFrontCamera.value) {
                          _initCamera();
                          InstanceMemb.videoController
                              .backORfron(CameraLensDirection.back, false);
                        } else {
                          _initCamera();
                          InstanceMemb.videoController
                              .backORfron(CameraLensDirection.front, true);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
