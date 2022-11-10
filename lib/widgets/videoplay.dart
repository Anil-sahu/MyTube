import 'package:flutter/material.dart';

class PlyCard extends StatefulWidget {
  const PlyCard({super.key});

  @override
  State<PlyCard> createState() => _PlyCardState();
}

class _PlyCardState extends State<PlyCard> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            height: 300,
            color: const Color.fromARGB(255, 218, 218, 218),
          ),
          IconButton(
            icon: const Icon(
              Icons.play_arrow_rounded,
              size: 80,
            ),
            onPressed: () {},
          )
        ],
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "There is a title of video",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.thumb_up,
                  size: 16,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("23k"),
                )
              ],
            ),
            Row(
              children: const [
                Icon(
                  Icons.thumb_down,
                  size: 16,
                  color: Colors.grey,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("23k"),
                )
              ],
            ),
            Row(
              children: const [
                Icon(
                  Icons.share,
                  color: Colors.grey,
                  size: 16,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Share"),
                )
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: const [
            Text("23.4k views"),
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text("1 year ago"),
            )
          ],
        ),
      ),
      const Divider(),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Text("A"),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "UaerName",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.only(right: 20),
            child: const Text(
              "View all Video",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ))
      ])
    ]);
  }
}
