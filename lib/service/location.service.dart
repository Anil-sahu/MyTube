
import 'dart:async';

import 'package:blackcoffer/controller/instance.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GPService{  
  var lat, long, address;
  
  late StreamSubscription<Position> streamSubscription;
  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
     await Geolocator.requestPermission();
      return Future.error("Location is disable");
    }
    permission = await Geolocator.checkPermission();
    if (permission == await LocationPermission.denied) {
     await Geolocator.requestPermission();
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
       await Geolocator.requestPermission();
        return Future.error("Location permistion is denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Geolocator.openLocationSettings();
      return Future.error(
          "Location permissions are permanently denied we can not request permission");
    }

    Geolocator.getPositionStream().listen((event) {
      lat = event.latitude;
      long = event.longitude;
      getAddress(event);
    });
  }

  Future getAddress(Position position) async {
    try{
  List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemark[0];
   
    InstanceMemb.videoController.getLocation( "${place.locality} (${place.administrativeArea})");
    }catch(error){
      // ignore: avoid_print
      print(error.toString());

    }
  
    
    
   
  }


}