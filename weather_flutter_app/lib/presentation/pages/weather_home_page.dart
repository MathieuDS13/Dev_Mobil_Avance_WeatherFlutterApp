import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter_app/business_logic/blocs/weather_bloc.dart';
import 'package:weather_flutter_app/presentation/widgets/weather_data_body.dart';
import 'package:weather_flutter_app/presentation/widgets/weather_search_bar.dart';
import 'package:weather_flutter_app/presentation/widgets/weather_seven_days_carousel.dart';

class WeatherHomePage extends StatelessWidget {
  const WeatherHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(WeatherEmpty()),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
            child: Scaffold(
              extendBodyBehindAppBar: false,
              body: Column(
                children: [WeatherSearchBar(), WeatherDataBody()],
              ),
            )),
      ),
    );
  }
}
