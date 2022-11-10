import 'package:blackcoffer/Screen/Home.screen.dart';
import 'package:blackcoffer/Screen/Video.screen.dart';
import 'package:blackcoffer/Screen/Camera.screen.dart';
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
  
  List<Widget> pageList =[const HomScreen(),const PlayVideoScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
                appBar: PreferredSize(
        preferredSize:  const Size(100, 160),
        child: Card(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "BlackCoffer",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 77, 76, 76)
                          ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                          color: Color.fromARGB(255, 92, 91, 91),
                        ))
                  ],
                ),
              ),
        
        
           //---------------------Search TextField-----------------------------//         
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 100,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30,
                          ),
                          hintText: "Search",
                          suffixIcon: Icon(
                            Icons.close,
                            size: 25,
                            color: Colors.white,
                          ),
                          hintStyle: TextStyle(color: Colors.white, fontSize: 20),
                          fillColor: Color.fromARGB(255, 238, 237, 237)),
                      cursorColor: const Color.fromARGB(255, 56, 108, 185),
                      cursorWidth: 4,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text("Filter",style: TextStyle(color: Color.fromARGB(255, 77, 76, 76),fontSize: 20,fontWeight: FontWeight.bold),)
                ],
              ),
              const Divider(
              )
            ],
          ),
        ),
      ),
      body: Obx(()=> pageList[InstanceMemb.videoController.currentIndex.value]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.to(()=>CameraPage());
      },child: Icon(Icons.add),),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}