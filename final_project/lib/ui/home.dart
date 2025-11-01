import 'dart:convert';

import 'package:final_project/models/city.dart';
import 'package:final_project/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Constants myConstants = Constants();

  int temperature = 0;
  int maxTemp = 0;
  String weatherStateName = 'Loading...';
  int humidity = 0;
  int windSpeed = 0;

  var currentDate = 'Loading...';
  String imageUrl = '';
  String location = 'London'; //Our default city

  //get the cities and selected cities data
  var selectedCities = City.getSelectedCities();
  List<String> cities = [
    'London',
  ]; // the list hold our default selected city is london

  List consolidatedWeatherList = []; //To hold our weather data after api call

  //Api calls url - Updated for WeatherAPI.com
  String searchWeatherUrl =
      'http://api.weatherapi.com/v1/current.json?key=de053dd9eaf248c2b5b145330253010&q='; //to get weather details

  //Get the weather data - Updated for WeatherAPI.com
  void fetchLocation(String location) async {
    var weatherResult = await http.get(Uri.parse(searchWeatherUrl + location));

    var result = json.decode(weatherResult.body);
    var locationName = result['location']['name'];

    setState(() {
      this.location = locationName ?? location;
    });

    print("Updated location variable: ${this.location}");
  }

  void fetchWeatherData() async {
    var weatherResult = await http.get(Uri.parse(searchWeatherUrl + location));
    var result = json.decode(weatherResult.body);

    // WeatherAPI.com doesn't have 'consolidated_weather', use 'current' directly
    setState(() {
      temperature = result['current']['temp_c']?.round() ?? 0;
      maxTemp =
          result['current']['temp_c']?.round() ?? 0; // Current temp as max temp
      weatherStateName = result['current']['condition']['text'] ?? 'Unknown';
      humidity = result['current']['humidity'] ?? 0;
      windSpeed = result['current']['wind_kph']?.round() ?? 0;

      var myDate = DateTime.parse(result['location']['localtime']);
      currentDate = DateFormat('EEEE, MMM d, y').format(myDate);

      imageUrl = 'https:${result['current']['condition']['icon']}';

      consolidatedWeatherList = [result['current']];
    });
  }

  @override
  void initState() {
    fetchLocation(cities[0]); // Fetch weather for London
    fetchWeatherData();
    super.initState();

    for (int i = 0; i < selectedCities.length; i++) {
      cities.add(selectedCities[i].city);
    }
  }

  //Create a shader linear gradient
  final Shader linearGradient = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Our profile image
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset('assets/profile.png', width: 40, height: 40),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/pin.png', width: 20),
                  const SizedBox(width: 4),
                  DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: location,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: cities.map((String location) {
                        return DropdownMenuItem(
                          value: location,
                          child: Text(location),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          location = newValue!;
                          fetchLocation(location);
                          fetchWeatherData();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            Text(
              currentDate,
              style: const TextStyle(color: Colors.grey, fontSize: 16.0),
            ),
            const SizedBox(height: 50),

            Container(
              width: size.width,
              height: 200,
              decoration: BoxDecoration(
                color: myConstants.primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
