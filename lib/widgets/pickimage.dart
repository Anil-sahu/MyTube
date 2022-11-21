import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

   class ImagePickerClass{

  var fileUrl;
  var imageNetwork;
  var url;
  var image;


  Future getImages() async {
    
    var _picker = ImagePicker();
    var img = await _picker.pickImage(
      source: ImageSource.gallery,
    );
 
      image = File(img!.path);

  }



// pickimages(context) async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             backgroundColor: Colors.white,
//             title: const Text("Pick image from"),
//             // content: Text("Pick from any one"),
//             actions: [
//               //   color: backColor[200],
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         var camera = "camera";
//                         getImages(camera);
//                         Navigator.of(context).pop();
//                       },
//                       icon: Icon(
//                         Icons.camera_alt,
//                         size: 45,
//                         color:Colors.black,
//                       )),
//                   IconButton(
//                       onPressed: () {
//                         var camera = "gallery";
//                         getImages(camera);
//                         Navigator.of(context).pop();
//                       },
//                       icon: Icon(
//                         Icons.image,
//                         size: 45,
//                         color:Colors.red,
//                       )),
//                 ],
//               ),
//             ],
//           );
//         });
//   }



//   uploadImage(context, index,currentId) async {
//     List<dynamic> files = [];
//     var storeImage = FirebaseStorage.instance
//         .ref()
//         .child("Users")
//        .child(currentId.id)
//         .child(image.path);
//     UploadTask uploadImages = storeImage.putFile(image);
//     fileUrl = await (await uploadImages).ref.getDownloadURL();

//     url = fileUrl.toString();
//     files.add(url);
 
// // FirebaseFirestore.instance.collection("Users").doc(currentId).update({"profile":files[index]});
 
//   }

}
// // 
//   // Future<void> _delete(String ref) async {
//   //   await storage.ref(ref).delete();
//   //   // Rebuild the UI
//   //   setState(() {});
//   // }




