import 'dart:ffi';

import 'package:geolocator/geolocator.dart';

class Location {
  var longitude;
  var latitude;

 getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.low);
      print('position From Class location : $position');
      latitude = position.latitude;
      longitude = position.longitude;
    } on Exception catch (e) {
      print(e);
    }
  }
}
