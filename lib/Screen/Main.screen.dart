import 'package:blackcoffer/Screen/Home.screen.dart';
import 'package:blackcoffer/Screen/Camera.screen.dart';
import 'package:blackcoffer/service/location.service.dart';
import 'package:blackcoffer/widgets/bottumNavBar.component.dart';
import 'package:blackcoffer/controller/instance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> pageList = [const HomScreen(), const Center(child: Text("Not implemented"),)];
  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 233, 233),
      appBar: PreferredSize(
        preferredSize: const Size(100, 60),
        child: 
           AppBar(
            elevation: 0,
                  title: const Text("BlackCoffer",style: TextStyle(color: Color.fromARGB(255, 22, 22, 22),fontWeight: FontWeight.bold),),
                  leading: Image.asset('assets/logo.png'),
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  actions: [
                    IconButton(
                        onPressed: () {
                          InstanceMemb.videoController.isSearchUpdate(true);
                        }, icon:  Obx(()=>InstanceMemb.videoController.isSearch.value?const SizedBox(): const Icon(Icons.search_rounded,color: Color.fromARGB(255, 59, 59, 59),))),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.notifications,color: Color.fromARGB(255, 61, 61, 61),)),
                    Container(
                      margin: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(shape: BoxShape.circle,color: Color.fromARGB(255, 1, 107, 247)),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.person_rounded,color: Color.fromARGB(255, 61, 61, 61),)),
                    )
                  ],
                ),
        
      ),

  
      body:
          Obx(() => pageList[InstanceMemb.videoController.pagecurrentIndex.value]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GPService gps = GPService();
          gps.getLocation();
          Get.to(() => const CameraPage());
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
