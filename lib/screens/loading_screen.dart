
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weathermap/screens/location_screen.dart';
import 'package:weathermap/services/location.dart';
import 'package:weathermap/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    requestPermissionLocation();
  }

  requestPermissionLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      const Dialog(
        child: Text("الرجاء تشغيل خدمه تحديد الموقع"),
      );
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        const Dialog(
          child: Text("الرجاء اعطاء صلاحية الموقع للتطبيق"),
        );
      }
    }
    if (permission == LocationPermission.deniedForever) {
      const Dialog(
        child: Text("الرجاء اعطاء صلاحية الموقع للتطبيق"),
      );
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      getLocation();
    }
  }

  void getLocation() async {
    Location location = Location();
    await location.getLocation();
    print('lat : ${location.latitude}');
    print('log : ${location.longitude}');
setState(() {
  
});
    // Get JSON Datar
    NetworkHelber helber = NetworkHelber(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=9588c2e9b46b2b04bed00971cf3b8108');
    var weatherData = await helber.getData();
    // print('weatherData From getLocation : >>>>> $weatherData');

    // Call LocationScreen
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(
            locationWeather: weatherData,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100,
      ),
    );
  }
}
