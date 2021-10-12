import 'dart:convert';

import 'package:weather_flutter_app/data/models/weather_model.dart';
import 'package:http/http.dart';

class Network {

  final String apiKey = "10a0ef9d4a88de196efd259d445ad12c";

  Future<WeatherModel> getWeatherForecast({required String cityName}) async {
    var finalUrl = "https://api.openweathermap.org/data/2.5/forecast?q=" +
        cityName +
        "&units=metric&appid=" +
        apiKey;

    final response = await get(Uri.parse(finalUrl));
    print("URL: ${Uri.encodeFull(finalUrl)}");

    if (response.statusCode == 200) {
      print("weather data : ${response.body}");
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error getting weather forecast");
    }
  }
}
