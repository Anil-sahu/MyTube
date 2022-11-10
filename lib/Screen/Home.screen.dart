import 'package:blackcoffer/widgets/VideoCard.dart';
import 'package:flutter/material.dart';

class HomScreen extends StatefulWidget {
  const HomScreen({super.key});

  @override
  State<HomScreen> createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          
      body: Container(child: ListView.builder(itemBuilder: (context,indext){
        return VideoCard();
      })),

    );
  }
}
