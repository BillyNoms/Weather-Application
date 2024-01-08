import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_clima_flutter/services/location.dart';
import 'package:test_clima_flutter/screens/location_screen.dart';



class Networking{
  Future<String> getData() async{
    Location location = Location();
    await location.getLocation();
    double lat = location.lat;
    double lon = location.lon;
    double temp;
    String appId = '43c3dd71d922d205f7ad5a6b18f5675c';
    int id;
    String city,desc,data;
    Uri url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appId&units=metric');
    Response response = await get(url);
    data = response.body;
    if (response.statusCode == 200){
      return data;
    }else{
      return "Error";
    }
  }
}