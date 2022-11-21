// ignore: file_names
import 'package:blackcoffer/Screen/Video.screen.dart';
import 'package:blackcoffer/controller/instance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class VideoCard extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var data;
   int index;
  VideoCard({super.key, required this.data,required this.index});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              InstanceMemb.videoController.updateCurrentIndex(widget.index);
              Get.to(() => PlayVideoScreen( ));
            },
            child: AspectRatio(
              aspectRatio: 16 / 9,
              // color: const Color.fromARGB(255, 233, 233, 233),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.data['thumbnail']),
                        fit: BoxFit.cover)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 87, 85, 85),
                radius: 15,
                child:
                    Text(widget.data['username'][0].toString().toUpperCase()),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              clipBehavior: Clip.hardEdge,
                              decoration: const BoxDecoration(),
                              padding: const EdgeInsets.only(top:8.0,left: 12),
                              child: Text(
                                widget.data['title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color.fromARGB(255, 43, 43, 43)),
                              ),
                            ),
                            Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 50,
                                clipBehavior: Clip.hardEdge,
                                decoration: const BoxDecoration(),
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
                                                80,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: const BoxDecoration(),
                                        child: Text(
                                          widget.data['location'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left:12.0,bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.data['username'],style: TextStyle(color: Colors.grey,fontSize: 16,),),
                          Text("${widget.data["views"]['countView']} Views",style: TextStyle(color: Colors.grey,fontSize: 12,),),
                          Text(InstanceMemb.videoController
                              .timeAgo(widget.data['postDate'].toDate()),style: TextStyle(color: Colors.grey,fontSize: 12,),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
