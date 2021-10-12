part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherEmpty extends WeatherState {}

class WeatherIsLoading extends WeatherState {}

class WeatherIsLoaded extends WeatherState {
  final WeatherForecast forecast;

  WeatherIsLoaded({required this.forecast});
}

class WeatherError extends WeatherState {}
