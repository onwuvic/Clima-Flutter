import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

const apiKey = '778d14d35550cecd2866a95a1240bfa0';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();

    latitude = location.latitude;
    longitude = location.longitude;

    getData();
  }

  void getData() async {
    String url = 'https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02';
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      double temp = decodedData['main']['temp'];
      int cond = decodedData['weather'][0]['id'];
      String city = decodedData['name'];

      print(temp);
      print(cond);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
