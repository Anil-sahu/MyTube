import 'package:blackcoffer/controller/instance.dart';
import 'package:blackcoffer/model/video.model.dart';
import 'package:blackcoffer/widgets/VideoCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomScreen extends StatefulWidget {
  const HomScreen({super.key});

  @override
  State<HomScreen> createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {
  FirebaseFirestore auth = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('post').snapshots();

  late Future<dynamic> videoList;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: StreamBuilder(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Something is wrong"),
            );
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text("There are no error"),
            );
          }
          if (snapshot.data != null) {
            // print
            // print(snapshot.data!.docs.length);
            InstanceMemb.videoController.getVideo(snapshot.data!.docs);
            print(InstanceMemb.videoController.videos);
            return ListView.builder(
                itemCount: InstanceMemb.videoController.videos.length,
                itemBuilder: ((context, index) {
                  return Obx(()=>
            VideoCard(
                      data: InstanceMemb.videoController.videos[index],
                     
                    ),
                  );
                }));
            //   return ListView(
            //       children: snapshot.data!.docs.map((DocumentSnapshot e) {
            //     Map<String, dynamic> data = e.data() as Map<String, dynamic>;
            //     var id = e.id;
            //     return  VideoCard(data: data,id:e.id);
            //   }).toList());
            // }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
