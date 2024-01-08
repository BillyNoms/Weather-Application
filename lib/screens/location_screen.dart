import 'package:flutter/material.dart';
import 'package:test_clima_flutter/utilities/constants.dart';
import 'dart:convert';
import 'package:test_clima_flutter/services/weather.dart';
import 'package:test_clima_flutter/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.data, {super.key});
  String data;
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double temp = 0;
  String city = '',info='',weatherIcon='',getMessage='';
  late String newCity;
  int id = 0;
  @override
  void initState() {
    super.initState();
    info = widget.data;
    updateUI();
  }

  void updateUI(){
    if (info == 'Error'){
      setState(() {
      });
    }else{
      setState(() {
        city = jsonDecode(info)['name'];
        temp = jsonDecode(info)['main']['temp'];
        id = jsonDecode(info)['weather'][0]['id'];

        print(city);
        print(temp);
        print(id);

        WeatherModel weatherModel = WeatherModel();
        weatherIcon = weatherModel.getWeatherIcon(id);
        getMessage = weatherModel.getMessage(temp.toInt());
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      info = widget.data;
                      updateUI();
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async{
                      info = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return const CityScreen();
                      }));
                      print(info);
                      updateUI();
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
               Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      upperPart(),
                      style: kTempTextStyle,
                    ),
                     Text(
                      emoji(),
                       style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  bottomPart(),
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String upperPart() {
      if (info == 'Error'){
        return 'Error';
      }else{
        return '${temp.toStringAsFixed(0)}°';
      }
    }
    String emoji(){
      if (info == 'Error'){
        return '';
      }else{
        return weatherIcon;
      }
    }
    String bottomPart(){
      if (info == 'Error'){
        return 'Cannot find data in city';
      }else{
        return "${getMessage} in $city!";
      }
    }
}
