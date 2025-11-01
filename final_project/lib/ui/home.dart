import 'dart:convert';

import 'package:final_project/models/city.dart';
import 'package:final_project/models/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      'http://api.weatherapi.com/v1/current.json?key=API&q='; //to get weather details

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
    });

    print("Current weather data: ${result['current']}");
    print("Temperature: $temperature°C");
    print("Max Temp: $maxTemp°C");
    print("Weather State: $weatherStateName");
    print("Humidity: $humidity%");
    print("Wind Speed: $windSpeed km/h");
  }

  @override
  void initState() {
    fetchLocation(cities[0]); // Fetch weather for London
    fetchWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Home Page')));
  }
}
