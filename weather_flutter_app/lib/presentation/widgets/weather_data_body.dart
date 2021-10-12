import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter_app/business_logic/blocs/weather_bloc.dart';
import 'package:weather_flutter_app/data/models/weather_forecast.dart';
import 'package:weather_flutter_app/presentation/widgets/weather_seven_days_carousel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WeatherDataBody extends StatelessWidget {
  const WeatherDataBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherEmpty) {
              return Text("Recherchez une ville pour commencer",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 25.0));
            }
            if (state is WeatherIsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is WeatherIsLoaded) {
              return buildBodyWithData(state.forecast);
            }
            if (state is WeatherError) {
              return Text("Problème lors de la récupération des données",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 25.0));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildBodyWithData(WeatherForecast forecast) {
    return
      Column(children: [
        Center(child: createCityDataWidget(forecast)),
        Center(child: createWeatherIconWidget(forecast)),
        Center(child: createTempAndDescWidget(forecast)),
        Center(child: createCurrentWeatherDataRowWidget(forecast)),
        Center(child: createCarouselWidget(forecast))
      ]
    );
  }

  Widget createCityDataWidget(WeatherForecast forecast) {
    return Column(children: [
      Text(forecast.cityName,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.black,
              fontSize: 30.0,
              fontWeight: FontWeight.bold)),
      Text(forecast.currentWeather.dateTime,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.black, fontSize: 25.0))
    ]);
  }

  Widget createWeatherIconWidget(WeatherForecast forecast) {
    return Center(
      child: getIcon(forecast.currentWeather.weatherMain, 80),
    );
  }

  static Widget getIcon(String weather, double size) {
    switch (weather) {
      case "Clear":
        {
          return Icon(FontAwesomeIcons.sun, color: Colors.yellow, size: size);
        }
      case "Clouds":
        {
          return Icon(FontAwesomeIcons.cloud, color: Colors.grey, size: size);
        }
      case "Rain":
        {
          return Icon(FontAwesomeIcons.cloudRain,
              color: Colors.blueGrey, size: size);
        }
      case "Snow":
        {
          return Icon(FontAwesomeIcons.snowman, color: Colors.blue, size: size);
        }
      default:
        {
          return Icon(FontAwesomeIcons.sun, color: Colors.yellow, size: size);
        }
    }
  }

  Widget createTempAndDescWidget(WeatherForecast forecast) {
    return Row(children: [
      Expanded(
        child: Text(forecast.currentWeather.tempMin.toString() + "°C",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 40.0,
                fontWeight: FontWeight.bold)),
      ),
      Expanded(
        child: Text(forecast.currentWeather.weatherDesc,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 30.0)),
      )
    ]);
  }

  Widget createCurrentWeatherDataRowWidget(WeatherForecast forecast) {
    return Row(children: [
      Expanded(
        child: Text("wind : ${forecast.currentWeather.windSpeed}m/s",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      Expanded(
        child: Text("humidity : ${forecast.currentWeather.hygroLvl}%",
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black, fontSize: 20)),
      ),
      Expanded(
        child: Text("max temp : ${forecast.currentWeather.tempMax}°C",
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    ]);
  }

  Widget createCarouselWidget(WeatherForecast forecast) {
    return Weather7DaysCarousel(forecast: forecast);
  }
}
