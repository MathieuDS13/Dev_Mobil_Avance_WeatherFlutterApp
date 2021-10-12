import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_flutter_app/data/models/weather_forecast.dart';
import 'package:weather_flutter_app/data/repositories/weather_forecast_repository.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherForecastRepository repository = WeatherForecastRepository();

  WeatherBloc(WeatherState initialState) : super(initialState);

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherIsLoading();
      try {
        final WeatherForecast forecast =
            await repository.getForecast(event.cityName);
        yield WeatherIsLoaded(forecast: forecast);
      } on Exception catch (exception, stack) {
        print("DANS BLOC  " + exception.toString() + "\n" + stack.toString());
        yield WeatherError();
      }
    }
  }
}
