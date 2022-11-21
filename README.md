# yt

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


<!-- 

  showStickyFlexibleBottomSheet(
                minHeight: 0,
                initHeight: 0.8,
                maxHeight: 1,
                 headerHeight:300,
                bottomSheetColor: Colors.red,
                context: context,
                headerBuilder: (BuildContext context, double offset) {
                  return AspectRatio(
                    aspectRatio: vds.videoPlayerController.value.aspectRatio,
                    child: VideoPlayer(vds.videoPlayerController)
                  );
                },
                bodyBuilder: (BuildContext context, double offset) {
                  return SliverChildListDelegate(
                    <Widget>[
                      Container(height: 100,width: 200,color: Color.fromARGB(255, 153, 247, 3),),
                       Container(height: 100,width: 200,color: Colors.yellow,),
                        Container(height: 100,width: 200,color: Color.fromARGB(255, 255, 170, 59),),
                        Container(height: 100,width: 200,color: Color.fromARGB(255, 153, 247, 3),),
                       Container(height: 100,width: 200,color: Colors.yellow,),
                        Container(height: 100,width: 200,color: Color.fromARGB(255, 255, 170, 59),)
                    ],
                  );
                },
                anchors: [0, 0.5, 1],
              ); -->