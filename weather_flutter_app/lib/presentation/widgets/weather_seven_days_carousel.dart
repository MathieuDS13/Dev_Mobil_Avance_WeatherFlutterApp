import 'package:flutter/material.dart';
import 'package:weather_flutter_app/data/models/weather_forecast.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:weather_flutter_app/presentation/widgets/weather_data_body.dart';

class Weather7DaysCarousel extends StatelessWidget {
  final WeatherForecast forecast;

  const Weather7DaysCarousel({Key? key, required this.forecast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        child: CarouselSlider(
            items: getWeatherCards(forecast),
            options: CarouselOptions(enableInfiniteScroll: false, disableCenter: true, autoPlay: true)),
      ),
    );
  }

  List<Widget> getWeatherCards(WeatherForecast forecast) {
    List<Widget> widgets = [];
    for (Weather weather in forecast.forecast) {
      widgets.add(widgetFromWeather(weather));
    }
    return widgets;
  }

  Widget widgetFromWeather(Weather weather) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Column(
          children: [
            Text("${weather.dateTime}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            WeatherDataBody.getIcon(weather.weatherMain, 40),
            Row(children: [
              Expanded(
                child: Text("wind : ${weather.windSpeed}m/s",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              Expanded(
                child: Text("humidity : ${weather.hygroLvl}%",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 20)),
              ),
              Expanded(
                child: Text("max temp : ${weather.tempMax}°C",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ])
          ],
        ),
        width: 200,
        height: 200,
          decoration: BoxDecoration(
              color: Colors.lightBlue, border: Border.all(color: Colors.black))
      ),
    );
  }
}
