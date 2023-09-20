// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:weathermap/services/networking.dart';
import 'package:weathermap/utilities/constants.dart';

// ignore: must_be_immutable
class CityScreen extends StatefulWidget {
  var locWeather;
  var cityNme;
  CityScreen({
    Key? key,
    required this.locWeather,
    required this.cityNme,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String? cityName;
  var temp;
  var temptature;
  double? respons;

  @override
  void initState() {
    super.initState();
    temp = widget.locWeather['main']['temp'];
    temptature = temp.toInt();
    widget.cityNme = widget.locWeather['name'];
    print("Temp =========================================  $temp ");
    print("Temptature  ================================ $temptature ");
    //cityName = widget.locWeather['name'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 30.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  onChanged: (value) {
                    cityName = value;
                    setState(() {});
                    print(
                        "cityName ================================== $cityName");
                  },
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.white,
                    ),
                    hintText: 'Enter City Name',
                    hintStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  print("cityName ============================== $cityName");

                  NetworkHelber helber = NetworkHelber(
                      'https://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=9588c2e9b46b2b04bed00971cf3b8108');
                  var weatherData = await helber.getData();
                  //respons = weatherData['main']['temp'];
                  // print("===============  $respons   ========dd===== ");
                  // https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}
                  // Net Helber
                  // URL City NAme
                  // Json
                  // Temp
                  respons = weatherData['main']['temp'];
                  setState(() {});
                },
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Text(
                "City: ${cityName ?? widget.cityNme}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Temptature: ${respons ?? temptature.toString()}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
