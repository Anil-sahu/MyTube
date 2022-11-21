import 'package:blackcoffer/controller/instance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 255, 255),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              // color: Colors.blue,
              child: IconButton(
                onPressed: () {
                  InstanceMemb.videoController.updatepageCurrentIndex(0);
                },
                icon: Obx(() =>
                    InstanceMemb.videoController.pagecurrentIndex.value == 0
                        ? const Icon(Icons.home_rounded,color: Color.fromARGB(255, 56, 56, 56),)
                        : const Icon(Icons.home_outlined,color: Color.fromARGB(255, 63, 63, 63),)),
              ),
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.red,
              child: IconButton(
                onPressed: () {
                  InstanceMemb.videoController.updatepageCurrentIndex(1);
                },
                icon: Obx(() =>
                    InstanceMemb.videoController.pagecurrentIndex.value == 1
                        ? const Icon(Icons.person_rounded,color: Color.fromARGB(255, 63, 63, 63),)
                        : const Icon(Icons.person_outline,color: Color.fromARGB(255, 51, 51, 51),)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
