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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            InstanceMemb.videoController.updateCurrentIndex(0);
          },
          icon: Obx(() =>
              InstanceMemb.videoController.currentIndex.value == 0
                  ? const Icon(Icons.home_rounded)
                  : const Icon(Icons.home_outlined)),
        ),
        IconButton(
          onPressed: () {
            InstanceMemb.videoController.updateCurrentIndex(1);
          },
          icon: Obx(() =>
              InstanceMemb.videoController.currentIndex.value == 1
                  ? const Icon(Icons.person_rounded)
                  : const Icon(Icons.person_outline)),
        )
      ],
    );
  }
}
