import 'package:blackcoffer/controller/instance.dart';
import 'package:blackcoffer/widgets/VideoCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
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
  var search = "";

  late Future<dynamic> videoList;
  @override
  void initState() {
    InstanceMemb.videoController.getAllVideos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        // backgroundColor: Color.fromARGB(236, 48, 47, 47),
        appBar: PreferredSize(
          preferredSize: const Size(12, 50),
          child: Obx(
            () => InstanceMemb.videoController.isSearch.value
                ? Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 100,
                          height: 50,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                filled: true,
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    InstanceMemb.videoController
                                        .isSearchUpdate(false);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Color.fromARGB(255, 170, 170, 170),
                                    size: 30,
                                  ),
                                ),
                                hintText: "search...",
                                suffixIcon: const Icon(
                                  Icons.close,
                                  size: 25,
                                  color: Color.fromARGB(255, 173, 173, 173),
                                ),
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 155, 155, 155),
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal),
                                fillColor:
                                    const Color.fromARGB(59, 238, 237, 237)),
                            cursorColor:
                                const Color.fromARGB(255, 56, 108, 185),
                            cursorWidth: 4,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            onChanged: (value) {
                              setState(() {
                                search = value;
                              });
                            },
                          ),
                        ),
                        const Text(
                          "Filter",
                          style: TextStyle(
                              color: Color.fromARGB(255, 66, 66, 66),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
        ),
        body: StreamBuilder(
          stream: _usersStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(Icons.error),
                    Text("Something is wrong")
                  ],
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text("progress..."),
                    CircularProgressIndicator(),
                  ],
                ),
              );
            }

            if (snapshot.hasData) {
              return AnimationLimiter(
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: ((context, index) {
                      if (snapshot.data!.docs[index]['title']
                              .toLowerCase()
                              .contains(search.toLowerCase()) ||
                          snapshot.data!.docs[index]['category']
                              .toLowerCase()
                              .contains(search.toLowerCase())) {
                        return AnimationConfiguration.staggeredList(
                           position: index,
            duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                             horizontalOffset: 100.0,
                             delay: Duration(seconds: index),
                            
                            child:  FadeInAnimation(
                              duration: Duration(seconds: index),
                             
                         

                              child: VideoCard(
                                  data: snapshot.data!.docs[index], index: index),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    })),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
