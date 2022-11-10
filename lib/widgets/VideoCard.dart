import 'package:blackcoffer/Screen/Video.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({super.key});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              Get.to(()=>const PlayVideoScreen());
            },
            child: Container(
              height: 300,
              color: const Color.fromARGB(255, 233, 233, 233),
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Title of Video Here"),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("UserName"),
                      const Text("23K Veiw"),
                      const Text("2year ago")
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
