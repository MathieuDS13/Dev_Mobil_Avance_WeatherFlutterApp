class WeatherForecast {
  Weather currentWeather;
  List<Weather> forecast = [];
  String cityName;

  WeatherForecast.name(this.currentWeather, this.forecast, this.cityName);

  WeatherForecast(this.currentWeather, this.forecast, this.cityName);

  addWeatherToList(Weather weather) {
    forecast.add(weather);
  }
}

class Weather {
  String dateTime;
  double tempMin;
  double tempMax;
  double windSpeed;
  String weatherMain;
  String weatherDesc;
  int hygroLvl;

  Weather(this.dateTime, this.tempMin, this.tempMax, this.windSpeed,
      this.weatherMain, this.weatherDesc, this.hygroLvl);

  Weather.name(this.dateTime, this.tempMin, this.tempMax, this.windSpeed,
      this.weatherMain, this.weatherDesc, this.hygroLvl);
}
