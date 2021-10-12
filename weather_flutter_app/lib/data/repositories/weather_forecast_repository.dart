import 'package:flutter/material.dart';
import 'package:weather_flutter_app/data/dataproviders/network.dart';
import 'package:weather_flutter_app/data/models/weather_forecast.dart';
import 'package:weather_flutter_app/data/models/weather_model.dart';
import 'package:intl/intl.dart';

class WeatherForecastRepository {
  Network network = Network();

  WeatherForecastRepository();

  Future<WeatherForecast> getForecast(String cityName) async {
    try {
      WeatherModel model = await network.getWeatherForecast(cityName: cityName);
      return getWeatherForecastFromModel(model);
    } on Exception catch (exception, stack) {
      print("EXCEPTION DANS REPOSITORY " + exception.toString() + "\n" + stack.toString());
      rethrow;
    }
  }

  WeatherForecast getWeatherForecastFromModel(WeatherModel model) {
    String? cityName = model.city!.name;
    Weather current = getCurrentWeather(model);
    List<Weather> forecastWeathers = getForecastWeathers(model);
    return WeatherForecast(current, forecastWeathers, cityName!);
  }

  Weather getCurrentWeather(WeatherModel model) {
    var inputFormat = DateFormat('yyyy-mm-dd HH:mm:ss');
    var inputDate =
        inputFormat.parse(model.list![0]!.dtTxt!); // <-- dd/MM 24H format

    var outputFormat = DateFormat('dd/MM/yyyy hh:mm');
    var outputDate = outputFormat.format(inputDate);

    return Weather(
        outputDate,
        model!.list![0]!.main!.tempMin!,
        model!.list![0]!.main!.tempMax!,
        model!.list![0]!.wind!.speed!,
        model!.list![0]!.weather![0]!.main!,
        model!.list![0]!.weather![0]!.description!,
        model!.list![0]!.main!.humidity!);
  }

  List<Weather> getForecastWeathers(WeatherModel model) {
    List<Weather> forecastWeathers = [];
    print(model.list!.length);
    for (int i = 1; i < model.list!.length; i++) {
      var inputFormat = DateFormat('yyyy-mm-dd HH:mm:ss');
      var inputDate =
          inputFormat.parse(model.list![i]!.dtTxt!); // <-- dd/MM 24H format

      var outputFormat = DateFormat('dd/MM/yyyy hh:mm');
      var outputDate = outputFormat.format(inputDate);
      forecastWeathers.add(Weather(
          outputDate,
          model!.list!.elementAt(i)!.main!.tempMin!,
          model!.list!.elementAt(i)!.main!.tempMax!,
          model!.list!.elementAt(i)!.wind!.speed!,
          model!.list!.elementAt(i)!.weather![0]!.main!,
          model!.list!.elementAt(i)!.weather![0]!.description!,
          model!.list!.elementAt(i)!.main!.humidity!));
    }
    return forecastWeathers;
  }
}
